module vom

// Based on https://docs.rs/nom/7.1.3/nom/character/index.html

// Tests if byte is ASCII alphabetic: A-Z, a-z.
pub fn is_alphabetic(b byte) bool {
	return 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.bytes().any(it == b)
}

// Tests if byte is ASCII alphanumeric: A-Z, a-z, 0-9.
pub fn is_alphanumeric(b byte) bool {
	return is_alphabetic(b) || is_digit(b)
}

// Tests if byte is ASCII digit: 0-9.
pub fn is_digit(b byte) bool {
	return '0123456789'.bytes().any(it == b)
}

// Tests if byte is ASCII hex digit: 0-9, A-F, a-f.
pub fn is_hex_digit(b byte) bool {
	return is_digit(b) || 'ABCDEF'.bytes().any(it == b) || 'abcdef'.bytes().any(it == b)
}

// Tests if byte is ASCII newline: \n.
pub fn is_newline(b byte) bool {
	return b == `\n`
}

// Tests if byte is ASCII octal digit: 0-7.
pub fn is_oct_digit(b byte) bool {
	return '01234567'.bytes().any(it == b)
}

// Tests if byte is ASCII space or tab.
pub fn is_space(b byte) bool {
	return ' \t'.bytes().any(it == b)
}

// Based on https://docs.rs/nom/7.1.3/nom/character/complete/index.html

// Recognizes zero or more lowercase and uppercase ASCII alphabetic characters: a-z, A-Z
pub fn alpha0(input string) !(string, string) {
	parser := take_while(is_alphabetic)
	return parser(input)
}

// Recognizes one or more lowercase and uppercase ASCII alphabetic characters: a-z, A-Z
pub fn alpha1(input string) !(string, string) {
	parser := take_while1(is_alphabetic)
	return parser(input)
}

// Recognizes zero or more ASCII numerical and alphabetic characters: 0-9, a-z, A-Z
pub fn alphanumeric0(input string) !(string, string) {
	parser := take_while(is_alphanumeric)
	return parser(input)
}

// Recognizes one or more ASCII numerical and alphabetic characters: 0-9, a-z, A-Z
pub fn alphanumeric1(input string) !(string, string) {
	parser := take_while1(is_alphanumeric)
	return parser(input)
}

// Recognizes one letter.
pub fn character(input string) !(string, string) {
	parser := take_while_m_n(1, 1, is_alphabetic)
	return parser(input)
}

// Recognizes the string '\r\n'.
pub fn crlf(input string) !(string, string) {
	parser := tag('\r\n')
	return parser(input)
}

// Recognizes zero or more ASCII numerical characters: 0-9
pub fn digit0(input string) !(string, string) {
	parser := take_while(is_digit)
	return parser(input)
}

// Recognizes one or more ASCII numerical characters: 0-9
pub fn digit1(input string) !(string, string) {
	parser := take_while1(is_digit)
	return parser(input)
}

// Recognizes zero or more ASCII hexadecimal numerical characters: 0-9, A-F, a-f
pub fn hex_digit0(input string) !(string, string) {
	parser := take_while(is_hex_digit)
	return parser(input)
}

// Recognizes one or more ASCII hexadecimal numerical characters: 0-9, A-F, a-f
pub fn hex_digit1(input string) !(string, string) {
	parser := take_while1(is_hex_digit)
	return parser(input)
}

// Recognizes an end of line (both '\n' and '\r\n').
pub fn line_ending(input string) !(string, string) {
	parser := alt([tag('\n'), tag('\r\n')])
	return parser(input)
}

// Recognizes zero or more spaces, tabs, carriage returns and line feeds.
pub fn multispace0(input string) !(string, string) {
	parser := take_while(fn (b byte) bool {
		return ' \t\n\r'.bytes().any(it == b)
	})
	return parser(input)
}

// Recognizes one or more spaces, tabs, carriage returns and line feeds.
pub fn multispace1(input string) !(string, string) {
	parser := take_while1(fn (b byte) bool {
		return ' \t\n\r'.bytes().any(it == b)
	})
	return parser(input)
}

// Matches a newline character '\n'
pub fn newline(input string) !(string, string) {
	parser := tag('\n')
	return parser(input)
}

// Recognizes a character that is not in the provided characters.
pub fn none_of(pattern string) Fn {
	return fn [pattern] (input string) !(string, string) {
		if input.len == 0 {
			return error('`none_of` failed because input is empty')
		}
		if pattern.bytes().all(it != input[0]) {
			return input[1..], input[..1]
		} else {
			return error('`none_of` failed on input `${input}` with pattern `${pattern}`')
		}
	}
}

// Recognizes a string of any char except '\r\n' or '\n'.
pub fn not_line_ending(input string) !(string, string) {
	parser := take_while(fn (b byte) bool {
		return '\r\n'.bytes().all(it != b)
	})
	return parser(input)
}

// Recognizes zero or more octal characters: 0-7
pub fn oct_digit0(input string) !(string, string) {
	parser := take_while(is_oct_digit)
	return parser(input)
}

// Recognizes one or more octal characters: 0-7
pub fn oct_digit1(input string) !(string, string) {
	parser := take_while1(is_oct_digit)
	return parser(input)
}

// Recognizes one of the provided characters.
pub fn one_of(pattern string) Fn {
	return fn [pattern] (input string) !(string, string) {
		if input.len == 0 {
			return error('`one_of` failed because input is empty')
		}
		if pattern.bytes().any(it == input[0]) {
			return input[1..], input[..1]
		} else {
			return error('`one_of` failed on input `${input}` with pattern `${pattern}`')
		}
	}
}

// Recognizes one character and checks that it satisfies a predicate
pub fn satisfy(condition fn (byte) bool) Fn {
	return fn [condition] (input string) !(string, string) {
		if input.len == 0 {
			return error('`satisfy` failed because input is empty')
		}
		if condition(input[0]) {
			return input[1..], input[..1]
		} else {
			return error('`satisfy` failed on input `${input}`')
		}
	}
}

// Recognizes zero or more spaces and tabs.
pub fn space0(input string) !(string, string) {
	parser := take_while(is_space)
	return parser(input)
}

// Recognizes one or more spaces and tabs.
pub fn space1(input string) !(string, string) {
	parser := take_while1(is_space)
	return parser(input)
}

// Matches a tab character '\t'.
pub fn tab(input string) !(string, string) {
	parser := tag('\t')
	return parser(input)
}
