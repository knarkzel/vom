<div align="center">
    <h1>vom</h1>
</div>

<div align="center">

[![GitHub contributors](https://img.shields.io/github/contributors/knarkzel/vom)](https://github.com/knarkzel/vom/graphs/contributors)
[![GitHub issues](https://img.shields.io/github/issues/knarkzel/vom)](https://github.com/knarkzel/vom/issues)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/knarkzel/vom/pulls)
[![HitCount](https://views.whatilearened.today/views/github/knarkzel/vom.svg)](https://github.com/knarkzel/vom)

</div>

`vom` is a rewrite of [nom](https://github.com/Geal/nom "nom"), which is a parser combinator library.
It is written in V, hence the name.

## Example

[Hexadecimal color](https://developer.mozilla.org/en-US/docs/Web/CSS/color) parser:

```v
import strconv
import vom { is_hex_digit, tag, take_while_m_n, tuple }

struct Color {
	red   byte
	green byte
	blue  byte
}

fn from_hex(input string) ?byte {
	return byte(strconv.parse_uint(input, 16, 8) ?)
}

fn hex_primary(input string) ?(string, string) {
	parser := take_while_m_n(2, 2, is_hex_digit)
	return parser(input)
}

fn hex_color(input string) ?(string, Color) {
	discard := tag('#')
	hex_part, _ := discard(input) ?
	parser := tuple([hex_primary, hex_primary, hex_primary])
	rest, output := parser(hex_part) ?
	red, green, blue := from_hex(output[0]) ?, from_hex(output[1]) ?, from_hex(output[2]) ?
	return rest, Color{red, green, blue}
}

fn main() {
	_, color := hex_color('#2F14DF') ?
	assert color == Color{47, 20, 223}
}

```

## When will it reach 1.0?

There are some features I both need and want working in V before I will complete this library:

### Generic return type for closures returned from functions

- [Generic return type for closure returned from function doesn't work #13253](https://github.com/vlang/v/issues/13253 "Generic return type for closure returned from function doesn't work #13253")

This is the only feature I absolutely need in order to finish this
library. Without it, we're stuck with returning `?(string, string)` instead of
`?(string, T)` from each parser, and thus can't construct an Ast with the
library alone. That's currently something you need to do manually.

### Generic type aliases

- [Aliases with generic parameters #12702](https://github.com/vlang/v/discussions/12702 "Aliases with generic parameters #12702 ")

Currently this isn't implemented yet. Although it's not required in order to
implement the features that are missing, it will make the codebase look horrible
without because almost all of the functions depend on following:

```v
type Fn = fn (string) ?(string, string)
type FnMany = fn (string) ?(string, []string)
```

And I need the last argument to be generic, because parsers could return other
types such as int, token, []token etc. Although I could search and replace each
entry manually, I'm too lazy to do that.

### Functions that return closure that captures functions from function parameter

- [Closures fail when capturing parameters that are functions #13032](https://github.com/vlang/v/issues/13032 "Closures fail when capturing parameters that are functions #13032")

This is not a necessary issue either, but it would remove lots of
boilerplate in the current code, for instance from [sequence.v](https://github.com/knarkzel/vom/blob/master/sequence.v "sequence.v").

Adding this would turn following:

```v
pub fn minimal(cond fn (int) bool) fn (int) bool {
	functions := [cond]
	return fn [functions] (input int) bool {
		cond := functions[0]
		return cond(input)
	}
}
```

Into this:

```v
pub fn minimal(cond fn (int) bool) fn (int) bool {
	return fn [cond] (input int) bool {
		return cond(input)
	}
}
```

### Call closure returned from function immediately 

- [Closures created from functions can't be called immediately #13051](https://github.com/vlang/v/issues/13051 "Closures created from functions can't be called immediately #13051")

This is again not a mandatory feature for this library to work, but would be a
nice addition. Instead of following code:

```v
fn operator(input string, location Location) ?(string, Token) {
	parser := alt([tag('+'), tag('-'), tag('<')])
	rest, output := parser(input) ?
	return rest, Token{output, location, .operator}
}
```

We could write this instead, which is a very common pattern in `nom`:

```v
fn operator(input string, location Location) ?(string, Token) {
	rest, output := alt([tag('+'), tag('-'), tag('<')])(input) ?
	return rest, Token{output, location, .operator}
}
```

## Install

```bash
v install --git https://github.com/knarkzel/vom
```

Then import in your file like so:

```v
import vom
rest, output := vom.digit1('123hello') ?
assert output == '123'
assert rest == 'hello'
```

There are examples in the `examples/` folder.

## Why use vom?

- The parsers are small and easy to write
- The parsers components are easy to reuse
- The parsers components are easy to test separately
- The parser combination code looks close to the grammar you would have written
- You can build partial parsers, specific to the data you need at the moment, and ignore the rest

## Resources

- [nom::recipes](https://docs.rs/nom/7.1.0/nom/recipes/index.html)
- [nom/examples](https://github.com/Geal/nom/tree/main/examples)
