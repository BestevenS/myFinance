public class Main {
    public static void main(String[] args) {
        double initialBalance = 20000;
        double monthlyDeposit = 200;
        double interestRate = 0.03 / 365;
        double target = 240000;

        int monthCount = 0;
        while (initialBalance < target) {
            System.out.println("Μήνας: " + (monthCount + 1) + "ος");
            for (int i = 0; i < 30; i++) {
                initialBalance += initialBalance * interestRate;
            }
            System.out.println("Αρχικό ποσό + μηνιαίο κερδος" + initialBalance);
            initialBalance += monthlyDeposit;
            monthCount++;
        }

        System.out.println("Χρειάζονται περίπου " + monthCount + " μήνες και " + (monthCount / 12) + " χρόνια για να φτάσετε στον στόχο σας.");
    }
}
