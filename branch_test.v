module vom

fn test_alt() ! {
	parser := alt([tag('llo'), take(9), tag('hi'), take(5)])
	rest, output, len := parser('hello...')!
	assert output == 'hello'
	assert rest == '...'
	assert len == 5
}

fn test_permutation() ! {
	parser := permutation([tag('123'), tag('abc')])
	rest, output, len := parser('abc123123abc...')!
	assert output == ['abc', '123']
	assert rest == '123abc...'
	assert len == 6
}
