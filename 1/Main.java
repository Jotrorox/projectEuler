import java.util.stream.IntStream;

public class Main {
    public static void main(String[] args) {
        int sum = IntStream.range(1, 1000)
                .filter(i -> i % 3 == 0 || i % 5 == 0)
                .sum();
        System.out.println(sum);
    }
}