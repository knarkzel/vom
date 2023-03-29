module vom

fn test_escaped() ! {
	mut rest := ''
	mut output := ''

	parser := escaped(digit1, `\\`, one_of('r#""n"#'))
	rest, output = parser('123;')!
	assert output == '123'
	assert rest == ';'

	rest, output = parser('r#"12"34;"#')!
	// assert output == 'r#"12\"34"#'
	// assert rest == ';'

	parser1 := escaped(alpha1, `\\`, one_of('"n\\'))
	parser2 := escaped(digit1, `\\`, one_of('"n\\'))

	rest, output = parser1('abcd;')!
	assert output == 'abcd'
	assert rest == ';'

	rest, output = parser1('ab\\"cd;')!
	assert output == 'ab\\"cd'
	assert rest == ';'

	rest, output = parser1('\\"abcd;')!
	assert output == '\\"abcd'
	assert rest == ';'

	rest, output = parser1('\\n;')!
	assert output == '\\n'
	assert rest == ';'

	rest, output = parser1('ab\\"12')!
	assert output == 'ab\\"'
	assert rest == '12'

	rest, output = parser2('12\\nnn34')!
	assert output == '12\\n'
	assert rest == 'nn34'

	rest, output = parser('AB\\') or { 'err', 'err' }
	assert output == 'err'
	assert rest == 'err'
	rest, output = parser('AB\\A') or { 'err', 'err' }
	assert output == 'err'
	assert rest == 'err'
}

fn test_is_a() ! {
	parser := is_a('123456789ABCDEF')
	rest, output := parser('DEADBEEF and others')!
	assert output == 'DEADBEEF'
	assert rest == ' and others'
}

fn test_is_not() ! {
	parser := is_not(' \t\r\n')
	rest, output := parser('Hello,\tWorld!')!
	assert output == 'Hello,'
	assert rest == '\tWorld!'
}

fn test_tag() ! {
	parser := tag('- ')
	rest, output := parser('- Something something')!
	assert output == '- '
	assert rest == 'Something something'
}

fn test_tag_no_case() ! {
	parser := tag_no_case('hEllo')
	rest, output := parser('HeLLo, World!')!
	assert output == 'HeLLo'
	assert rest == ', World!'
}

fn test_take() ! {
	parser := take(5)
	rest, output := parser('Hello, world!')!
	assert output == 'Hello'
	assert rest == ', world!'
}

fn test_take_till() ! {
	parser := take_till(fn (b byte) bool {
		return b == `:`
	})
	rest, output := parser('latin:123')!
	assert output == 'latin'
	assert rest == ':123'
}

fn test_take_till1() ! {
	parser := take_till1(fn (b byte) bool {
		return b == `:`
	})
	rest, output := parser(':latin:123')!
	assert output == ':latin'
	assert rest == ':123'
}

fn test_take_until() ! {
	parser := take_until('eof')
	rest, output := parser('hello, worldeof')!
	assert output == 'hello, world'
	assert rest == 'eof'
}

fn test_take_until1() ! {
	parser := take_until1('eof')
	rest, output := parser('heof')!
	assert output == 'h'
	assert rest == 'eof'
}

fn test_take_while() ! {
	parser := take_while(is_alphabetic)
	rest, output := parser('latin123')!
	assert output == 'latin'
	assert rest == '123'
}

fn test_take_while1() ! {
	parser := take_while1(is_alphabetic)
	rest, output := parser('l123')!
	assert output == 'l'
	assert rest == '123'
}

fn test_take_while_m_n() ! {
	parser := take_while_m_n(2, 2, is_hex_digit)
	rest, output := parser('DEab12')!
	assert output == 'DE'
	assert rest == 'ab12'
	rest1, output1 := parser(rest)!
	assert output1 == 'ab'
	assert rest1 == '12'
	rest2, output2 := parser(rest1)!
	assert output2 == '12'
	assert rest2 == ''
}
