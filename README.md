# truth table generator

## example

```
$ ruby eval.rb
abc + (~a)bc + a(~b)c
----------
Detected Variables:
 ["a", "b", "c"]
 ----------





 a b c | abc + (~a)bc + a(~b)c
 ----------
 0 0 0 | 0
 0 0 1 | 0
 0 1 0 | 0
 0 1 1 | 1
 1 0 0 | 0
 1 0 1 | 1
 1 1 0 | 0
 1 1 1 | 1

```

