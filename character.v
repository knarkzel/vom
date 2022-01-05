module vom

// Based on https://docs.rs/nom/7.1.0/nom/character/index.html

pub fn is_alphabetic(b byte) bool {
	return 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.bytes().any(it == b)
}

pub fn is_digit(b byte) bool {
	return '0123456789'.bytes().any(it == b)
}

pub fn is_alphanumeric(b byte) bool {
	return is_alphabetic(b) || is_digit(b)
}

pub fn is_hex_digit(b byte) bool {
	return is_digit(b) || 'ABCDEF'.bytes().any(it == b) || 'abcdef'.bytes().any(it == b)
}

pub fn is_newline(b byte) bool {
	return b == `\n`
}

pub fn is_oct_digit(b byte) bool {
	return '01234567'.bytes().any(it == b)
}

pub fn is_space(b byte) bool {
	return ' \t'.bytes().any(it == b)
}
