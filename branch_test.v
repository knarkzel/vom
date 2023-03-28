module vom

fn test_alt() ! {
	parser := alt(tag('llo'), take(9), tag('hi'), take(5))
	rest, output := parser('hello...') !
	assert output == 'hello'
	assert rest == '...'
}

fn test_permutation() ! {
	parser := permutation(tag('123'), tag('abc'))
	rest, output := parser('abc123123abc...') !
	assert output == ['abc', '123']
	assert rest == '123abc...'
}
