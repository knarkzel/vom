module vom

fn test_all_consuming() ! {
	mut rest := ''
	mut output := ''
	parser := all_consuming(alpha1)
	rest, output = parser('abcd')!
	assert output == 'abcd'
	assert rest == ''
	rest, output = parser('abcd1') or { 'err', 'err' }
	assert output == 'err'
	assert rest == 'err'
}

fn test_cond() ! {
	mut rest := ''
	mut output := ''
	parser := fn (b bool, i string) !(string, string) {
		temp := cond(b, alpha1)
		return temp(i)
	}
	rest, output = parser(true, 'abcd;')!
	assert output == 'abcd'
	assert rest == ';'
	rest, output = parser(false, 'abcd;')!
	assert output == ''
	assert rest == 'abcd;'
}

fn test_recognize() ! {
	mut rest := ''
	mut output := ''
	parser := recognize(separated_pair(alpha1, tag(','), alpha1))
	rest, output = parser('abcd,efgh')!
	assert output == 'abcd,efgh'
	assert rest == ''
}

fn test_eof() ! {
	mut rest := ''
	mut output := ''
	rest, output = eof('')!
	assert output == ''
	assert rest == ''
	rest, output = eof('abc') or { 'err', 'err' }
	assert output == 'err'
	assert rest == 'err'
}

fn test_fail() ! {
	mut rest := ''
	mut output := ''
	rest, output = fail('string') or { 'err', 'err' }
	assert rest == 'err'
	assert output == 'err'
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
	mut rest := ''
	mut output := ''
	parser := not(alpha1)
	rest, output = parser('123')!
	assert output == ''
	assert rest == '123'
	rest, output = parser('abc') or { 'err', 'err' }
	assert output == 'err'
	assert rest == 'err'
}

fn test_opt() ! {
	mut rest := ''
	mut output := ''
	parser := opt(alpha1)
	rest, output = parser('abcd;')!
	assert output == 'abcd'
	assert rest == ';'
	rest, output = parser('123;')!
	assert output == ''
	assert rest == '123;'
}

fn test_peek() ! {
	mut rest := ''
	mut output := ''
	parser := peek(alpha1)
	rest, output = parser('abcd;')!
	assert output == 'abcd'
	assert rest == 'abcd;'
	rest, output = parser('123;') or { 'err', 'err' }
	assert output == 'err'
	assert rest == 'err'
}

fn test_value() ! {
	mut output := 0
	parser := value(1234, alpha1)
	output = parser('abcd')!
	assert output == 1234

	output = parser('4323abcd') or { 99 }
	assert output == 99
}

fn string_len_equ_4(input string) bool {
	return input.len == 4
}

fn test_verify() ! {
	mut output := ''
	parser := verify(alpha1, string_len_equ_4)
	output = parser('abcd')!
	assert output == 'abcd'

	output = parser('abcde') or { 'err' }
	assert output == 'err'
}
