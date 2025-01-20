public class Main {
    public static void main(String[] args) {
        int a = 0;

        for (int j = 1; !isDivisible(j); j++) a = j;

        System.out.println(a+1);
    }

    public static boolean isDivisible(int num) {
        for (int i = 1; i <= 20; i++) if (num % i != 0) return false;
        return true;
    }
}