module main

fn tag(pattern string) fn (string) ?(string, string) {
	return fn [pattern] (input string) ?(string, string) {
		if input.len < pattern.len {
			return error('`tag` failed because input `$input` is shorter than pattern `$pattern`')
		}
		if input[..pattern.len] == pattern {
			return input[pattern.len..], input[..pattern.len]
		} else {
			return error('`tag` failed because `${input[..pattern.len]}` is not equal to pattern `$pattern`')
		}
	}
}

fn take(count int) fn (string) ?(string, string) {
	return fn [count] (input string) ?(string, string) {
		if input.len < count {
			return error('`take` failed with count `$count` on input `$input`')
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
