module vom

// Based on https://docs.rs/nom/7.1.0/nom/combinator/index.html

// Succeeds if all the input has been consumed by its child parser.
pub fn all_consuming(f Fn) Fn {
	parsers := [f]
	return fn [parsers] (input string) ?(string, string) {
		f := parsers[0]
		rest, output := f(input) ?
		if rest.len == 0 {
			return rest, output
		} else {
			return error('`all_consuming` failed because $rest is not empty')
		}
	}
}

// Calls the parser if the condition is met.
pub fn cond(b bool, f Fn) Fn {
	parsers := [f]
	return fn [b, parsers] (input string) ?(string, string) {
		f := parsers[0]
		if b {
			return f(input)
		} else {
			return input, ''
		}
	}
}

// Returns its input if it is at the end of input data
pub fn eof(input string) ?(string, string) {
	if input.len == 0 {
		return input, input
	} else {
		return error('`eof` failed because $input is not empty')
	}
}

// A parser which always fails.
pub fn fail(input string) ?(string, string) {
	return error('`fail` failed')
}

// Succeeds if the child parser returns an error.
pub fn not(f Fn) Fn {
	parsers := [f]
	return fn [parsers] (input string) ?(string, string) {
		f := parsers[0]
		f(input) or { return input, '' }
		return error('`not` failed because function succeded')
	}
}

// Optional parser: Will return '' if not successful.
pub fn opt(f Fn) Fn {
	parsers := [f]
	return fn [parsers] (input string) ?(string, string) {
		f := parsers[0]
		rest, output := f(input) or { return input, '' }
		return rest, output
	}
}

// Tries to apply its parser without consuming the input.
pub fn peek(f Fn) Fn {
	parsers := [f]
	return fn [parsers] (input string) ?(string, string) {
		f := parsers[0]
		_, output := f(input) ?
		return input, output
	}
}

// If the child parser was successful, return the consumed input as produced value.
pub fn recognize(f Parser) Fn {
	parsers := [f]
	return fn [parsers] (input string) ?(string, string) {
		f := parsers[0]
		match f {
			Fn {
				rest, _ := f(input) ?
				return rest, input[..input.len - rest.len]
			}
			FnMany {
				rest, _ := f(input) ?
				return rest, input[..input.len - rest.len]
			}
		}
	}
}
