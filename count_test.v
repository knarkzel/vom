module vom

fn test_count() ? {
	parser := count(tag('abc'), 2)
	rest, output := parser('abcabcabc') ?
	assert output == ['abc', 'abc']
	assert rest == 'abc'
}

fn test_fill() ? {
	mut buffer := ['', '', '']
	parser := fill(tag('abc'), mut buffer)
	rest, _ := parser('abcabcabc123') ?
	assert buffer == ['abc', 'abc', 'abc']
	assert rest == '123'
}
