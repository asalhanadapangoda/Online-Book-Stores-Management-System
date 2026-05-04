<%@ page import="model.*, service.PaymentService, java.util.List" %>
<%@ include file="header.jsp" %>
<%
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String dataPath = service.FileService.DATA_PATH;
    PaymentService paymentService = new PaymentService(dataPath);
    List<Payment> myOrders = paymentService.getPaymentsByUserId(user.getId());
%>

<div class="row justify-content-center">
    <div class="col-md-10">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">My Order History</h2>
            <a href="books" class="btn btn-outline-primary btn-sm">Continue Shopping</a>
        </div>

        <% if (myOrders.isEmpty()) { %>
            <div class="card shadow-sm border-0 py-5 text-center">
                <div class="card-body">
                    <div class="display-1 text-muted mb-3"><i class="bi bi-bag-x"></i></div>
                    <h4>No orders found.</h4>
                    <p class="text-muted">You haven't placed any orders yet.</p>
                    <a href="books" class="btn btn-primary px-4">Browse Books</a>
                </div>
            </div>
        <% } else { %>
            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="bg-light">
                                <tr>
                                    <th class="ps-4">Order ID</th>
                                    <th>Amount</th>
                                    <th>Payment Method</th>
                                    <th>Status</th>
                                    <th class="text-end pe-4">Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Payment p : myOrders) { %>
                                <tr>
                                    <td class="ps-4 fw-bold">#<%= p.getOrderId() %></td>
                                    <td>$<%= String.format("%.2f", p.getAmount()) %></td>
                                    <td>
                                        <span class="badge bg-light text-dark border">
                                            <%= (p instanceof CashOnDelivery) ? "Cash on Delivery" : "Pay Now" %>
                                        </span>
                                    </td>
                                    <td>
                                        <% if ("PENDING".equals(p.getStatus())) { %>
                                            <span class="badge bg-warning text-dark">Pending</span>
                                        <% } else if ("PAID".equals(p.getStatus())) { %>
                                            <span class="badge bg-success">Paid</span>
                                        <% } else { %>
                                            <span class="badge bg-secondary"><%= p.getStatus() %></span>
                                        <% } %>
                                    </td>
                                    <td class="text-end pe-4 text-muted small">
                                        <%= new java.util.Date(Long.parseLong(p.getPaymentId())).toString() %>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</div>

<%@ include file="footer.jsp" %>
