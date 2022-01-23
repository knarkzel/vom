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

fn test_condition() ? {
	parser := fn (b bool, i string) ?(string, string) {
		temp := condition(b, alpha1)
		return temp(i)
	}
	rest, output := parser(true, 'abcd;') ?
	assert output == 'abcd'
	assert rest == ';'
	rest1, output1 := parser(false, 'abcd;') ?
	assert output1 == ''
	assert rest1 == 'abcd;'
}

fn test_recognize() ? {
	parser := recognize(separated_pair(alpha1, tag(','), alpha1))
	rest, output := parser('abcd,efgh') ?
	assert output == 'abcd,efgh'
	assert rest == ''
}
