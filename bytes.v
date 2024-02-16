module vom

// Based on https://docs.rs/nom/7.1.3/nom/bytes/complete/index.html

// Matches a byte string with escaped characters.
// The first argument matches the `normal` characters (it must not accept the control character)
// The second argument is the `control_char` (like \ in most languages)
// The third argument matches the escaped characters

pub fn escaped(normal Fn, control_char rune, escapable Fn) Fn {
	return fn [normal, control_char, escapable] (input string) !(string, string, int) {
		check_control_char := tag(control_char.str())
		a, b, len1 := normal(input) or { input, '', 0 }
		c, d, len2 := check_control_char(a) or { a, '', 0 }
		e, f, len3 := escapable(c) or { c, '', 0 }
		g, h, len4 := normal(e) or { e, '', 0 }

		if input == g {
			return error('`escaped` fail')
		}
		return g, b + d + f + h, len1 + len2 + len3 + len4
	}
}

// Returns the longest slice that matches any character in the `pattern`.
pub fn is_a(pattern string) Fn {
	return fn [pattern] (input string) !(string, string, int) {
		for i, c in input {
			if !pattern.bytes().any(it == c) {
				return input[i..], input[..i], i
			}
		}
		return error('`is_a` failed with pattern `${pattern}` on input `${input}`')
	}
}

// Parse till certain characters are met.
pub fn is_not(pattern string) Fn {
	return fn [pattern] (input string) !(string, string, int) {
		for i, c in input {
			if pattern.bytes().any(it == c) {
				return input[i..], input[..i], i
			}
		}
		return error('`is_not` failed with pattern `${pattern}` on input `${input}`')
	}
}

// Recognizes a `pattern`.
pub fn tag(pattern string) Fn {
	return fn [pattern] (input string) !(string, string, int) {
		if input.len < pattern.len {
			return error('`tag` failed because input `${input}` is shorter than pattern `${pattern}`')
		}
		if input[..pattern.len] == pattern {
			return input[pattern.len..], input[..pattern.len], pattern.len
		} else {
			return error('`tag` failed because `${input}[..${pattern.len}]` is not equal to pattern `${pattern}`')
		}
	}
}

// Recognizes a case insensitive `pattern`.
pub fn tag_no_case(pattern string) Fn {
	return fn [pattern] (input string) !(string, string, int) {
		if input.len < pattern.len {
			return error('`tag_no_case` failed because input `${input}` is shorter than pattern `${pattern}`')
		}
		if input[..pattern.len].to_lower() == pattern.to_lower() {
			return input[pattern.len..], input[..pattern.len], pattern.len
		} else {
			return error('`tag_no_case` failed because `${input}[..${pattern.len}].to_lower()` is not equal to pattern `${pattern}`')
		}
	}
}

// Returns an input slice containing the first `n` input elements (Input[..`n`]).
pub fn take(n int) Fn {
	return fn [n] (input string) !(string, string, int) {
		if input.len < n {
			return error('`take` failed with count `${n}` on input `${input}`')
		} else {
			return input[n..], input[..n], n
		}
	}
}

// Returns the longest input slice (if any) till a predicate `condition` is met.
pub fn take_till(condition fn (u8) bool) Fn {
	return fn [condition] (input string) !(string, string, int) {
		for i, c in input.bytes() {
			if condition(c) {
				return input[i..], input[..i], i
			}
		}
		return error('`take_till` failed on input `${input}`')
	}
}

// Returns the longest (at least 1) input slice till a predicate `condition` is met.
pub fn take_till1(condition fn (u8) bool) Fn {
	return fn [condition] (input string) !(string, string, int) {
		for i, c in input.bytes() {
			if condition(c) && i > 0 {
				return input[i..], input[..i], i
			}
		}
		return error('`take_till1` failed on input `${input}`')
	}
}

// Returns the input slice up to the first occurrence of the `pattern`.
pub fn take_until(pattern string) Fn {
	return fn [pattern] (input string) !(string, string, int) {
		for i := 0; i + pattern.len <= input.len; i++ {
			if input[i..i + pattern.len] == pattern {
				return input[i..], input[..i], i
			}
		}
		return error('`take_until` failed on input `${input}` with pattern `${pattern}`')
	}
}

// Returns the non empty input slice up to the first occurrence of the `pattern`.
pub fn take_until1(pattern string) Fn {
	return fn [pattern] (input string) !(string, string, int) {
		for i := 1; i + pattern.len <= input.len; i++ {
			if input[i..i + pattern.len] == pattern {
				return input[i..], input[..i], i
			}
		}
		return error('`take_until1` failed on input `${input}` with pattern `${pattern}`')
	}
}

// Returns the longest input slice (if any) that matches the predicate `condition`.
pub fn take_while(condition fn (u8) bool) Fn {
	return fn [condition] (input string) !(string, string, int) {
		for i, c in input.bytes() {
			if !condition(c) {
				return input[i..], input[..i], i
			}
		}
		return '', input, input.len
	}
}

// Returns the longest (at least 1) input slice that matches the predicate `condition`.
pub fn take_while1(condition fn (u8) bool) Fn {
	return fn [condition] (input string) !(string, string, int) {
		for i, c in input.bytes() {
			if !condition(c) {
				if i == 0 {
					return error('`take_while` failed on input `${input}` because it returned empty')
				}
				return input[i..], input[..i], i
			}
		}
		return '', input, input.len
	}
}

// Returns the longest (m <= len <= n) input slice that matches the predicate `condition`.
pub fn take_while_m_n(m int, n int, condition fn (u8) bool) Fn {
	return fn [m, n, condition] (input string) !(string, string, int) {
		mut longest := -1
		for i, c in input.bytes() {
			len := i + 1
			if condition(c) && m <= len {
				longest = len
			}
			if len == n {
				break
			}
		}
		if longest != -1 {
			return input[longest..], input[..longest], longest
		} else {
			return error('`take_while_m_n` failed on input `${input}` with m `${m}` and n `${n}`')
		}
	}
}
