public class Main {
    public static void main(String[] args) {
        int[] positions = { 1, 10, 100, 1000, 10000, 100000, 1000000 };

        StringBuilder sequence = new StringBuilder();
        int number = 1;
        while (sequence.length() < 1000000) {
            sequence.append(number);
            number++;
        }

        int product = 1;
        for (int position : positions) {
            int digit = Character.getNumericValue(sequence.charAt(position - 1));
            product *= digit;
        }

        System.out.println(product);
    }
}
