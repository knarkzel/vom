module main

import vom { Fn, delimited, multispace0, tag, take_until }

fn space(f Fn) Fn {
	return delimited(multispace0, f, multispace0)
}

fn sexp(f Fn) Fn {
	return delimited(tag('('), f, tag(')'))
}

fn main() {
	parser := sexp(space(take_until(')')))
	rest, output := parser('(add (sub))') ?
	println(output)
	println(rest)
}
