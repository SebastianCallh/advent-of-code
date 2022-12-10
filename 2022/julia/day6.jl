
function run(input, window_size)
    windows(xs, size) = [xs[i-size+1:i] for i in size:length(xs)]
    unique_counts(xs) = length(Set(xs))

    xs = unique_counts.(windows(collect(input), window_size))
    argmax(xs .== window_size) + window_size - 1
end

function sol1(input)
    run(input, 4)
end

function sol2(input)
    run(input, 14)
end

read("../input/6.txt", String) |> sol1 |> println
read("../input/6.txt", String) |> sol2 |> println
