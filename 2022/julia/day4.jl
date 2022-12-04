function parse(line)
    torange(elf) = range(tryparse.(Int32, split(elf, "-"))...)
    elf1, elf2 = split(line, ",")
    torange(elf1), torange(elf2)
end

function any_subset(a, b)
    (a[begin] <= b[begin] && b[end] <= a[end]) || (b[begin] <= a[begin] && a[end] <= b[end])
end

function any_overlap(a, b)
    intersect(Set(a), Set(b)) != Set()
end

function sol1(input)
   sum(Int32.(map(Base.splat(any_subset), parse.(input))))
end

function sol2(input)
   sum(Int32.(map(Base.splat(any_overlap), parse.(input))))
end

readlines("../input/4.txt") |> sol1 |> println
readlines("../input/4.txt") |> sol2 |> println
