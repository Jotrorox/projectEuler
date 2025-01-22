public class Main {
    public static void main(String[] args) {
        int maxP = 0;
        int maxSolutions = 0; 

        for (int p = 1; p <= 1000; p++) {
            int solutions = 0;

            for (int a = 1; a < p / 2; a++) {
                for (int b = a; b < p / 2; b++) {
                    int c = p - a - b;
                    if (c > 0 && a * a + b * b == c * c) solutions++;
                }
            }

            if (solutions > maxSolutions) {
                maxSolutions = solutions;
                maxP = p;
            }
        }

        System.out.println(maxP);
    }
}
