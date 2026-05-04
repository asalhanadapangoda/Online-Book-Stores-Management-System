package model;

public class PayNowPayment extends Payment {
    public PayNowPayment() {
        super();
        setMethod("PAYNOW");
        setStatus("PAID"); // Automatically marked as paid per requirements
    }

    public PayNowPayment(String paymentId, String orderId, String userId, double amount) {
        super(paymentId, orderId, userId, amount, "PAID", "PAYNOW");
    }
}
