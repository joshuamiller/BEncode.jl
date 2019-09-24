module BEncode

export bencode, bdecode

function bencode(val::AbstractString)
    string(length(val)) * ":" * val
end

function bencode(val::Int)
    "i" * string(val) * "e"
end

function bencode(val::Array)
    "l" * join(map(bencode, val)) * "e"
end

function bencode(val::Dict)
    ks = sort(collect(keys(val)), lt = (x, y) -> isless(string(x), string(y)))
    "d" * join(map((k) -> bencode(string(k)) * bencode(val[k]), ks)) * "e"
end

function bparsestring(val::AbstractString)
    splitstr = split(val, ":", limit=2)
    thislength = parse(Int,splitstr[1])
    if length(splitstr[2]) > thislength
        thisstring = splitstr[2][1:thislength]
        return convert(String, thisstring), splitstr[2][thislength + 1:end]
    else
        return splitstr[2]
    end
end

function bparseint(val::AbstractString)
    splitstr = split(val, "e", limit=2)
    thisint = parse(Int,splitstr[1])
    if length(splitstr[2]) > 0
        return thisint, splitstr[2]
    else
        return thisint
    end
end

function bparsearray(val::AbstractString)
    array = Union{String,Int,Array,Dict}[]
    while val[1] != 'e'
        entry, val = bdecode(val)
        push!(array, entry)
    end
    if length(val) > 1
        array, val[2:end]
    else
        array
    end
end

function bparsedictentry(val::AbstractString)
    k, rest = bparsestring(val)
    v, rest = bdecode(rest)
    k, v, rest
end

function bparsedict(val::AbstractString)
    dict = Dict()
    while val[1] != 'e'
        k, v, val = bparsedictentry(val)
        dict[k] = v
    end
    if length(val) > 1
        dict, val[2:end]
    else
        dict
    end
end

function bdecode(val::AbstractString)
    if val[1] == 'i'
        bparseint(val[2:end])
    elseif val[1] == 'l'
        bparsearray(val[2:end])
    elseif val[1] == 'd'
        bparsedict(val[2:end])
    else
        bparsestring(val)
    end
end

end
