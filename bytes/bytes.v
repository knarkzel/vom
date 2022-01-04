module bytes

import vom { Fn }

// Based on https://docs.rs/nom/latest/nom/bytes/complete/index.html

// The input data will be compared to the tag combinator’s argument and will
// return the part of the input that matches the argument.
pub fn tag(pattern string) Fn {
	return fn [pattern] (input string) ?(string, string) {
		if input.len < pattern.len {
			return error('`tag` failed because input `$input` is shorter than pattern `$pattern`')
		}
		if input[..pattern.len] == pattern {
			return input[pattern.len..], input[..pattern.len]
		} else {
			return error('`tag` failed because `$input[..pattern.len]` is not equal to pattern `$pattern`')
		}
	}
}

// Returns an input slice containing the first N input elements (Input[..N]).
pub fn take(count int) Fn {
	return fn [count] (input string) ?(string, string) {
		if input.len < count {
			return error('`take` failed with count `$count` on input `$input`')
		} else {
			return input[count..], input[..count]
		}
	}
}
