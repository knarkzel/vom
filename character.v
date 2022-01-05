module vom

// Based on https://docs.rs/nom/7.1.0/nom/character/index.html

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
