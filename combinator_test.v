module vom

fn test_all_consuming() ! {
	mut rest := ''
	mut output := ''
	mut len := 0
	parser := all_consuming(alpha1)
	rest, output, len = parser('abcd')!
	assert output == 'abcd'
	assert rest == ''
	assert len == 4

	rest, output, len = parser('abcd1') or { 'err', 'err', 99 }
	assert output == 'err'
	assert rest == 'err'
	assert len == 99
}

fn test_cond() ! {
	mut rest := ''
	mut output := ''
	mut len := 0
	parser := fn (b bool, i string) !(string, string, int) {
		temp := cond(b, alpha1)
		return temp(i)
	}
	rest, output, len = parser(true, 'abcd;')!
	assert output == 'abcd'
	assert rest == ';'
	assert len == 4

	rest, output, len = parser(false, 'abcd;')!
	assert output == ''
	assert rest == 'abcd;'
	assert len == 0
}

fn test_recognize() ! {
	mut rest := ''
	mut output := ''
	mut len := 0
	parser := recognize(separated_pair(alpha1, tag(','), alpha1))
	rest, output, len = parser('abcd,efgh')!
	assert output == 'abcd,efgh'
	assert rest == ''
	assert len == 9
}

fn test_eof() ! {
	mut rest := ''
	mut output := ''
	mut len := 0
	rest, output, len = eof('')!
	assert output == ''
	assert rest == ''
	assert len == 0

	rest, output, len = eof('abc') or { 'err', 'err', 99 }
	assert output == 'err'
	assert rest == 'err'
	assert len == 99
}

fn test_fail() ! {
	mut rest := ''
	mut output := ''
	mut len := 0
	rest, output, len = fail('string') or { 'err', 'err', 99 }
	assert rest == 'err'
	assert output == 'err'
	assert len == 99
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
	mut len := 0
	parser := not(alpha1)
	rest, output, len = parser('123')!
	assert output == ''
	assert rest == '123'
	assert len == 0

	rest, output, len = parser('abc') or { 'err', 'err', 99 }
	assert output == 'err'
	assert rest == 'err'
	assert len == 99
}

fn test_opt() ! {
	mut rest := ''
	mut output := ''
	mut len := 0
	parser := opt(alpha1)
	rest, output, len = parser('abcd;')!
	assert output == 'abcd'
	assert rest == ';'
	assert len == 4

	rest, output, len = parser('123;')!
	assert output == ''
	assert rest == '123;'
	assert len == 0
}

fn test_peek() ! {
	mut rest := ''
	mut output := ''
	mut len := 0
	parser := peek(alpha1)
	rest, output, len = parser('abcd;')!
	assert output == 'abcd'
	assert rest == 'abcd;'
	assert len == 4

	rest, output, len = parser('123;') or { 'err', 'err', 99 }
	assert output == 'err'
	assert rest == 'err'
	assert len == 99
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
