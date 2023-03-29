module vom

fn test_all_consuming() ! {
	parser := all_consuming(alpha1)
	rest, output := parser('abcd') !
	assert output == 'abcd'
	assert rest == ''
	parser('abcd1') or { assert true }
}

fn test_cond() ! {
	parser := fn (b bool, i string) !(string, string) {
		temp := cond(b, alpha1)
		return temp(i)
	}
	rest, output := parser(true, 'abcd;') ! 
	assert output == 'abcd'
	assert rest == ';'
	rest1, output1 := parser(false, 'abcd;') !
	assert output1 == ''
	assert rest1 == 'abcd;'
}

fn test_recognize() ! {
	parser := recognize(separated_pair(alpha1, tag(','), alpha1))
	rest, output := parser('abcd,efgh') !
	assert output == 'abcd,efgh'
	assert rest == ''
}

fn test_eof() ! {
	rest, output := eof('') !
	assert output == ''
	assert rest == ''
	if _,_ := eof('abc') {
		assert false
	} else {
		assert true
	}
}

fn test_fail() ! {
	if _,_ := fail('string') {
		assert false
	} else {
		assert true
	}
}

/*
fn test_flat_map() ! {
	parser := flat_map(u8, take)
	rest, output := parser('2 78334') !
	assert rest == '334'
	assert output == '78'
}
*/

// fn test_map() ! {
//}

fn test_not() ! {
	parser := not(alpha1)
	rest, output := parser('123') !
	assert output == ''
	assert rest == '123'
	parser('1234') or { assert true }
}

fn test_opt() ! {
	parser := opt(alpha1)
	rest, output := parser('abcd;') !
	assert output == 'abcd'
	assert rest == ';'
	rest1, output1 := parser('123;') !
	assert output1 == ''
	assert rest1 == '123;'
}

fn test_peek() ! {
	parser := peek(alpha1)
	rest, output := parser('abcd;') !
	assert output == 'abcd'
	assert rest == 'abcd;'
	parser('123;') or { assert true }
}

fn test_value() ! {
	parser := value(1234, alpha1)
	output := parser('abcd') or { 5678 }
	assert output == 1234

	output1 := parser('4323abcd') or { 5678 }
	assert output1 == 5678
}

