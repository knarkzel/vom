module main

import os
import vom { alphanumeric1, alt, digit1, is_digit, one_of, tag }

struct Location {
mut:
	x int
	y int
}

enum TokenKind {
	syntax
	number
	keyword
	operator
	identifier
}

struct Token {
	value      string
	location   Location
	token_kind TokenKind
}

fn keyword(input string, location Location) !(string, Token) {
	parser := alt([tag('function'), tag('end'), tag('if'), tag('then'),
		tag('lal'), tag('return')])
	rest, output := parser(input)!
	return rest, Token{output, location, .keyword}
}

fn identifier(input string, location Location) !(string, Token) {
	rest, output := alphanumeric1(input)!
	if is_digit(output[0]) {
		return error('${output} starts with digit')
	} else {
		return rest, Token{output, location, .identifier}
	}
}

fn number(input string, location Location) !(string, Token) {
	rest, output := digit1(input)!
	return rest, Token{output, location, .number}
}

fn syntax(input string, location Location) !(string, Token) {
	parser := one_of(';=(),')
	rest, output := parser(input)!
	return rest, Token{output, location, .syntax}
}

fn operator(input string, location Location) !(string, Token) {
	parser := one_of('+-<')
	rest, output := parser(input)!
	return rest, Token{output, location, .operator}
}

fn lex(source string) ?[]Token {
	mut input := source
	mut tokens := []Token{}
	mut location := Location{0, 0}
	lexers := [keyword, identifier, number, syntax, operator]

	outer: for input.len > 0 {
		// Handle whitespace
		input, location = eat_whitespace(input, location) or { break }

		// Lex input
		for lexer in lexers {
			rest, token := lexer(input, location) or { continue }
			input = rest
			location.x += token.value.len
			tokens << token
			continue outer
		}

		// No lexer worked, print error and exit
		debug(location, source, 'parsing failed')
		return none
	}

	return tokens
}

fn main() {
	path := os.args[1] or {
		println('lua <file>')
		return
	}
	input := os.read_file(path)!
	if tokens := lex(input) {
		dump(tokens)
	}
}
