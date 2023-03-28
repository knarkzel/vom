module vom

fn test_alpha0() ! {
	rest, output := alpha0('ab1c') !
	assert output == 'ab'
	assert rest == '1c'
}

fn test_alpha1() ! {
	rest, output := alpha1('aB1c') !
	assert output == 'aB'
	assert rest == '1c'
}

fn test_alphanumeric0() ! {
	rest, output := alphanumeric0('21cZ%1') !
	assert output == '21cZ'
	assert rest == '%1'
}

fn test_alphanumeric1() ! {
	rest, output := alphanumeric1('21cZ%1') !
	assert output == '21cZ'
	assert rest == '%1'
}

fn test_character() ! {
	rest, output := character('abc') !
	assert output == 'a'
	assert rest == 'bc'
}

fn test_crlf() ! {
	rest, output := crlf('\r\nc') !
	assert output == '\r\n'
	assert rest == 'c'
}

fn test_digit0() ! {
	rest, output := digit0('21c') !
	assert output == '21'
	assert rest == 'c'
}

fn test_digit1() ! {
	rest, output := digit1('21c') !
	assert output == '21'
	assert rest == 'c'
}

fn test_hex_digit0() ! {
	rest, output := hex_digit0('21cZ') !
	assert output == '21c'
	assert rest == 'Z'
}

fn test_hex_digit1() ! {
	rest, output := hex_digit1('21cZ') !
	assert output == '21c'
	assert rest == 'Z'
}

fn test_line_ending() ! {
	rest, output := line_ending('\r\nc') !
	assert output == '\r\n'
	assert rest == 'c'
}

fn test_multispace0() ! {
	rest, output := multispace0(' \t\n\r21c') !
	assert output == ' \t\n\r'
	assert rest == '21c'
}

fn test_multispace1() ! {
	rest, output := multispace1(' \t\n\r21c') !
	assert output == ' \t\n\r'
	assert rest == '21c'
}

fn test_newline() ! {
	rest, output := newline('\nc') !
	assert output == '\n'
	assert rest == 'c'
}

fn test_none_of() ! {
	parser := none_of('abc')
	rest, output := parser('z') !
	assert output == 'z'
	assert rest == ''
}

fn test_not_line_ending() ! {
	rest, output := not_line_ending('ab\r\nc') !
	assert output == 'ab'
	assert rest == '\r\nc'
}

fn test_oct_digit0() ! {
	rest, output := oct_digit0('21cZ') !
	assert output == '21'
	assert rest == 'cZ'
}

fn test_oct_digit1() ! {
	rest, output := oct_digit1('21cZ') !
	assert output == '21'
	assert rest == 'cZ'
}

fn test_one_of() ! {
	parser := one_of('abc')
	rest, output := parser('b') !
	assert output == 'b'
	assert rest == ''
}

fn test_satisfy() ! {
	parser := satisfy(fn (b byte) bool {
		return b == `a` || b == `b`
	})
	rest, output := parser('abc') !
	assert output == 'a'
	assert rest == 'bc'
}

fn test_space0() ! {
	rest, output := space0(' \t21c') !
	assert output == ' \t'
	assert rest == '21c'
}

fn test_space1() ! {
	rest, output := space1(' \t21c') !
	assert output == ' \t'
	assert rest == '21c'
}

fn test_tab() ! {
	rest, output := tab('\tc') !
	assert output == '\t'
	assert rest == 'c'
}
