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
