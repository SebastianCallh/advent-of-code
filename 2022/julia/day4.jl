function parse(line)
    parseint(elf) = tryparse.(Int32, split(elf, "-"))
    parseint.(split(line, ","))
end

function any_subset(((min1, max1), (min2, max2)))
    (min1 <= min2 && max2 <= max1) ||
    (min2 <= min1 && max1 <= max2)
end

function any_overlap(((min1, max1), (min2, max2)))
    (min1 <= min2 && min2 <= max1) ||
    (min2 <= min1 && min1 <= max2) ||
    (min1 <= max2 && max2 <= max1) ||
    (min2 <= max1 && max1 <= max2)
end

function sol1(input)
   sum(Int32.(any_subset.(parse.(input))))
end

function sol2(input)
   sum(Int32.(any_overlap.(parse.(input))))
end

readlines("../input/4.txt") |> sol1 |> println
readlines("../input/4.txt") |> sol2 |> println
