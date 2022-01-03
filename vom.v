module main

fn tag(pattern string) fn (string) ?(string, string) {
	return fn [pattern] (input string) ?(string, string) {
		if input.len < pattern.len {
			return none
		}
		if input[..pattern.len] == pattern {
			return input[pattern.len..], input[..pattern.len]
		} else {
			return none
		}
	}
}

fn take(count int) fn (string) ?(string, string) {
	return fn [count] (input string) ?(string, string) {
		if input.len < count {
			return none
		} else {
			return input[count..], input[..count]
		}
	}
}

fn apply(parsers ...fn (string) ?(string, string)) fn (string) ?(string, []string) {
	return fn [parsers] (input string) ?(string, []string) {
		mut temp := input
		mut output := []string{}
		for parser in parsers {
			rest, slice := parser(temp) ?
			output << slice
			temp = rest
		}
		return temp, output
	}
}

fn main() {
	input := 'hello, world'
	parser := apply(tag('hello'), take(5))
	_, output := parser(input) ?
	println(output)
}
