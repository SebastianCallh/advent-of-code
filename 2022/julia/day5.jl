using Base.Iterators

function parse_state(input)

    parse_row(chunk) = begin
        a = filter(!isspace, chunk)
        isempty(a) && return nothing
        a[2]
    end

    lines = split(input, "\n")
    grid, indices = lines[begin:end-1], lines[end]
    ncols = length(split(indices, "  "))
    rows = map(row -> parse_row.(row), partition.(grid, 4))
    state = Array{Char}[[] for i in 1:ncols]
    for row in rows
        for (i, item) in enumerate(row)
            !isnothing(item) && push!(state[i], item)
        end
    end
    state
end

function parse_ops(input)
    f(x) = begin
        m = match(r"move (\d+) from (\d+) to (\d+)", x)
        amount, from, to = parse.(Int32, m.captures)
        (;amount, from, to)
    end
    f.(filter(!isempty, split(input, "\n")))
end

function run!(state, ops, runop!)
    for op in ops
        runop!(state, op)
    end
end

function make_move!(state, op)
    for i in 1:op.amount
        x = popfirst!(state[op.from])
        prepend!(state[op.to], x)
    end
end

function make_move_ordered!(state, op)
    xs = [popfirst!(state[op.from]) for i in 1:op.amount]
    prepend!(state[op.to], xs)
end

function parse_inputs(input)
    state_input, ops_input = split(input, "\n\n")
    state = parse_state(state_input)
    ops = parse_ops(ops_input)
    state, ops
end

function sol1(input)
    state, ops = parse_inputs(input)
    run!(state, ops, make_move!)
    reduce(*, first.(state))
end

function sol2(input)
    state, ops = parse_inputs(input)
    run!(state, ops, make_move_ordered!)
    reduce(*, first.(state))
end


read("../input/5.txt", String) |> sol1 |> println
read("../input/5.txt", String) |> sol2 |> println
