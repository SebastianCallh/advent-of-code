import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public interface Day {

    Integer solutionOne(List<String> input);
    Integer solutionTwo(List<String> input);

    enum Number {
        One, Two, Three, Four, Five, Six;

        @Override
        public String toString() {
            String str = "" ;
            switch (this) {
                case One: str = "1"; break;
                case Two: str = "2"; break;
                case Three: str = "3"; break;
                case Four: str = "4"; break;
                case Five: str = "5"; break;
                case Six: str = "6"; break;
            }
            return str;
        }
    }

    static List<String> getInputFor(Number num) {
        var inputPath = "../input/Day";
        var path = new File(inputPath + num.toString() + ".txt").getAbsolutePath();
        try {
            return Files.lines(Path.of(path)).collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}
