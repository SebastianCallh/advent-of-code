succ(n) = n == 3 ? 1 : n + 1
prev(n) = n == 1 ? 3 : n - 1
tieing(n) = n
winning(n) = succ(n)
losing(n) = prev(n)

function score(round)
    win = 6
    tie = 3
    op_shape, my_shape = round
    score_table = Dict(
        (1, 1) => tie,
        (2, 2) => tie,
        (3, 3) => tie,
        (1, 2) => win,
        (2, 3) => win,
        (3, 1) => win,
    )
    get(score_table, (op_shape, my_shape), 0) + my_shape
end

function ints(line)
    toint = Dict(
        "X" => 1,
        "Y" => 2,
        "Z" => 3,
        "A" => 1,
        "B" => 2,
        "C" => 3,
    )
    map(l -> toint[l], split(line))
end

function strategy(round)
    op_shape, my_shape = round
    strategies = Dict(
        1 => losing(op_shape),
        2 => tieing(op_shape),
        3 => winning(op_shape),
    )
    (op_shape, strategies[my_shape])
end

function sol1(lines)
    sum(score.(ints.(lines)))
end

function sol2(lines)
    sum(score.(strategy.(ints.(lines))))
end


readlines("../input/2.txt") |> sol1 |> println
readlines("../input/2.txt") |> sol2 |> println
