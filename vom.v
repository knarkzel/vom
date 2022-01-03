module main

import complete
import sequence

fn main() {
	input := '#hello#'
	parser := sequence.delimited(complete.tag('#'), complete.take(5), complete.tag('#'))
	_, output := parser(input) ?
	println(output)
}
