module vom

fn test_tuple() ? {
	input := '#hello :D...'
	parser := tuple(tag('#'), take(5), tag(' :D'))
	rest, output := parser(input) ?
	assert output == ['#', 'hello', ' :D']
	assert rest == '...'
}

fn test_delimited() ? {
	input := '<h1>Hello!</h1>...'
	parser := delimited(tag('<h1>'), take(6), tag('</h1>'))
	rest, output := parser(input) ?
	assert output == 'Hello!'
	assert rest == '...'
}

fn test_separated_pair() ? {
	input := 'vlang,awesome!'
	parser := separated_pair(take(5), tag(','), take(7))
	rest, output := parser(input) ?
	assert output == ['vlang', 'awesome']
	assert rest == '!'
}

fn test_preceded() ? {
	input := '- list!'
	parser := preceded(tag('- '), take(4))
	rest, output := parser(input) ?
	assert output == 'list'
	assert rest == '!'
}

fn test_terminated() ? {
	input := 'fn {}'
	parser := terminated(take(2), tag(' {'))
	rest, output := parser(input) ?
	assert output == 'fn'
	assert rest == '}'
}
