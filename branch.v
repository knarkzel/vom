module vom

// Based on https://docs.rs/nom/7.1.3/nom/branch/index.html

// Tests a list of `parsers` one by one until one succeeds.
pub fn alt(parsers []Fn) Fn {
	return fn [parsers] (input string) !(string, string) {
		for parser in parsers {
			temp, output := parser(input) or { continue }
			return temp, output
		}
		return error('`alt` failed on input `${input}` with `${parsers.len}` parsers')
	}
}

// Applies a list of `parsers` in any order.
// Permutation will succeed if all of the child `parsers` succeeded. It takes as argument a tuple of `parsers`, and returns a tuple of the parser results.
pub fn permutation(parsers []Fn) FnMany {
	return fn [parsers] (input string) !(string, []string) {
		for perm in quick_perm(parsers.len) {
			mut functions := []Fn{}
			for i in perm {
				functions << parsers[i]
			}
			parser := tuple(functions)
			// the code above should just work as below, bug for now:
			// parser := tuple(...perm.map(parsers[index]))
			temp, output := parser(input) or { continue }
			return temp, output
		}
		return error('`permutation` failed on `${input}` because no permutations were found')
	}
}

// Returns an array of index permutations up to index n. Inspired by
// https://www.quickperm.org/01example.php
fn quick_perm(n int) [][]int {
	mut a := []int{len: n, init: index}
	mut p := []int{len: n + 1, init: index}
	mut o := [][]int{}
	o << a.clone()
	mut i := 1
	for i < n {
		p[i]--
		j := i % 2 * p[i]
		a[i], a[j] = a[j], a[i]
		o << a.clone()
		i = 1
		for p[i] == 0 {
			p[i] = i
			i++
		}
	}
	return o
}
