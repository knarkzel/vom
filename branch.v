module vom

// Tests a list of parsers one by one until one succeeds.
pub fn branch(parsers ...Fn) Fn {
	return fn [parsers] (input string) ?(string, string) {
		for parser in parsers {
			temp, output := parser(input) or { continue }
			return temp, output
		}
		return error('`branch` failed on input `$input` with `$parsers.len` parsers')
	}
}
