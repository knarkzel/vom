module vom

fn test_escaped() ! {
	mut rest := ''
	mut output := ''
	mut len := 0

	parser := escaped(digit1, `\\`, one_of('r#""n"#'))
	rest, output, len = parser('123;')!
	assert output == '123'
	assert rest == ';'
	assert len == 3

	rest, output, len = parser('r#"12"34;"#')!
	// assert output == 'r#"12\"34"#'
	// assert rest == ';'

	parser1 := escaped(alpha1, `\\`, one_of('"n\\'))
	parser2 := escaped(digit1, `\\`, one_of('"n\\'))

	rest, output, len = parser1('abcd;')!
	assert output == 'abcd'
	assert rest == ';'
	assert len == 4

	rest, output, len = parser1('ab\\"cd;')!
	assert output == 'ab\\"cd'
	assert rest == ';'
	assert len == 6

	rest, output, len = parser1('\\"abcd;')!
	assert output == '\\"abcd'
	assert rest == ';'
	assert len == 6

	rest, output, len = parser1('\\n;')!
	assert output == '\\n'
	assert rest == ';'
	assert len == 2

	rest, output, len = parser1('ab\\"12')!
	assert output == 'ab\\"'
	assert rest == '12'
	assert len == 4

	rest, output, len = parser2('12\\nnn34')!
	assert output == '12\\n'
	assert rest == 'nn34'
	assert len == 4

	rest, output, len = parser('AB\\') or { 'err', 'err', 99 }
	assert output == 'err'
	assert rest == 'err'
	assert len == 99

	rest, output, len = parser('AB\\A') or { 'err', 'err', 99 }
	assert output == 'err'
	assert rest == 'err'
	assert len == 99
}

fn test_is_a() ! {
	parser := is_a('123456789ABCDEF')
	rest, output, len := parser('DEADBEEF and others')!
	assert output == 'DEADBEEF'
	assert rest == ' and others'
	assert len == 8
}

fn test_is_not() ! {
	parser := is_not(' \t\r\n')
	rest, output, len := parser('Hello,\tWorld!')!
	assert output == 'Hello,'
	assert rest == '\tWorld!'
	assert len == 6
}

fn test_tag() ! {
	parser := tag('- ')
	rest, output, len := parser('- Something something')!
	assert output == '- '
	assert rest == 'Something something'
	assert len == 2
}

fn test_tag_no_case() ! {
	parser := tag_no_case('hEllo')
	rest, output, len := parser('HeLLo, World!')!
	assert output == 'HeLLo'
	assert rest == ', World!'
	assert len == 5
}

fn test_take() ! {
	parser := take(5)
	rest, output, len := parser('Hello, world!')!
	assert output == 'Hello'
	assert rest == ', world!'
	assert len == 5
}

fn test_take_till() ! {
	parser := take_till(fn (b u8) bool {
		return b == `:`
	})
	rest, output, len := parser('latin:123')!
	assert output == 'latin'
	assert rest == ':123'
	assert len == 5
}

fn test_take_till1() ! {
	parser := take_till1(fn (b u8) bool {
		return b == `:`
	})
	rest, output, len := parser(':latin:123')!
	assert output == ':latin'
	assert rest == ':123'
	assert len == 6
}

fn test_take_until() ! {
	parser := take_until('eof')
	rest, output, len := parser('hello, worldeof')!
	assert output == 'hello, world'
	assert rest == 'eof'
	assert len == 12
}

fn test_take_until1() ! {
	parser := take_until1('eof')
	rest, output, len := parser('heof')!
	assert output == 'h'
	assert rest == 'eof'
	assert len == 1
}

fn test_take_while() ! {
	parser := take_while(is_alphabetic)
	rest, output, len := parser('latin123')!
	assert output == 'latin'
	assert rest == '123'
	assert len == 5
}

fn test_take_while1() ! {
	parser := take_while1(is_alphabetic)
	rest, output, len := parser('l123')!
	assert output == 'l'
	assert rest == '123'
	assert len == 1
}

fn test_take_while_m_n() ! {
	mut rest := ''
	mut output := ''
	mut len := 0
	parser := take_while_m_n(2, 2, is_hex_digit)
	rest, output, len = parser('DEab12')!
	assert output == 'DE'
	assert rest == 'ab12'
	assert len == 2

	rest, output, len = parser(rest)!
	assert output == 'ab'
	assert rest == '12'
	assert len == 2

	rest, output, len = parser(rest)!
	assert output == '12'
	assert rest == ''
	assert len == 2
}
