module main

import os
import strings

fn debug(location Location, input string, message string) {
	file := os.args[1]
	start := if location.y >= 5 { location.y - 2 } else { 0 }
	lines := input.split('\n')[start..start + 5]
	biggest := (location.y + 3).str().len
	len := location.x
	println('$file:${len + 1}:${location.y + 1}: error: $message')
	for i, line in lines {
		pipe_pad := strings.repeat(` `, biggest - (start + i + 1).str().len + 1)
		println('   ${start + i + 1}$pipe_pad| $line')
		if start + i == location.y {
			space := strings.repeat(` `, len)
			tilde := strings.repeat(`~`, line.len - len)
			padding := strings.repeat(` `, (start + i).str().len)
			println('   $padding$pipe_pad| $space$tilde')
		}
	}
}

// Eats whitespace and returns it back if changed
fn eat_whitespace(input string, location Location) ?(string, Location) {
	mut temporary := location
	for i, b in input.bytes() {
		match b {
			` `, `\t` {
				temporary.x++
			}
			`\r` {
				temporary.x = 0
			}
			`\n` {
				temporary.x = 0
				temporary.y++
			}
			else {
				return input[i..], temporary
			}
		}
	}
	return none
}
