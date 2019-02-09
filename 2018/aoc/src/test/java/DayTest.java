import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class DayTest {

    @Test
    void day1PrintsCorrectly() {
        assertEquals(Day.Number.One.toString(), "1");
    }

    @Test
    void day1LoadsInputCorrectly() {
        var input = Day.getInputFor(Day.Number.One);
        assertEquals(input.size(), 1040);
    }

    @Test
    void day1Problem1SolvesCorrectly() {
        Integer answerOne = 569;
        var input = Day.getInputFor(Day.Number.One);
        var day = new DayOne();
        assertEquals(answerOne, day.solutionOne(input));
    }

    @Test
    void day1Problem2SolvesCorrectly() {
        Integer answerOne = 77666;
        var input = Day.getInputFor(Day.Number.One);
        var day = new DayOne();
        assertEquals(answerOne, day.solutionTwo(input));
    }
}
