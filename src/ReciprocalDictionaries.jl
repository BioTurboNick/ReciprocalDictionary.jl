module ReciprocalDictionaries

import Base: setindex!, getindex, empty!, length, keys, values

export ReciprocalDict

struct ReciprocalDict{T1, T2}
    d12::Dict{T1, T2}
    d21::Dict{T2, T1}

    ReciprocalDict{T1, T2}() = new(Dict{T1, T2}(), Dict{T2, T1}())
end

function setindex!(dict::ReciprocalDict{T1, T2}, key::T1, value::T2) where {T1, T2}
    haskey(dict.d21, value) && dict.d21[value] != key &&
        throw(ArgumentError("dictionary already contains a key $(dict.d21[value]) mapped to value $value"))
    dict.d12[key] = value
    dict.d21[value] = key
end

getindex(dict::ReciprocalDict{T1, T2}, key::T1) where {T1, T2} = getindex(dict.d12, key)
getindex(dict::ReciprocalDict{T1, T2}, key::T2) where {T1, T2} = getindex(dict.d21, key)

empty!(dict::ReciprocalDict) = (empty!(dict.d12); empty!(dict.d21))

length(dict::ReciprocalDict) = length(dict.d12)

keys(dict::ReciprocalDict) = keys(dict.d12)
values(dict::ReciprocalDict) = values(dict.d21)

reciprocal(dict::ReciprocalDict) = ReciprocalDict(dict.d21, dict.d12)



end # module
