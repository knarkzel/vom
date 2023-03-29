module vom

// Based on https://docs.rs/nom/7.1.0/nom/sequence/index.html

// Matches an object from the first parser and discards it, then gets an object
// from the second parser, and finally matches an object from the third parser and
// discards it.
pub fn delimited(first Fn, second Fn, third Fn) Fn {
	parsers := [first, second, third]
	return fn [parsers] (input string) !(string, string) {
		first, second, third := parsers[0], parsers[1], parsers[2]
		x, _ := first(input)!
		y, output := second(x)!
		z, _ := third(y)!
		return z, output
	}
}

// Gets an object from the first parser, then gets another object from the second parser.
pub fn pair(first Fn, second Fn) Fn {
	return fn [first, second] (input string) !(string, string) {
		rest, _ := first(input)!
		return second(rest)!
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
	parsers := [first, sep, second]
	return fn [parsers] (input string) !(string, []string) {
		mut output := []string{}
		first, sep, second := parsers[0], parsers[1], parsers[2]
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
	parsers := [first, second]
	return fn [parsers] (input string) !(string, string) {
		first, second := parsers[0], parsers[1]
		x, output := first(input)!
		y, _ := second(x)!
		return y, output
	}
}

// Applies a tuple of parsers one by one and returns their results as a tuple.
pub fn tuple(parsers ...Fn) FnMany {
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
