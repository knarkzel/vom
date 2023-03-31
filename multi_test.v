module vom

fn test_count() ! {
	parser := count(tag('abc'), 2)
	rest, output := parser('abcabcabc')!
	assert output == ['abc', 'abc']
	assert rest == 'abc'
}

fn test_fill() ! {
	mut buffer := ['', '', '']
	parser := fill(tag('abc'), mut buffer)
	rest, _ := parser('abcabcabc123')!
	assert buffer == ['abc', 'abc', 'abc']
	assert rest == '123'
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
	rest, output = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	rest, output = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	rest, output = parser('')!
	assert output == []
	assert rest == ''
}

fn test_fold_many1() ! {
	parser := fold_many1(tag('abc'), init_function, gather_function)
	mut rest := ''
	mut output := []string{}
	rest, output = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	rest, output = parser('123123') or { 'err', ['err'] }
	assert output == ['err']
	assert rest == 'err'
	rest, output = parser('') or { 'err', ['err'] }
	assert output == ['err']
	assert rest == 'err'
}

fn test_fold_many_m_n() ! {
	parser := fold_many_m_n(0, 2, tag('abc'), init_function, gather_function)
	mut rest := ''
	mut output := []string{}
	rest, output = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	rest, output = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	rest, output = parser('123123')!
	assert output == []
	assert rest == '123123'
	rest, output = parser('abcabcabc')!
	assert output == ['abc', 'abc']
	assert rest == 'abc'
}

fn test_length_count() ! {
}

fn test_many0() ! {
	parser := many0(tag('abc'))
	mut rest := ''
	mut output := []string{}
	rest, output = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	rest, output = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	rest, output = parser('123123')!
	assert output == []
	assert rest == '123123'
	rest, output = parser('')!
	assert output == []
	assert rest == ''
}

fn test_many0_count() ! {
	parser := many0_count(tag('abc'))
	mut rest := ''
	mut output := usize(0)
	rest, output = parser('abcabc')!
	assert output == 2
	assert rest == ''
	rest, output = parser('abc123')!
	assert output == 1
	assert rest == '123'
	rest, output = parser('123123')!
	assert output == 0
	assert rest == '123123'
	rest, output = parser('')!
	assert output == 0
	assert rest == ''
}

fn test_many1() ! {
	parser := many1(tag('abc'))
	mut rest := ''
	mut output := []string{}
	rest, output = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	rest, output = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	rest, output = parser('123123') or { 'err', ['err'] }
	assert output == ['err']
	assert rest == 'err'
	rest, output = parser('') or { 'err', ['err'] }
	assert output == ['err']
	assert rest == 'err'
}

fn test_many1_count() ! {
	parser := many1_count(tag('abc'))
	mut rest := ''
	mut output := usize(0)
	rest, output = parser('abcabc')!
	assert output == 2
	assert rest == ''
	rest, output = parser('abc123')!
	assert output == 1
	assert rest == '123'
	rest, output = parser('123123') or { 'err', usize(99) }
	assert output == usize(99)
	assert rest == 'err'
	rest, output = parser('') or { 'err', usize(99) }
	assert output == usize(99)
	assert rest == 'err'
}

fn test_many_m_n() ! {
	parser := many_m_n(0, 2, tag('abc'))
	mut rest := ''
	mut output := []string{}
	rest, output = parser('abcabc')!
	assert output == ['abc', 'abc']
	assert rest == ''
	rest, output = parser('abc123')!
	assert output == ['abc']
	assert rest == '123'
	rest, output = parser('123123')!
	assert output == []
	assert rest == '123123'
	rest, output = parser('')!
	assert output == []
	assert rest == ''
}

fn test_many_till() ! {
	parser := many_till(tag('abc'), tag('end'))
	mut rest := ''
	mut output := []string{}
	mut result := ''

	rest, output, result = parser('abcabcend')!
	assert rest == ''
	assert output == ['abc', 'abc']
	assert result == 'end'

	rest, output, result = parser('abc123end') or { 'err', ['err'], 'err' }
	assert rest == 'err'
	assert output == ['err']
	assert result == 'err'

	rest, output, result = parser('123123end') or { 'err', ['err'], 'err' }
	assert rest == 'err'
	assert output == ['err']
	assert result == 'err'

	rest, output, result = parser('') or { 'err', ['err'], 'err' }
	assert rest == 'err'
	assert output == ['err']
	assert result == 'err'

	rest, output, result = parser('abcendefg')!
	assert rest == 'efg'
	assert output == ['abc']
	assert result == 'end'
}

fn test_separated_list0() ! {
	parser := separated_list0(tag(','), tag('abcd'))
	mut rest := ''
	mut output := []string{}

	rest, output = parser('abcdef')!
	assert rest == 'ef'
	assert output == ['abcd']

	rest, output = parser('abcd,abcdef')!
	assert rest == 'ef'
	assert output == ['abcd', 'abcd']

	rest, output = parser('azerty')!
	assert rest == 'azerty'
	assert output == []

	rest, output = parser(',,abc')!
	assert rest == 'abc'
	assert output == []

	rest, output = parser('abcd,abcd,ef')!
	assert rest == 'ef'
	assert output == ['abcd', 'abcd']

	rest, output = parser('abc')!
	assert rest == 'abc'
	assert output == []

	rest, output = parser('abcd.')!
	assert rest == '.'
	assert output == ['abcd']

	rest, output = parser('abcd,abc')!
	assert rest == 'abc'
	assert output == ['abcd']
}

fn test_separated_list1() ! {
	parser := separated_list1(tag(','), tag('abcd'))
	mut rest := ''
	mut output := []string{}

	rest, output = parser('abcdef')!
	assert rest == 'ef'
	assert output == ['abcd']

	rest, output = parser('abcd,abcdef')!
	assert rest == 'ef'
	assert output == ['abcd', 'abcd']

	rest, output = parser('azerty') or { 'err', ['err'] }
	assert rest == 'err'
	assert output == ['err']

	rest, output = parser(',,abc') or { 'err', ['err'] }
	assert rest == 'err'
	assert output == ['err']
}
