module vom

fn test_tuple() ! {
	parser := tuple([tag('#'), take(5), tag(' :D')])
	rest, output, len := parser('#hello :D...')!
	assert output == ['#', 'hello', ' :D']
	assert rest == '...'
	assert len == 9
}

fn test_delimited() ! {
	parser := delimited(tag('<h1>'), take(6), tag('</h1>'))
	rest, output, len := parser('<h1>Hello!</h1>...')!
	assert output == 'Hello!'
	assert rest == '...'
	assert len == 15
}

fn test_pair() ! {
	parser := pair(tag('vlang'), tag('awesome'))
	rest, output, len := parser('vlangawesome!')!
	assert output == ['vlang', 'awesome']
	assert rest == '!'
	assert len == 12
}

fn test_separated_pair() ! {
	parser := separated_pair(take(5), tag(','), take(7))
	rest, output, len := parser('vlang,awesome!')!
	assert output == ['vlang', 'awesome']
	assert rest == '!'
	assert len == 13
}

fn test_preceded() ! {
	parser := preceded(tag('- '), take(4))
	rest, output, len := parser('- list!')!
	assert output == 'list'
	assert rest == '!'
	assert len == 6
}

fn test_terminated() ! {
	parser := terminated(take(2), tag(' {'))
	rest, output, len := parser('fn {}')!
	assert output == 'fn'
	assert rest == '}'
	assert len == 4
}

fn test_concat() ! {
	parser := concat([tag('ab'), tag('bd'), tag('c')])
	rest, output, len := parser('abbdc,dd')!
	assert output == 'abbdc'
	assert rest == ',dd'
	assert len == 5
}
