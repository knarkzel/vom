module vom

fn test_count() ! {
	parser := count(tag('abc'), 2)
	rest, output, len := parser('abcabcabc')!
	assert output == ['abc', 'abc']
	assert rest == 'abc'
	assert len == 6
}

fn test_fill() ! {
	mut buffer := ['', '', '']
	parser := fill(tag('abc'), mut buffer)
	rest, _, len := parser('abcabcabc123')!
	assert buffer == ['abc', 'abc', 'abc']
	assert rest == '123'
	assert len == 9
}

fn init_function() []string {
	mut vec := []string{}
	return vec
}

fn gather_function(item string, mut vec []string) {
	vec << item
}

fn test_fold_many0() ! {
	parser := fold_many0(tag('abc'), init_function, gather_function)
	mut rest := ''
	mut output := []string{}
	mut len := 0
	rest, output, len = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	assert len == 6

	rest, output, len = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	assert len == 3

	rest, output, len = parser('')!
	assert output == []
	assert rest == ''
	assert len == 0
}

fn test_fold_many1() ! {
	parser := fold_many1(tag('abc'), init_function, gather_function)
	mut rest := ''
	mut output := []string{}
	mut len := 0
	rest, output, len = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	assert len == 6

	rest, output, len = parser('123123') or { 'err', ['err'], 99 }
	assert output == ['err']
	assert rest == 'err'
	assert len == 99

	rest, output, len = parser('') or { 'err', ['err'], 99 }
	assert output == ['err']
	assert rest == 'err'
	assert len == 99
}

fn test_fold_many_m_n() ! {
	parser := fold_many_m_n(0, 2, tag('abc'), init_function, gather_function)
	mut rest := ''
	mut output := []string{}
	mut len := 0
	rest, output, len = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	assert len == 6

	rest, output, len = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	assert len == 3

	rest, output, len = parser('123123')!
	assert output == []
	assert rest == '123123'
	assert len == 0

	rest, output, len = parser('abcabcabc')!
	assert output == ['abc', 'abc']
	assert rest == 'abc'
	assert len == 6
}

fn test_length_count() ! {
}

fn test_many0() ! {
	parser := many0(tag('abc'))
	mut rest := ''
	mut output := []string{}
	mut len := 0
	rest, output, len = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	assert len == 6

	rest, output, len = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	assert len == 3

	rest, output, len = parser('123123')!
	assert output == []
	assert rest == '123123'
	assert len == 0

	rest, output, len = parser('')!
	assert output == []
	assert rest == ''
	assert len == 0
}

fn test_many0_count() ! {
	parser := many0_count(tag('abc'))
	mut rest := ''
	mut output := usize(0)
	mut len := 0
	rest, output, len = parser('abcabc')!
	assert output == 2
	assert rest == ''
	assert len == 6

	rest, output, len = parser('abc123')!
	assert output == 1
	assert rest == '123'
	assert len == 3

	rest, output, len = parser('123123')!
	assert output == 0
	assert rest == '123123'
	assert len == 0

	rest, output, len = parser('')!
	assert output == 0
	assert rest == ''
	assert len == 0
}

fn test_many1() ! {
	parser := many1(tag('abc'))
	mut rest := ''
	mut output := []string{}
	mut len := 0
	rest, output, len = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	assert len == 6

	rest, output, len = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	assert len == 3

	rest, output, len = parser('123123') or { 'err', ['err'], 99 }
	assert output == ['err']
	assert rest == 'err'
	assert len == 99

	rest, output, len = parser('') or { 'err', ['err'], 99 }
	assert output == ['err']
	assert rest == 'err'
	assert len == 99
}

fn test_many1_count() ! {
	parser := many1_count(tag('abc'))
	mut rest := ''
	mut output := usize(0)
	mut len := 0
	rest, output, len = parser('abcabc')!
	assert output == 2
	assert rest == ''
	assert len == 6

	rest, output, len = parser('abc123')!
	assert output == 1
	assert rest == '123'
	assert len == 3

	rest, output, len = parser('123123') or { 'err', usize(99), 99 }
	assert output == usize(99)
	assert rest == 'err'
	assert len == 99

	rest, output, len = parser('') or { 'err', usize(99), 99 }
	assert output == usize(99)
	assert rest == 'err'
	assert len == 99
}

fn test_many_m_n() ! {
	parser := many_m_n(0, 2, tag('abc'))
	mut rest := ''
	mut output := []string{}
	mut len := 0
	rest, output, len = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	assert len == 6

	rest, output, len = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	assert len == 3

	rest, output, len = parser('123123')!
	assert output == []
	assert rest == '123123'
	assert len == 0

	rest, output, len = parser('')!
	assert output == []
	assert rest == ''
	assert len == 0
}

fn test_many_till() ! {
	parser := many_till(tag('abc'), tag('end'))
	mut rest := ''
	mut output := []string{}
	mut result := ''
	mut len := 0

	rest, output, result, len = parser('abcabcend')!
	assert rest == ''
	assert output == ['abc', 'abc']
	assert result == 'end'
	assert len == 9

	rest, output, result, len = parser('abc123end') or { 'err', ['err'], 'err', 99 }
	assert rest == 'err'
	assert output == ['err']
	assert result == 'err'
	assert len == 99

	rest, output, result, len = parser('123123end') or { 'err', ['err'], 'err', 99 }
	assert rest == 'err'
	assert output == ['err']
	assert result == 'err'
	assert len == 99

	rest, output, result, len = parser('') or { 'err', ['err'], 'err', 99 }
	assert rest == 'err'
	assert output == ['err']
	assert result == 'err'
	assert len == 99

	rest, output, result, len = parser('abcendefg')!
	assert rest == 'efg'
	assert output == ['abc']
	assert result == 'end'
	assert len == 6
}

fn test_separated_list0() ! {
	parser := separated_list0(tag(','), tag('abcd'))
	mut rest := ''
	mut output := []string{}
	mut len := 0

	rest, output, len = parser('abcdef')!
	assert rest == 'ef'
	assert output == ['abcd']
	assert len == 4

	rest, output, len = parser('abcd,abcdef')!
	assert rest == 'ef'
	assert output == ['abcd', 'abcd']
	assert len == 9

	rest, output, len = parser('azerty')!
	assert rest == 'azerty'
	assert output == []
	assert len == 0

	rest, output, len = parser(',,abc')!
	assert rest == 'abc'
	assert output == []
	assert len == 2

	rest, output, len = parser('abcd,abcd,ef')!
	assert rest == 'ef'
	assert output == ['abcd', 'abcd']
	assert len == 10

	rest, output, len = parser('abc')!
	assert rest == 'abc'
	assert output == []
	assert len == 0

	rest, output, len = parser('abcd.')!
	assert rest == '.'
	assert output == ['abcd']
	assert len == 4

	rest, output, len = parser('abcd,abc')!
	assert rest == 'abc'
	assert output == ['abcd']
	assert len == 5
}

fn test_separated_list1() ! {
	parser := separated_list1(tag(','), tag('abcd'))
	mut rest := ''
	mut output := []string{}
	mut len := 0

	rest, output, len = parser('abcdef')!
	assert rest == 'ef'
	assert output == ['abcd']
	assert len == 4

	rest, output, len = parser('abcd,abcdef')!
	assert rest == 'ef'
	assert output == ['abcd', 'abcd']
	assert len == 9

	rest, output, len = parser('azerty') or { 'err', ['err'], 99 }
	assert rest == 'err'
	assert output == ['err']
	assert len == 99

	rest, output, len = parser(',,abc') or { 'err', ['err'], 99 }
	assert rest == 'err'
	assert output == ['err']
	assert len == 99
}
