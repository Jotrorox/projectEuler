public class Main {
    public static void main(String[] args) {
        int sum = 0;
        int current = 1;
        int previous = 0;
        int temp;

        while (current <= 4000000) {
            sum = (current % 2 == 0) ? sum + current : sum;

            temp = current;
            current = current + previous;
            previous = temp;
        }

        System.out.println("Sum of even Fibonacci numbers: " + sum);
    }
}