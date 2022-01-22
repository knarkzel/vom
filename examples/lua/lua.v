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
	identifier
	syntax
	keyword
	number
	operator
}

struct Token {
	value    string
	location Location
	kind     TokenKind
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
		debug(location, input, 'parsing failed')
		return none
	}

	return tokens
}

fn keyword(input string, l Location) ?(string, Token) {
	parser := alt(tag('function'), tag('end'), tag('if'), tag('then'), tag('lal'), tag('return'))
	rest, output := parser(input) ?
	return rest, Token{output, l, .keyword}
}

fn identifier(input string, l Location) ?(string, Token) {
	rest, output := alphanumeric1(input) ?
	if vom.is_digit(output[0]) {
		return error('$output starts with digit')
	} else {
		return rest, Token{output, l, .identifier}
	}
}

fn number(input string, l Location) ?(string, Token) {
	rest, output := digit1(input) ?
	return rest, Token{output, l, .number}
}

fn syntax(input string, l Location) ?(string, Token) {
	parser := alt(tag(';'), tag('='), tag('('), tag(')'), tag(','))
	rest, output := parser(input) ?
	return rest, Token{output, l, .syntax}
}

fn operator(input string, l Location) ?(string, Token) {
	parser := alt(tag('+'), tag('-'), tag('<'))
	rest, output := parser(input) ?
	return rest, Token{output, l, .operator}
}

fn debug(l Location, input string, message string) {
	file := os.args[1]
	start := if l.y >= 5 { l.y - 2 } else { 0 }
	lines := input.split('\n')[start..][..5]
	biggest := (l.y + 3).str().len
	len := input[l.i..].split('\n')[0].len
	println('$file:${len + 1}:${l.y + 1}: error: $message')
	for i, line in lines {
		pipe_pad := strings.repeat(` `, biggest - (start + i + 1).str().len + 1)
		println('   ${start + i + 1}$pipe_pad| $line')
		if start + i == l.y {
			space := strings.repeat(` `, len)
			tilde := strings.repeat(`~`, line.len - len)
			padding := strings.repeat(` `, (start + i).str().len)
			println('   $padding$pipe_pad| $space$tilde')
		}
	}
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
