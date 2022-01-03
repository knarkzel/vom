# vom

`vom` is a rewrite of [nom](https://github.com/Geal/nom "nom") in V.  It's
a parser combinators library written in V.

## Why parser combinators?

Parser combinators are an approach to parsers that is very different from
software like lex and yacc. Instead of writing the grammar in a separate file
and generating the corresponding code, you use very small functions with very
specific purpose, like "take 5 bytes", or "recognize the word 'HTTP'", and
assemble them in meaningful patterns like "recognize 'HTTP', then a space, then
a version". The resulting code is small, and looks like the grammar you would
have written with other parser approaches.

This has a few advantages:

- The parsers are small and easy to write
- The parsers components are easy to reuse (if they're general enough, please add them to nom!)
- The parsers components are easy to test separately (unit tests and property-based tests)
- The parser combination code looks close to the grammar you would have written
- You can build partial parsers, specific to the data you need at the moment, and ignore the rest
