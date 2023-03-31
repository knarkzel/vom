module vom

// Based on https://docs.rs/nom/7.1.3/nom/multi/index.html

// Runs the embedded parser a specified number of times.
pub fn count(f Fn, count int) FnMany {
	return fn [f, count] (input string) !(string, []string) {
		mut temp := input
		mut output := []string{}
		for _ in 0 .. count {
			rest, capture := f(temp)!
			temp = rest
			output << capture
		}
		return temp, output
	}
}

// Runs the embedded parser repeatedly, filling the given slice with results.
pub fn fill(f Fn, mut buf []string) FnMany {
	return fn [f, mut buf] (input string) !(string, []string) {
		mut temp := input
		for mut b in buf {
			temp, b = f(temp)!
		}
		return temp, []string{}
	}
}

// Repeats the embedded parser `f`, calling `g` to gather the results.
pub fn fold_many0(f Fn, init fn () []string, g fn (string, mut []string)) FnMany {
	return fn [f, init, g] (input string) !(string, []string) {
		mut y := init()
		mut a := input
		mut b := ''
		for {
			a, b = f(a) or { break }
			if b == '' {
				break
			}
			g(b, mut y)
		}
		return a, y
	}
}

// Repeats the embedded parser `f`, calling `g` to gather the results.
pub fn fold_many1(f Fn, init fn () []string, g fn (string, mut []string)) FnMany {
	return fn [f, init, g] (input string) !(string, []string) {
		mut y := init()
		mut a := input
		mut b := ''
		mut first_flag := true
		for {
			a, b = f(a) or { break }
			first_flag = false
			if b == '' {
				break
			}
			g(b, mut y)
		}
		if first_flag == true {
			return error('`fold_many1` fail.')
		} else {
			return a, y
		}
	}
}

// Repeats the embedded parser `f` `m`..=`n` times, calling `g` to gather the results
pub fn fold_many_m_n(m usize, n usize, f Fn, init fn () []string, g fn (string, mut []string)) FnMany {
	return fn [m, n, f, init, g] (input string) !(string, []string) {
		mut y := init()
		mut a := input
		mut b := ''
		mut first_flag := true
		mut times := usize(0)
		for {
			a, b = f(a) or { break }
			if b == '' {
				break
			}
			g(b, mut y)
			if times >= m {
				first_flag = false
			}
			if times + 1 == n {
				break
			}
			times += 1
		}
		if first_flag == true && m > 0 {
			return error('`fold_many_m_n` fail.')
		} else {
			return a, y
		}
	}
}

// Gets a number from the first parser `f`, then applies the second parser `g` that many times.
pub fn length_count(f Fn, g Fn) FnMany {
	return fn [f, g] (input string) !(string, []string) {
		a, b := f(input)!
		times := b.u8()
		mut result := []string{}
		mut c := a
		mut d := ''
		for _ in 0 .. times {
			c, d = g(c) or { return error('`length_count` fail.') }
			result << d
		}
		return c, result
	}
}

// Repeats the embedded parser `f`, gathering the results in a []string.
pub fn many0(f Fn) FnMany {
	return fn [f] (input string) !(string, []string) {
		mut a := input
		mut b := ''
		mut result := []string{}
		for {
			a, b = f(a) or { break }
			result << b
		}

		return a, result
	}
}

// Repeats the embedded parser `f`, counting the results
pub fn many0_count(f Fn) FnCount {
	return fn [f] (input string) !(string, usize) {
		mut a := input
		mut count := usize(0)
		for {
			a, _ = f(a) or { break }
			count += 1
		}

		return a, count
	}
}

// Repeats the embedded parser `f`, gathering the results in a []string.
pub fn many1(f Fn) FnMany {
	return fn [f] (input string) !(string, []string) {
		mut a := input
		mut b := ''
		mut result := []string{}
		for {
			a, b = f(a) or { break }
			result << b
		}

		if result.len == 0 {
			return error('`many1` fail.')
		}

		return a, result
	}
}

// Repeats the embedded parser `f`, counting the results
pub fn many1_count(f Fn) FnCount {
	return fn [f] (input string) !(string, usize) {
		mut a := input
		mut count := usize(0)
		for {
			a, _ = f(a) or { break }
			count += 1
		}

		if count == 0 {
			return error('`many1_count` fail.')
		}

		return a, count
	}
}

// Repeats the embedded parser `f` m..=n times
pub fn many_m_n(m usize, n usize, f Fn) FnMany {
	return fn [m, n, f] (input string) !(string, []string) {
		mut a := input
		mut b := ''
		mut result := []string{}
		mut first_flag := true
		mut times := usize(0)
		for {
			a, b = f(a) or { break }
			result << b
			if times >= m {
				first_flag = false
			}
			if times + 1 == n {
				break
			}

			times += 1
		}

		if first_flag == true && m > 0 {
			return error('`many_m_n` fail.')
		} else {
			return a, result
		}
	}
}

// Applies the parser `f` until the parser `g` produces a result.
pub fn many_till(f Fn, g Fn) FnResult {
	return fn [f, g] (input string) !(string, []string, string) {
		mut a := input
		mut b := ''
		mut result := []string{}

		for {
			a, b = f(a) or { break }
			result << b
		}

		if result.len == 0 {
			return error('`many_till` fail with first parser.')
		}

		a, b = g(a) or { return error('many_till` fail with second parser.') }

		return a, result, b
	}
}

// Alternates between two parsers to produce a list of elements.
// `sep` Parses the separator between list elements.
// `f` Parses the elements of the list.
pub fn separated_list0(sep Fn, f Fn) FnMany {
	return fn [sep, f] (input string) !(string, []string) {
		mut a := input
		mut b := ''
		mut result := []string{}
		for {
			a, b = f(a) or { break } // { a, '' } workaround a bug of vlang
			if b.len > 0 {
				result << b
			}
			a, b = sep(a) or { break }
		}

		for {
			a, b = sep(a) or { break }
		}

		return a, result
	}
}

// Alternates between two parsers to produce a list of elements.
// `sep` Parses the separator between list elements.
// `f` Parses the elements of the list.
pub fn separated_list1(sep Fn, f Fn) FnMany {
	return fn [sep, f] (input string) !(string, []string) {
		mut a := input
		mut b := ''
		mut result := []string{}
		for {
			a, b = f(a) or { break } // { a, '' } workaround a bug of vlang
			if b.len > 0 {
				result << b
			}
			a, b = sep(a) or { break }
		}

		for {
			a, b = sep(a) or { break }
		}

		if result.len == 0 {
			return error('`separated_list1` fail.')
		}

		return a, result
	}
}
