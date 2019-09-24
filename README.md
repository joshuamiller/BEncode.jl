# BEncode.jl

[![Build Status](https://travis-ci.org/joshuamiller/BEncode.jl.svg)](https://travis-ci.org/joshuamiller/BEncode.jl)

A Julia library for [BEncode](http://en.wikipedia.org/wiki/Bencode).

```julia
using BEncode

bencode(Dic("Dict" => [1, "two"]))
# "d4:Dictli1e3:twoee"

bdecode("d4:Dictli1e3:twoee")
# Dict{Any,Any} with 1 entry:
#   "Dict" => Union{Int64, String, Dict, Array}[1, "two"]
```
