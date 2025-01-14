import java.math.BigInteger;

public class Main {
    public static void main(String[] args) {
        int n = 100;
        System.out.println("Sum of the digits in " + n + "! is " + factorialDigitSum(n));
    }

    public static int factorialDigitSum(int n) {
        BigInteger factorial = BigInteger.ONE;

        for (int i = 2; i <= n; i++) {
            factorial = factorial.multiply(BigInteger.valueOf(i));
        }

        int sum = 0;
        String digits = factorial.toString();
        for (char c : digits.toCharArray()) {
            sum += c - '0';
        }

        return sum;
    }
}
