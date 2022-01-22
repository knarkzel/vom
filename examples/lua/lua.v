module main

import os
import strings
import vom { alphanumeric1, alt, digit1, tag }

struct Location {
mut:
	x int
	y int
	i int
}

fn (l Location) increment(len int) Location {
	return Location{l.x + len, l.y, l.i + len}
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

fn keyword(input string, location Location) ?(string, Token) {
	parser := alt(tag('function'), tag('end'), tag('if'), tag('then'), tag('lal'), tag('return'))
	rest, output := parser(input) ?
	return rest, Token{output, location, .keyword}
}

fn identifier(input string, location Location) ?(string, Token) {
	rest, output := alphanumeric1(input) ?
	if vom.is_digit(output[0]) {
		return error('$output starts with digit')
	} else {
		return rest, Token{output, location, .identifier}
	}
}

fn number(input string, location Location) ?(string, Token) {
	rest, output := digit1(input) ?
	return rest, Token{output, location, .number}
}

fn syntax(input string, location Location) ?(string, Token) {
	parser := alt(tag(';'), tag('='), tag('('), tag(')'), tag(','))
	rest, output := parser(input) ?
	return rest, Token{output, location, .syntax}
}

fn operator(input string, location Location) ?(string, Token) {
	parser := alt(tag('+'), tag('-'), tag('<'))
	rest, output := parser(input) ?
	return rest, Token{output, location, .operator}
}

fn debug(index int, line_number int, input string, message string) {
	file := os.args[1]
	start := if line_number >= 5 { line_number - 2 } else { 0 }
	lines := input.split('\n')[start..][..5]
	biggest := (line_number + 3).str().len
	len := input[index..].split('\n')[0].len
	println('$file:${len + 1}:${line_number + 1}: error: $message')
	for i, line in lines {
		pipe_pad := strings.repeat(` `, biggest - (start + i + 1).str().len + 1)
		println('   ${start + i + 1}$pipe_pad| $line')
		if start + i == line_number {
			space := strings.repeat(` `, len)
			tilde := strings.repeat(`~`, line.len - len)
			padding := strings.repeat(` `, (start + i).str().len)
			println('   $padding$pipe_pad| $space$tilde')
		}
	}
}

fn lex(input string) ?[]Token {
	mut temp := input
	mut tokens := []Token{}
	mut location := Location{0, 0, 0}
	lexers := [keyword, identifier, number, syntax, operator]

	outer: for temp.len > 0 {
		// Handle whitespace
		for i, b in temp.bytes() {
			if b == ` ` || b == `\t` {
				location.x++
				location.i++
			} else if b == `\r` || b == `\n` {
				location.y++
				location.i++
			} else {
				temp = temp[i..]
				if i == 0 {
					break
				} else {
					continue outer
				}
			}
		}

		// Lex input
		for lexer in lexers {
			rest, token := lexer(temp, location) or { continue }
			temp = rest
			location = token.location.increment(token.value.len)
			tokens << token
			continue outer
		}

		// No lexer worked, print error and exit
		debug(location.i, location.y, input, 'parsing failed')
		return none
	}

	return tokens
}

fn main() {
	path := os.args[1] or {
		println('lua <file>')
		return
	}
	input := os.read_file(path) ?
	if tokens := lex(input) {
		dump(tokens)
	}
}
