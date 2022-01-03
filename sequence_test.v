module vom

import complete { tag, take }

fn test_tuple() ? {
	input := '#hello :D'
	parser := tuple(tag('#'), take(5), tag(' :D'))
	_, output := parser(input) ?
	assert output == ['#', 'hello', ' :D']
}

fn test_delimited() ? {
	input := '<h1>Hello!</h1>'
	parser := delimited(tag('<h1>'), take(6), tag('</h1>'))
	_, output := parser(input) ?
	assert output == 'Hello!'
}

fn test_separated_pair() ? {
	input := 'vlang,awesome'
	parser := separated_pair(take(5), tag(','), take(7))
	_, output := parser(input) ?
	assert output == ['vlang', 'awesome']
}

fn test_preceded() ? {
	input := '- list'
	parser := preceded(tag('- '), take(4))
	_, output := parser(input) ?
	assert output == 'list'
}

fn test_terminated() ? {
	input := 'fn {'
	parser := terminated(take(2), tag(' {'))
	_, output := parser(input) ?
	assert output == 'fn'
}
