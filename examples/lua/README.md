# lua

Example of parsing some lua syntax using `vom`. Run example with `v run
. input.lua`. Provides helpful error messages like below for errors, which you can see with
`v run . fail.lua`.

```
fail.lua:9:2: error: parsing failed
   1 | function fib(n)
   2 |    if n > 2 then
     |         ~~~~~~~~
   3 |       return n;
   4 |    end
   5 | 
```
