public class Main {
    public static boolean isPalindrome(int number) {
        int original = number;
        int reversed = 0;
        while (number > 0) {
            reversed = reversed * 10 + number % 10;
            number /= 10;
        }
        return original == reversed;
    }

    public static void main(String[] args) {
        int currentMax = 0;

        for (int i = 100; i < 1000; i++) {
            for (int j = 100; j < 1000; j++) {
                int product = i * j;
                if (product > currentMax && isPalindrome(product)) {
                    currentMax = product;
                }
            }
        }

        System.out.println(currentMax);
    }
}
