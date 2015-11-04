using Base.Test
using BEncode

# Decode

@test bdecode("i42e") == 42
@test bdecode("i0e") == 0
@test bdecode("i-42e") == -42

@test bdecode("6:Trajan") == "Trajan"
@test bdecode("0:") == ""

@test bdecode("li4ei2ee") == [4, 2]
@test bdecode("li4e1:2e") == [4, "2"]
@test bdecode("le") == []

@test bdecode("d4:dictli1ei4eee") == Dict("dict" => [1, 4])
@test bdecode("de") == Dict()

# Encode

@test bencode(42) == "i42e"
@test bencode(0) == "i0e"
@test bencode(-42) == "i-42e"

@test bencode("Trajan") == "6:Trajan"
@test bencode("") == "0:"

@test bencode([4, 2]) == "li4ei2ee"
@test bencode([4, "2"]) == "li4e1:2e"
@test bencode([]) == "le"

@test bencode(Dict("dict" => [1, 4])) == "d4:dictli1ei4eee"
@test bencode(Dict()) == "de"
