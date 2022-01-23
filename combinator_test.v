module vom

fn test_all_consuming() ? {
	parser := all_consuming(alpha1)
	rest, output := parser('abcd') ?
	assert output == 'abcd'
	assert rest == ''
	if _ := parser('abcd1') {
		assert false
	} else {
		assert true
	}
}
