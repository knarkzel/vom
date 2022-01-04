module vom

fn test_branch() ? {
	input := 'hello...'
	parser := branch(tag('llo'), take(9), tag('hi'), take(5))
	rest, output := parser(input) ?
	assert output == 'hello'
	assert rest == '...'
}

fn test_permutation() ? {
	input := 'abc123123abc...'
	parser := permutation(tag('123'), tag('abc'))
	mut rest, mut output := parser(input) ?
	assert output == ['abc', '123']

	rest, output = parser(rest) ?
	assert last_output == ['123', 'abc']
	assert last_rest == '...'
}
