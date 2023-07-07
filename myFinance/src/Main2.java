public class Main2 {
    public static void main(String[] args) {
        // Αρχικές τιμές
        double initialInvestment = 10000.0;
        double monthlyDeposit = 200.0;
        double annualInterest = 0.05; // 5% ετήσια επιτόκια
        double targetAmount = 240000.0;
        int monthsPerYear = 12;

        int years = 0;

        while (initialInvestment < targetAmount) {
            // Προσθέτουμε το ετήσιο επιτόκιο
            initialInvestment += initialInvestment * annualInterest;

            // Προσθέτουμε την μηνιαία κατάθεση για κάθε μήνα του χρόνου
            for (int month = 0; month < monthsPerYear; month++) {
                initialInvestment += monthlyDeposit;
            }

            years++; // Περνάει ένας χρόνος
        }

        System.out.println("Θα χρειαστείτε " + years + " χρόνια για να φτάσετε στα " + targetAmount + " ευρώ.");
    }

}
