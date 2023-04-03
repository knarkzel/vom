module vom

// Based on https://docs.rs/nom/7.1.3/nom/sequence/index.html

// Matches an object from the first parser and discards it, then gets an object
// from the second parser, and finally matches an object from the third parser and
// discards it.
pub fn delimited(first Fn, second Fn, third Fn) Fn {
	return fn [first, second, third] (input string) !(string, string) {
		x, _ := first(input)!
		y, output := second(x)!
		z, _ := third(y)!
		return z, output
	}
}

// Gets an object from the first parser, then gets another object from the second parser.
pub fn pair(first Fn, second Fn) FnMany {
	return fn [first, second] (input string) !(string, []string) {
		a, b := first(input)!
		c, d := second(a)!
		return c, [b, d]
	}
}

// Matches an object from the first parser and discards it, then gets an object
// from the second parser.
pub fn preceded(first Fn, second Fn) Fn {
	parsers := [first, second]
	return fn [parsers] (input string) !(string, string) {
		first, second := parsers[0], parsers[1]
		x, _ := first(input)!
		y, output := second(x)!
		return y, output
	}
}

// Gets an object from the first parser, then matches an object from the sep_parser
// and discards it, then gets another object from the second parser.
pub fn separated_pair(first Fn, sep Fn, second Fn) FnMany {
	return fn [first, sep, second] (input string) !(string, []string) {
		mut output := []string{}
		x, start := first(input)!
		output << start
		y, _ := sep(x)!
		z, end := second(y)!
		output << end
		return z, output
	}
}

// Gets an object from the first parser, then matches an object from the second
// parser and discards it.
pub fn terminated(first Fn, second Fn) Fn {
	return fn [first, second] (input string) !(string, string) {
		x, output := first(input)!
		y, _ := second(x)!
		return y, output
	}
}

// Applies a tuple of parsers one by one and returns their results as a tuple.
pub fn tuple(parsers []Fn) FnMany {
	return fn [parsers] (input string) !(string, []string) {
		mut temp := input
		mut output := []string{}
		for parser in parsers {
			rest, slice := parser(temp)!
			output << slice
			temp = rest
		}
		return temp, output
	}
}

// Applies a tuple of parsers one by one and returns their results as a string.
pub fn contact(parsers []Fn) Fn {
	return fn [parsers] (input string) !(string, string) {
		parser := tuple(parsers)
		rest, output := parser(input)!
		return rest, output.join('')
	}
}
