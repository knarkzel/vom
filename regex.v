module vom

// https://www.cnblogs.com/baiyuxuan/p/15430458.html
// 从字符串生成Regex

pub struct Regex {
	expr	string
mut:	ind	int
}

fn (r Regex) peek() char {
	return expr[ind]
}

fn (r Regex) next() char {
	c := expr[ind]
	ind ++
	return c
}

fn (r Regex) read(c char) ! {
	if c != next() {
		return error('expected: ${c}')
	}
}

fn (r Regex) end() bool {
	return ind == expr.len
}

fn (r Regex) parse() ! {
	ind = 0
	return parse_expr()
}

// elem = char | (expr)
fn (r Regex) parse_elem() ! {
	if peek() == `(` {
		next()
		rr := parse_expr()
		read(`)`)
		return rr
	} else if peek() == `.` {
		next()
		return any()
	} else {
		return ch(next())
	}
}

// factor = elem* | elem+ | elem
fn (r Regex) parse_factor() ! {
	mut r := parse_elem()
	if !end() && peek() == `*` {
		r = r.zeroOrMore()
		next()
	} else if !end() && peek() == `+` {
		r = r.oneOrMore()
		next()
	}
	return r
}

// term = factor factor ... factor
fn (r Regex) parse_term() ! {
	mut r := parse_factor()
	for !end() && peek() != ')' && peek() != '|' {
		r = r.concat(parseFactor())
	}
	return r
}

// expr = term|term|...|term
fn (r Regex) parse_expr() ! {
	mut r := parse_term()

	for !end() && peek() == '|' {
		next()
		r = r.or(parse_term())
	}
	return r
}



