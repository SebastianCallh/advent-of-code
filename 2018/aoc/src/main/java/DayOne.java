import java.util.HashSet;
import java.util.List;
import java.util.stream.Stream;

public class DayOne implements Day {

    @Override
    public Integer solutionOne(List<String> input) {
        return input.stream()
                .map(Integer::parseInt)
                .reduce(0, (a, b) -> a + b);
    }

    @Override
    public Integer solutionTwo(List<String> input) {
        var n = input.size();
        var freqs = Stream
                .iterate(0, i -> (i + 1) % n)
                .map(input::get)
                .map(Integer::parseInt);

        var cumsum = 0;
        var seen = new HashSet<Integer>();
        var freq = freqs.iterator();
        while (!seen.contains(cumsum)) {
            seen.add(cumsum);
            cumsum += freq.next();
        }
        return cumsum;
    }
}
