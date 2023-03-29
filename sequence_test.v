module vom

fn test_tuple() ! {
	parser := tuple(tag('#'), take(5), tag(' :D'))
	rest, output := parser('#hello :D...')!
	assert output == ['#', 'hello', ' :D']
	assert rest == '...'
}

fn test_delimited() ! {
	parser := delimited(tag('<h1>'), take(6), tag('</h1>'))
	rest, output := parser('<h1>Hello!</h1>...')!
	assert output == 'Hello!'
	assert rest == '...'
}

fn test_pair() ! {
	parser := pair(tag('vlang'), tag('awesome'))
	rest, output := parser('vlangawesome!')!
	assert output == ['vlang','awesome']
	assert rest == '!'
}

fn test_separated_pair() ! {
	parser := separated_pair(take(5), tag(','), take(7))
	rest, output := parser('vlang,awesome!')!
	assert output == ['vlang', 'awesome']
	assert rest == '!'
}

fn test_preceded() ! {
	parser := preceded(tag('- '), take(4))
	rest, output := parser('- list!')!
	assert output == 'list'
	assert rest == '!'
}

fn test_terminated() ! {
	parser := terminated(take(2), tag(' {'))
	rest, output := parser('fn {}')!
	assert output == 'fn'
	assert rest == '}'
}
