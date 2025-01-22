import java.io.*;
import java.net.URISyntaxException;
import java.util.*;

public class Main {
    public static void main(String[] args) throws IOException, URISyntaxException {
        String scriptDir = new File(Main.class.getProtectionDomain().getCodeSource().getLocation().toURI())
                .getParent();
        String inputPath = new File(scriptDir, "42/input.txt").getAbsolutePath();

        Set<Integer> triangleNumbers = generateTriangleNumbers(1000);

        List<String> words = readWordsFromFile(inputPath);

        int triangleWordCount = 0;
        for (String word : words) {
            int wordValue = calculateWordValue(word);
            if (triangleNumbers.contains(wordValue)) {
                triangleWordCount++;
            }
        }

        System.out.println(triangleWordCount);
    }

    private static Set<Integer> generateTriangleNumbers(int maxLimit) {
        Set<Integer> triangleNumbers = new HashSet<>();
        int n = 1;
        int triangle = 0;
        while (triangle <= maxLimit) {
            triangle = n * (n + 1) / 2;
            triangleNumbers.add(triangle);
            n++;
        }
        return triangleNumbers;
    }

    private static List<String> readWordsFromFile(String filename) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(filename));
        String line = br.readLine();
        br.close();

        String[] wordArray = line.replace("\"", "").split(",");
        return Arrays.asList(wordArray);
    }

    private static int calculateWordValue(String word) {
        int value = 0;
        for (char c : word.toCharArray()) {
            value += (c - 'A' + 1);
        }
        return value;
    }
}
