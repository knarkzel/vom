module vom

fn test_branch() ? {
	input := 'hello...'
	parser := branch(tag('llo'), take(9), tag('hi'), take(5))
	rest, output := parser(input) ?
	assert output == 'hello'
	assert rest == '...'
}

fn test_permutation() ? {
	input := 'abc123123abc'
	parser := permutation(tag('123'), tag('abc'))
	rest, output := parser(input) ?
	assert output == ['abc', '123']
	last_rest, last_output := parser(rest) ?
	assert last_output == ['123', 'abc']
}
