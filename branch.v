module branch

import sequence { tuple }
import utils { Fn, FnMany }

// Based on https://docs.rs/nom/7.1.0/nom/branch/index.html

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

// Applies a list of parsers in any order.
pub fn permutation(parsers ...Fn) FnMany {
	return fn [parsers] (input string) ?(string, []string) {
		for perm in quick_perm(parsers.len) {
			mut functions := []Fn{len: parsers.len}
			for i in perm {
				functions << parsers[i]
			}
			// parser should just be below, not above
			// parser := tuple(...perm.map(parsers[it]))
			parser := tuple(...functions)
			temp, output := parser(input) or { continue }
			return temp, output
		}
		return error('`permutation` failed on `$input` because no permutations were found')
	}
}

// Returns an array of index permutations up to index n. Inspired by
// https://www.quickperm.org/01example.php
fn quick_perm(n int) [][]int {
	mut a := []int{len: n, init: it}
	mut p := []int{len: n + 1, init: it}
	mut o := [][]int{}
	println(a)
	mut i := 1
	for i < n {
		p[i]--
		j := i % 2 * p[i]
		a[i], a[j] = a[j], a[i]
		println(a)
		o << a.clone()
		i = 1
		for p[i] == 0 {
			p[i] = i
			i++
		}
	}
	return o
}
