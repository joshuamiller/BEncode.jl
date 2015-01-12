# BEncode.jl

[![Build Status](https://travis-ci.org/joshuamiller/BEncode.jl.svg)](https://travis-ci.org/joshuamiller/BEncode.jl)

A Julia library for [BEncode](http://en.wikipedia.org/wiki/Bencode).

```julia
using BEncode

bencode({"Dict" => [1, "two"]})
# "d4:Dictli1e3:twoee"

bdecode("d4:Dictli1e3:twoee")
# Dict{Any,Any} with 1 entry:
#  "Dict" => Union(Array{T,N},Int64,String,Dict{K,V})[1,"two"]
```
