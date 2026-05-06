<%@ page import="model.Payment, service.PaymentService, java.util.List" %>
<%@ include file="header.jsp" %>
<% 
    String dataPath = service.FileService.DATA_PATH;
    PaymentService paymentService = new PaymentService(dataPath);
    List<Payment> payments = paymentService.getAllPayments();
%>

<h2 class="mb-4">Order History</h2>

<div class="card shadow-sm">
    <div class="card-body">
        <table class="table">
            <thead>
                <tr>
                    <th>Payment ID</th>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Payment p : payments) { %>
                <tr>
                    <td><%= p.getPaymentId() %></td>
                    <td><%= p.getOrderId() %></td>
                    <td><%= p.getUserId() %></td>
                    <td>$<%= p.getAmount() %></td>
                    <td><%= p.getMethod() %></td>
                    <td>
                        <span class="badge bg-<%= "PAID".equals(p.getStatus()) ? "success" : "warning text-dark" %>">
                            <%= p.getStatus() %>
                        </span>
                    </td>
                    <td>
                        <% if ("PENDING".equals(p.getStatus())) { %>
                        <form action="admin" method="POST" class="d-inline">
                            <input type="hidden" name="action" value="updatePayment">
                            <input type="hidden" name="paymentId" value="<%= p.getPaymentId() %>">
                            <input type="hidden" name="status" value="PAID">
                            <button type="submit" class="btn btn-success btn-sm">Mark as Paid</button>
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="footer.jsp" %>
