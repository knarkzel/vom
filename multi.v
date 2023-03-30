module vom

// Based on https://docs.rs/nom/7.1.0/nom/multi/index.html

// Runs the embedded parser a specified number of times.
pub fn count(f Fn, count int) FnMany {
	parsers := [f]
	return fn [parsers, count] (input string) !(string, []string) {
		f := parsers[0]
		mut temp := input
		mut output := []string{}
		for _ in 0 .. count {
			rest, capture := f(temp)!
			temp = rest
			output << capture
		}
		return temp, output
	}
}

// Runs the embedded parser repeatedly, filling the given slice with results.
pub fn fill(f Fn, mut buf []string) FnMany {
	parsers := [f]
	return fn [parsers, mut buf] (input string) !(string, []string) {
		f := parsers[0]
		mut temp := input
		for mut b in buf {
			temp, b = f(temp)!
		}
		return temp, []string{}
	}
}
