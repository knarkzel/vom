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
[./lua.v:132] tokens: [Token{
    value: 'function'
    location: Location{
        x: 8
        y: 0
        i: 8
    }
    kind: keyword
}, Token{
    value: 'fib'
    location: Location{
        x: 12
        y: 0
        i: 12
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 13
        y: 0
        i: 13
    }
    kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 14
        y: 0
        i: 14
    }
    kind: identifier
}, Token{
    value: ')'
    location: Location{
        x: 15
        y: 0
        i: 15
    }
    kind: syntax
}, Token{
    value: 'if'
    location: Location{
        x: 20
        y: 1
        i: 21
    }
    kind: keyword
}, Token{
    value: 'n'
    location: Location{
        x: 22
        y: 1
        i: 23
    }
    kind: identifier
}, Token{
    value: '<'
    location: Location{
        x: 24
        y: 1
        i: 25
    }
    kind: operator
}, Token{
    value: '2'
    location: Location{
        x: 26
        y: 1
        i: 27
    }
    kind: number
}, Token{
    value: 'then'
    location: Location{
        x: 31
        y: 1
        i: 32
    }
    kind: keyword
}, Token{
    value: 'return'
    location: Location{
        x: 43
        y: 2
        i: 45
    }
    kind: keyword
}, Token{
    value: 'n'
    location: Location{
        x: 45
        y: 2
        i: 47
    }
    kind: identifier
}, Token{
    value: ';'
    location: Location{
        x: 46
        y: 2
        i: 48
    }
    kind: syntax
}, Token{
    value: 'end'
    location: Location{
        x: 52
        y: 3
        i: 55
    }
    kind: keyword
}, Token{
    value: 'local'
    location: Location{
        x: 60
        y: 5
        i: 65
    }
    kind: identifier
}, Token{
    value: 'n1'
    location: Location{
        x: 63
        y: 5
        i: 68
    }
    kind: identifier
}, Token{
    value: '='
    location: Location{
        x: 65
        y: 5
        i: 70
    }
    kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 69
        y: 5
        i: 74
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 70
        y: 5
        i: 75
    }
    kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 71
        y: 5
        i: 76
    }
    kind: identifier
}, Token{
    value: '-'
    location: Location{
        x: 72
        y: 5
        i: 77
    }
    kind: operator
}, Token{
    value: '1'
    location: Location{
        x: 73
        y: 5
        i: 78
    }
    kind: number
}, Token{
    value: ')'
    location: Location{
        x: 74
        y: 5
        i: 79
    }
    kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 75
        y: 5
        i: 80
    }
    kind: syntax
}, Token{
    value: 'local'
    location: Location{
        x: 83
        y: 6
        i: 89
    }
    kind: identifier
}, Token{
    value: 'n2'
    location: Location{
        x: 86
        y: 6
        i: 92
    }
    kind: identifier
}, Token{
    value: '='
    location: Location{
        x: 88
        y: 6
        i: 94
    }
    kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 92
        y: 6
        i: 98
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 93
        y: 6
        i: 99
    }
    kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 94
        y: 6
        i: 100
    }
    kind: identifier
}, Token{
    value: '-'
    location: Location{
        x: 95
        y: 6
        i: 101
    }
    kind: operator
}, Token{
    value: '2'
    location: Location{
        x: 96
        y: 6
        i: 102
    }
    kind: number
}, Token{
    value: ')'
    location: Location{
        x: 97
        y: 6
        i: 103
    }
    kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 98
        y: 6
        i: 104
    }
    kind: syntax
}, Token{
    value: 'return'
    location: Location{
        x: 107
        y: 7
        i: 114
    }
    kind: keyword
}, Token{
    value: 'n1'
    location: Location{
        x: 110
        y: 7
        i: 117
    }
    kind: identifier
}, Token{
    value: '+'
    location: Location{
        x: 112
        y: 7
        i: 119
    }
    kind: operator
}, Token{
    value: 'n2'
    location: Location{
        x: 115
        y: 7
        i: 122
    }
    kind: identifier
}, Token{
    value: ';'
    location: Location{
        x: 116
        y: 7
        i: 123
    }
    kind: syntax
}, Token{
    value: 'end'
    location: Location{
        x: 119
        y: 8
        i: 127
    }
    kind: keyword
}, Token{
    value: 'print'
    location: Location{
        x: 124
        y: 10
        i: 134
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 125
        y: 10
        i: 135
    }
    kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 128
        y: 10
        i: 138
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 129
        y: 10
        i: 139
    }
    kind: syntax
}, Token{
    value: '30'
    location: Location{
        x: 131
        y: 10
        i: 141
    }
    kind: number
}, Token{
    value: ')'
    location: Location{
        x: 132
        y: 10
        i: 142
    }
    kind: syntax
}, Token{
    value: ')'
    location: Location{
        x: 133
        y: 10
        i: 143
    }
    kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 134
        y: 10
        i: 144
    }
    kind: syntax
}]
```
