import java.util.Arrays;

public class Main {
       public static void main(String[] args) {
        for (int n = 7; n >= 1; n--) {
            String digits = "";
            for (int i = n; i >= 1; i--) digits += i;
            if (findLargestPandigitalPrime(digits) > 0) break;
        }
    }

    private static int findLargestPandigitalPrime(String digits) {
        String[] permutations = generatePermutations(digits);
        Arrays.sort(permutations, (a, b) -> b.compareTo(a));
        for (String perm : permutations) {
            int num = Integer.parseInt(perm);
            if (isPrime(num)) {
                System.out.println("Largest pandigital prime: " + num);
                return num;
            }
        }
        return 0;
    }

    private static String[] generatePermutations(String str) {
        if (str.length() <= 1) return new String[]{str};
        String[] result = new String[factorial(str.length())];
        int index = 0;
        for (int i = 0; i < str.length(); i++) {
            for (String perm : generatePermutations(str.substring(0, i) + str.substring(i + 1))) {
                result[index++] = str.charAt(i) + perm;
            }
        }
        return result;
    }

    private static boolean isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i <= Math.sqrt(num); i++) if (num % i == 0) return false;
        return true;
    }

    private static int factorial(int n) {
        return (n <= 1) ? 1 : n * factorial(n - 1);
    }
}
