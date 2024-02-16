module vom

fn test_regex() ! {
	parser := Regex{expr:'((a|b)c*)+'}
	rest, output, len := parser('acc')
	assert rest == ''
	assert output == 'acc'
	assert len == 3
}

