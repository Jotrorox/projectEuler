public class Main {
    public static void main(String[] args) {
        long largestPandigital = 0;

        for (int x = 1; x < 10000; x++) {
            StringBuilder concatenatedProduct = new StringBuilder();
            int n = 1;

            while (concatenatedProduct.length() < 9) {
                concatenatedProduct.append(x * n++);
            }

            if (concatenatedProduct.length() == 9 && isPandigital(concatenatedProduct.toString())) {
                largestPandigital = Math.max(largestPandigital, Long.parseLong(concatenatedProduct.toString()));
            }
        }

        System.out.println(largestPandigital);
    }

    private static boolean isPandigital(String number) {
        if (number.length() != 9) return false;

        boolean[] digits = new boolean[9];
        for (char c : number.toCharArray()) {
            int digit = c - '1';
            if (digit < 0 || digit >= 9 || digits[digit]) return false;
            digits[digit] = true;
        }

        for (boolean digitPresent : digits) if (!digitPresent) return false;

        return true;
    }
}
