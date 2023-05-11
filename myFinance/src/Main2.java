public class Main2 {
    public static void main(String[] args) {
        double initialBalance = 20000.0; // initial balance
        double deposit = 200.0; // monthly deposit
        double annualRate = 0.10; // annual interest rate
        double target = 240000.0; // target balance

        int monthCount = 0;

        while (initialBalance < target) {
            // Add monthly deposit
            initialBalance += deposit;
            
            monthCount++;

            // Apply annual interest at the end of each year
            if (monthCount % 12 == 0) {
                initialBalance += initialBalance * annualRate;
            }
        }

        int yearsRequired = monthCount / 12;

        System.out.println("Χρειάζονται περίπου " + yearsRequired + " χρόνια για να φτάσετε στον στόχο σας.");
    }
}
