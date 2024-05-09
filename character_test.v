module vom

fn test_alpha0() ! {
	rest, output, len := alpha0('ab1c')!
	assert output == 'ab'
	assert rest == '1c'
	assert len == 2
}

fn test_alpha1() ! {
	rest, output, len := alpha1('aB1c')!
	assert output == 'aB'
	assert rest == '1c'
	assert len == 2
}

fn test_alphanumeric0() ! {
	rest, output, len := alphanumeric0('21cZ%1')!
	assert output == '21cZ'
	assert rest == '%1'
	assert len == 4
}

fn test_alphanumeric1() ! {
	rest, output, len := alphanumeric1('21cZ%1')!
	assert output == '21cZ'
	assert rest == '%1'
	assert len == 4
}

fn test_character() ! {
	rest, output, len := character('abc')!
	assert output == 'a'
	assert rest == 'bc'
	assert len == 1
}

fn test_crlf() ! {
	rest, output, len := crlf('\r\nc')!
	assert output == '\r\n'
	assert rest == 'c'
	assert len == 2
}

fn test_digit0() ! {
	rest, output, len := digit0('21c')!
	assert output == '21'
	assert rest == 'c'
	assert len == 2
}

fn test_digit1() ! {
	rest, output, len := digit1('21c')!
	assert output == '21'
	assert rest == 'c'
	assert len == 2
}

fn test_hex_digit0() ! {
	rest, output, len := hex_digit0('21cZ')!
	assert output == '21c'
	assert rest == 'Z'
	assert len == 3
}

fn test_hex_digit1() ! {
	rest, output, len := hex_digit1('21cZ')!
	assert output == '21c'
	assert rest == 'Z'
	assert len == 3
}

fn test_line_ending() ! {
	rest, output, len := line_ending('\r\nc')!
	assert output == '\r\n'
	assert rest == 'c'
	assert len == 2
}

fn test_multispace0() ! {
	rest, output, len := multispace0(' \t\n\r21c')!
	assert output == ' \t\n\r'
	assert rest == '21c'
	assert len == 4
}

fn test_multispace1() ! {
	rest, output, len := multispace1(' \t\n\r21c')!
	assert output == ' \t\n\r'
	assert rest == '21c'
	assert len == 4
}

fn test_newline() ! {
	rest, output, len := newline('\nc')!
	assert output == '\n'
	assert rest == 'c'
	assert len == 1
}

fn test_none_of() ! {
	parser := none_of('abc')
	rest, output, len := parser('z')!
	assert output == 'z'
	assert rest == ''
	assert len == 1
}

fn test_not_line_ending() ! {
	rest, output, len := not_line_ending('ab\r\nc')!
	assert output == 'ab'
	assert rest == '\r\nc'
	assert len == 2
}

fn test_oct_digit0() ! {
	rest, output, len := oct_digit0('21cZ')!
	assert output == '21'
	assert rest == 'cZ'
	assert len == 2
}

fn test_oct_digit1() ! {
	rest, output, len := oct_digit1('21cZ')!
	assert output == '21'
	assert rest == 'cZ'
	assert len == 2
}

fn test_one_of() ! {
	parser := one_of('abc')
	rest, output, len := parser('b')!
	assert output == 'b'
	assert rest == ''
	assert len == 1
}

fn test_satisfy() ! {
	parser := satisfy(fn (b u8) bool {
		return b == `a` || b == `b`
	})
	rest, output, len := parser('abc')!
	assert output == 'a'
	assert rest == 'bc'
	assert len == 1
}

fn test_space0() ! {
	rest, output, len := space0(' \t21c')!
	assert output == ' \t'
	assert rest == '21c'
	assert len == 2
}

fn test_space1() ! {
	rest, output, len := space1(' \t21c')!
	assert output == ' \t'
	assert rest == '21c'
	assert len == 2
}

fn test_tab() ! {
	rest, output, len := tab('\tc')!
	assert output == '\t'
	assert rest == 'c'
	assert len == 1
}
