module vom

fn test_tag() ? {
	input := '- Something something'
	parser := tag('- ')
	rest, output := parser(input) ?
	assert output == '- '
	assert rest == 'Something something'
}

fn test_take() ? {
	input := 'Hello, world!'
	parser := take(5)
	rest, output := parser(input) ?
	assert output == 'Hello'
	assert rest == ', world!'
}
