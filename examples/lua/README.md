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
        x: 0
        y: 0
        i: 0
    }
    kind: keyword
}, Token{
    value: 'fib'
    location: Location{
        x: 9
        y: 0
        i: 9
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 12
        y: 0
        i: 12
    }
    kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 13
        y: 0
        i: 13
    }
    kind: identifier
}, Token{
    value: ')'
    location: Location{
        x: 14
        y: 0
        i: 14
    }
    kind: syntax
}, Token{
    value: 'if'
    location: Location{
        x: 18
        y: 1
        i: 19
    }
    kind: keyword
}, Token{
    value: 'n'
    location: Location{
        x: 21
        y: 1
        i: 22
    }
    kind: identifier
}, Token{
    value: '<'
    location: Location{
        x: 23
        y: 1
        i: 24
    }
    kind: operator
}, Token{
    value: '2'
    location: Location{
        x: 25
        y: 1
        i: 26
    }
    kind: number
}, Token{
    value: 'then'
    location: Location{
        x: 27
        y: 1
        i: 28
    }
    kind: keyword
}, Token{
    value: 'return'
    location: Location{
        x: 37
        y: 2
        i: 39
    }
    kind: keyword
}, Token{
    value: 'n'
    location: Location{
        x: 44
        y: 2
        i: 46
    }
    kind: identifier
}, Token{
    value: ';'
    location: Location{
        x: 45
        y: 2
        i: 47
    }
    kind: syntax
}, Token{
    value: 'end'
    location: Location{
        x: 49
        y: 3
        i: 52
    }
    kind: keyword
}, Token{
    value: 'local'
    location: Location{
        x: 55
        y: 5
        i: 60
    }
    kind: identifier
}, Token{
    value: 'n1'
    location: Location{
        x: 61
        y: 5
        i: 66
    }
    kind: identifier
}, Token{
    value: '='
    location: Location{
        x: 64
        y: 5
        i: 69
    }
    kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 66
        y: 5
        i: 71
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 69
        y: 5
        i: 74
    }
    kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 70
        y: 5
        i: 75
    }
    kind: identifier
}, Token{
    value: '-'
    location: Location{
        x: 71
        y: 5
        i: 76
    }
    kind: operator
}, Token{
    value: '1'
    location: Location{
        x: 72
        y: 5
        i: 77
    }
    kind: number
}, Token{
    value: ')'
    location: Location{
        x: 73
        y: 5
        i: 78
    }
    kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 74
        y: 5
        i: 79
    }
    kind: syntax
}, Token{
    value: 'local'
    location: Location{
        x: 78
        y: 6
        i: 84
    }
    kind: identifier
}, Token{
    value: 'n2'
    location: Location{
        x: 84
        y: 6
        i: 90
    }
    kind: identifier
}, Token{
    value: '='
    location: Location{
        x: 87
        y: 6
        i: 93
    }
    kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 89
        y: 6
        i: 95
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 92
        y: 6
        i: 98
    }
    kind: syntax
}, Token{
    value: 'n'
    location: Location{
        x: 93
        y: 6
        i: 99
    }
    kind: identifier
}, Token{
    value: '-'
    location: Location{
        x: 94
        y: 6
        i: 100
    }
    kind: operator
}, Token{
    value: '2'
    location: Location{
        x: 95
        y: 6
        i: 101
    }
    kind: number
}, Token{
    value: ')'
    location: Location{
        x: 96
        y: 6
        i: 102
    }
    kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 97
        y: 6
        i: 103
    }
    kind: syntax
}, Token{
    value: 'return'
    location: Location{
        x: 101
        y: 7
        i: 108
    }
    kind: keyword
}, Token{
    value: 'n1'
    location: Location{
        x: 108
        y: 7
        i: 115
    }
    kind: identifier
}, Token{
    value: '+'
    location: Location{
        x: 111
        y: 7
        i: 118
    }
    kind: operator
}, Token{
    value: 'n2'
    location: Location{
        x: 113
        y: 7
        i: 120
    }
    kind: identifier
}, Token{
    value: ';'
    location: Location{
        x: 115
        y: 7
        i: 122
    }
    kind: syntax
}, Token{
    value: 'end'
    location: Location{
        x: 116
        y: 8
        i: 124
    }
    kind: keyword
}, Token{
    value: 'print'
    location: Location{
        x: 119
        y: 10
        i: 129
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 124
        y: 10
        i: 134
    }
    kind: syntax
}, Token{
    value: 'fib'
    location: Location{
        x: 125
        y: 10
        i: 135
    }
    kind: identifier
}, Token{
    value: '('
    location: Location{
        x: 128
        y: 10
        i: 138
    }
    kind: syntax
}, Token{
    value: '30'
    location: Location{
        x: 129
        y: 10
        i: 139
    }
    kind: number
}, Token{
    value: ')'
    location: Location{
        x: 131
        y: 10
        i: 141
    }
    kind: syntax
}, Token{
    value: ')'
    location: Location{
        x: 132
        y: 10
        i: 142
    }
    kind: syntax
}, Token{
    value: ';'
    location: Location{
        x: 133
        y: 10
        i: 143
    }
    kind: syntax
}]
```
