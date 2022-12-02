function elves_total(lines)
    elves = Array{Int32}[[]]

    i = 1
    calories = tryparse.(Int32, lines)
    for c in calories
        if isnothing(c)
            i += 1
            push!(elves, [])
            continue
        end
        push!(elves[i], c)
    end
    elves_total = sum.(elves)
end

function sol1(lines)
    calories = elves_total(lines)
    maximum(calories)
end

function sol2(lines)
    calories = elves_total(lines)
    sum(sort(calories, rev=true)[1:3])
end

readlines("../input/1.txt") |> sol1 |> println
readlines("../input/1.txt") |> sol2 |> println
