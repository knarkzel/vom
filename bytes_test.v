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

fn test_is_a() ? {
	mut input := '123 and voila'
	parser := is_a('123456789ABCDEF')
	mut rest, mut output := parser(input) ?
	assert output == '123'
	assert rest == ' and voila'

	input = 'DEADBEEF and others'
	rest, output = parser(input) ?
	assert output == 'DEADBEEF'
	assert rest == ' and others'
}

fn test_is_not() ? {
	mut input := 'Hello, World!'
	parser := is_not(' \t\r\n')
	mut rest, mut output := parser(input) ?
	assert output == 'Hello,'
	assert rest == ' World!'

	input = 'Sometimes\t'
	rest, output = parser(input) ?
	assert output == 'Sometimes'
	assert rest == '\t'
}
