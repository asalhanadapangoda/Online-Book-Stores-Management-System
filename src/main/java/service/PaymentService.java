package service;

import model.Payment;
import model.CashOnDelivery;
import model.PayNowPayment;
import java.util.ArrayList;
import java.util.List;

public class PaymentService {
    private String filePath;

    public PaymentService(String dataPath) {
        this.filePath = dataPath + "payments.txt";
    }

    public void recordPayment(Payment payment) {
        FileService.appendLine(filePath, payment.toString());
    }

    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        List<String> lines = FileService.readAllLines(filePath);
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 6) {
                String pId = parts[0];
                String oId = parts[1];
                String uId = parts[2];
                double amount = Double.parseDouble(parts[3]);
                String status = parts[4];
                String method = parts[5];

                Payment p;
                if (method.equals("COD")) {
                    p = new CashOnDelivery(pId, oId, uId, amount);
                } else {
                    p = new PayNowPayment(pId, oId, uId, amount);
                }
                p.setStatus(status); // Correctly set the status from the file
                payments.add(p);
            }
        }
        return payments;
    }

    public void updatePaymentStatus(String paymentId, String status) {
        List<Payment> payments = getAllPayments();
        List<String> lines = new ArrayList<>();
        for (Payment p : payments) {
            if (p.getPaymentId().equals(paymentId)) {
                p.setStatus(status);
            }
            lines.add(p.toString());
        }
        FileService.writeAllLines(filePath, lines);
    }

    public List<Payment> getPaymentsByUserId(String userId) {
        List<Payment> all = getAllPayments();
        List<Payment> userPayments = new ArrayList<>();
        for (Payment p : all) {
            if (p.getUserId().equals(userId)) {
                userPayments.add(p);
            }
        }
        return userPayments;
    }
}
