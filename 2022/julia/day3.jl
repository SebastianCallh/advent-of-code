function prios(items)
    p = merge(
        Dict(zip('a':'z', 1:26)),
        Dict(zip('A':'Z', 27:52))
    )
    getindex.(Ref(p), items)
end

function split(sack)
    n = div(length(sack), 2)
    sack[begin:n], sack[n+1:end]
end

function overlaps(sack)
    collect(intersect(Set.(collect.(sack))...))
end

function groups(lines)
    ixs = collect(3:3:length(lines)) .+ 1
    map(i -> reduce(vcat, lines[i-3:i-1]), ixs)
end

function sol1(lines)
    sum(prios.(reduce(vcat, overlaps.(split.(lines)))))
end

function sol2(lines)
    sum(prios.(reduce(vcat, overlaps.(groups(lines)))))
end


readlines("../input/3.txt") |> sol1 |> println
readlines("../input/3.txt") |> sol2 |> println
