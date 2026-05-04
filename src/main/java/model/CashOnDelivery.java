package model;

public class CashOnDelivery extends Payment {
    public CashOnDelivery() {
        super();
        setMethod("COD");
        setStatus("PENDING");
    }

    public CashOnDelivery(String paymentId, String orderId, String userId, double amount) {
        super(paymentId, orderId, userId, amount, "PENDING", "COD");
    }
}
