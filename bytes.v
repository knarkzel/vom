module vom

// Based on https://docs.rs/nom/latest/nom/bytes/complete/index.html

// Returns the longest slice that matches any character in the pattern.
pub fn is_a(pattern string) Fn {
	return fn [pattern] (input string) ?(string, string) {
		for i, c in input {
			if !pattern.bytes().any(it == c) {
				return input[i..], input[..i]
			}
		}
		return error('`is_a` failed with pattern `$pattern` on input `$input`')
	}
}

// Parse till certain characters are met.
pub fn is_not(pattern string) Fn {
	return fn [pattern] (input string) ?(string, string) {
		for i, c in input {
			if pattern.bytes().any(it == c) {
				return input[i..], input[..i]
			}
		}
		return error('`is_not` failed with pattern `$pattern` on input `$input`')
	}
}

// Recognizes a pattern.
pub fn tag(pattern string) Fn {
	return fn [pattern] (input string) ?(string, string) {
		if input.len < pattern.len {
			return error('`tag` failed because input `$input` is shorter than pattern `$pattern`')
		}
		if input[..pattern.len] == pattern {
			return input[pattern.len..], input[..pattern.len]
		} else {
			return error('`tag` failed because `$input[..pattern.len]` is not equal to pattern `$pattern`')
		}
	}
}

// Recognizes a case insensitive pattern.
pub fn tag_no_case(pattern string) Fn {
	return fn [pattern] (input string) ?(string, string) {
		if input.len < pattern.len {
			return error('`tag_no_case` failed because input `$input` is shorter than pattern `$pattern`')
		}
		if input[..pattern.len].to_lower() == pattern {
			return input[pattern.len..], input[..pattern.len]
		} else {
			return error('`tag_no_case` failed because `$input[..pattern.len].to_lower()` is not equal to pattern `$pattern`')
		}
	}
}

// Returns an input slice containing the first N input elements (Input[..N]).
pub fn take(count int) Fn {
	return fn [count] (input string) ?(string, string) {
		if input.len < count {
			return error('`take` failed with count `$count` on input `$input`')
		} else {
			return input[count..], input[..count]
		}
	}
}

// Returns the longest input slice (if any) till a predicate is met.
pub fn take_till(condition fn (byte) bool) Fn {
	parsers := [condition]
	return fn [parsers] (input string) ?(string, string) {
		condition := parsers[0]
		for i, c in input.bytes() {
			if condition(c) {
				return input[i..], input[..i]
			}
		}
		return error('`take_till` failed on input `$input`')
	}
}

// Returns the longest (at least 1) input slice till a predicate is met.
pub fn take_till1(condition fn (byte) bool) Fn {
	parsers := [condition]
	return fn [parsers] (input string) ?(string, string) {
		condition := parsers[0]
		for i, c in input.bytes() {
			if condition(c) && i > 0 {
				return input[i..], input[..i]
			}
		}
		return error('`take_till1` failed on input `$input`')
	}
}

// Returns the input slice up to the first occurrence of the pattern.
pub fn take_until(pattern string) Fn {
	return fn [pattern] (input string) ?(string, string) {
		for i := 0; i + pattern.len <= input.len; i++ {
			if input[i..i + pattern.len] == pattern {
				return input[i..], input[..i]
			}
		}
		return error('`take_until` failed on input `$input` with pattern `$pattern`')
	}
}

// Returns the non empty input slice up to the first occurrence of the pattern.
pub fn take_until1(pattern string) Fn {
	return fn [pattern] (input string) ?(string, string) {
		for i := 1; i + pattern.len <= input.len; i++ {
			if input[i..i + pattern.len] == pattern {
				return input[i..], input[..i]
			}
		}
		return error('`take_until1` failed on input `$input` with pattern `$pattern`')
	}
}

// Returns the longest input slice (if any) that matches the predicate.
pub fn take_while(condition fn (byte) bool) Fn {
	parsers := [condition]
	return fn [parsers] (input string) ?(string, string) {
		condition := parsers[0]
		for i, c in input.bytes() {
			if !condition(c) {
				return input[i..], input[..i]
			}
		}
		return '', input
	}
}

// Returns the longest (at least 1) input slice that matches the predicate.
pub fn take_while1(condition fn (byte) bool) Fn {
	parsers := [condition]
	return fn [parsers] (input string) ?(string, string) {
		condition := parsers[0]
		for i, c in input.bytes() {
			if !condition(c) {
				if i == 0 {
					return error('`take_while` failed on input `$input` because it returned empty')
				}
				return input[i..], input[..i]
			}
		}
		return '', input
	}
}

// Returns the longest (m <= len <= n) input slice that matches the predicate.
pub fn take_while_m_n(m int, n int, condition fn (byte) bool) Fn {
	parsers := [condition]
	return fn [m, n, parsers] (input string) ?(string, string) {
		condition := parsers[0]
		mut longest := -1
		for i, c in input.bytes() {
			len := i + 1
			if condition(c) && m <= len {
				longest = len
			}
			println('$i $longest $input $c')
			if len == n {
				break
			}
		}
		if longest != -1 {
			return input[longest..], input[..longest]
		} else {
			return error('`take_while_m_n` failed on input `$input` with m `$m` and n `$n`')
		}
	}
}
