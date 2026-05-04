package model;

import java.io.Serializable;

public abstract class Payment implements Serializable {
    private String paymentId;
    private String orderId;
    private String userId;
    private double amount;
    private String status; // "PENDING", "PAID"
    private String method; // "COD", "PAYNOW"

    public Payment() {}

    public Payment(String paymentId, String orderId, String userId, double amount, String status, String method) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.userId = userId;
        this.amount = amount;
        this.status = status;
        this.method = method;
    }

    // Getters and Setters
    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

    public String getOrderId() { return orderId; }
    public void setOrderId(String orderId) { this.orderId = orderId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    @Override
    public String toString() {
        return paymentId + "|" + orderId + "|" + userId + "|" + amount + "|" + status + "|" + method;
    }
}
