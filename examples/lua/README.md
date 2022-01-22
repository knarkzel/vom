# lua

Example of parsing some lua syntax using `vom`. Run example with `v run
. input.lua`. Provides helpful error messages like below for errors, which you can see with
`v run . source/fail.lua`.

```
source/fail.lua:9:2: error: parsing failed
   1 | function fib(n)
   2 |    if n > 2 then
     |         ~~~~~~~~
   3 |       return n;
   4 |    end
   5 | 
```

On success it produces following for `v run . source/success.lua`:

```
[./lua.v:92] tokens: [Token{
    value: 'function'
    location: Location{
        x: 0
        y: 0
    }
    token_kind: keyword
}, Token{
    value: 'fib'
    location: Location{
        x: 9
        y: 0
    }
    token_kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 12
        y: 0
    }
    token_kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 13
        y: 0
    }
    token_kind: identifier
}, Token{
    value: ')'
    location: Location{
        x: 14
        y: 0
    }
    token_kind: syntax
}, Token{
    value: 'if'
    location: Location{
        x: 3
        y: 1
    }
    token_kind: keyword
}, Token{
    value: 'n'
    location: Location{
        x: 6
        y: 1
    }
    token_kind: identifier
}, Token{
    value: '<'
    location: Location{
        x: 8
        y: 1
    }
    token_kind: operator
}, Token{
    value: '2'
    location: Location{
        x: 10
        y: 1
    }
    token_kind: number
}, Token{
    value: 'then'
    location: Location{
        x: 12
        y: 1
    }
    token_kind: keyword
}, Token{
    value: 'return'
    location: Location{
        x: 6
        y: 2
    }
    token_kind: keyword
}, Token{
    value: 'n'
    location: Location{
        x: 13
        y: 2
    }
    token_kind: identifier
}, Token{
    value: ';'
    location: Location{
        x: 14
        y: 2
    }
    token_kind: syntax
}, Token{
    value: 'end'
    location: Location{
        x: 3
        y: 3
    }
    token_kind: keyword
}, Token{
    value: 'local'
    location: Location{
        x: 3
        y: 5
    }
    token_kind: identifier
}, Token{
    value: 'n1'
    location: Location{
        x: 9
        y: 5
    }
    token_kind: identifier
}, Token{
    value: '='
    location: Location{
        x: 12
        y: 5
    }
    token_kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 14
        y: 5
    }
    token_kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 17
        y: 5
    }
    token_kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 18
        y: 5
    }
    token_kind: identifier
}, Token{
    value: '-'
    location: Location{
        x: 19
        y: 5
    }
    token_kind: operator
}, Token{
    value: '1'
    location: Location{
        x: 20
        y: 5
    }
    token_kind: number
}, Token{
    value: ')'
    location: Location{
        x: 21
        y: 5
    }
    token_kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 22
        y: 5
    }
    token_kind: syntax
}, Token{
    value: 'local'
    location: Location{
        x: 3
        y: 6
    }
    token_kind: identifier
}, Token{
    value: 'n2'
    location: Location{
        x: 9
        y: 6
    }
    token_kind: identifier
}, Token{
    value: '='
    location: Location{
        x: 12
        y: 6
    }
    token_kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 14
        y: 6
    }
    token_kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 17
        y: 6
    }
    token_kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 18
        y: 6
    }
    token_kind: identifier
}, Token{
    value: '-'
    location: Location{
        x: 19
        y: 6
    }
    token_kind: operator
}, Token{
    value: '2'
    location: Location{
        x: 20
        y: 6
    }
    token_kind: number
}, Token{
    value: ')'
    location: Location{
        x: 21
        y: 6
    }
    token_kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 22
        y: 6
    }
    token_kind: syntax
}, Token{
    value: 'return'
    location: Location{
        x: 3
        y: 7
    }
    token_kind: keyword
}, Token{
    value: 'n1'
    location: Location{
        x: 10
        y: 7
    }
    token_kind: identifier
}, Token{
    value: '+'
    location: Location{
        x: 13
        y: 7
    }
    token_kind: operator
}, Token{
    value: 'n2'
    location: Location{
        x: 15
        y: 7
    }
    token_kind: identifier
}, Token{
    value: ';'
    location: Location{
        x: 17
        y: 7
    }
    token_kind: syntax
}, Token{
    value: 'end'
    location: Location{
        x: 0
        y: 8
    }
    token_kind: keyword
}, Token{
    value: 'print'
    location: Location{
        x: 0
        y: 10
    }
    token_kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 5
        y: 10
    }
    token_kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 6
        y: 10
    }
    token_kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 9
        y: 10
    }
    token_kind: syntax
}, Token{
    value: '30'
    location: Location{
        x: 10
        y: 10
    }
    token_kind: number
}, Token{
    value: ')'
    location: Location{
        x: 12
        y: 10
    }
    token_kind: syntax
}, Token{
    value: ')'
    location: Location{
        x: 13
        y: 10
    }
    token_kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 14
        y: 10
    }
    token_kind: syntax
}]
```
