<%@ page import="model.CartItem, java.util.List" %>
<%@ include file="header.jsp" %>
<h2 class="mb-4">Your Shopping Cart</h2>
<% 
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
%>
    <div class="text-center py-5">
        <p class="text-muted">Your cart is empty.</p>
        <a href="books" class="btn btn-primary">Start Shopping</a>
    </div>
<% } else { %>
    <div class="row">
        <div class="col-md-8">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Book</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                double total = 0;
                                for (CartItem item : cart) { 
                                    total += item.getTotalPrice();
                            %>
                            <tr>
                                <td>
                                    <strong><%= item.getBook().getTitle() %></strong><br>
                                    <small class="text-muted"><%= item.getBook().getType() %></small>
                                </td>
                                <td>$<%= String.format("%.2f", item.getBook().getPrice()) %></td>
                                <td>
                                    <form action="cart" method="POST" class="d-flex align-items-center">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="bookId" value="<%= item.getBook().getId() %>">
                                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" class="form-control form-control-sm" style="width: 60px;" onchange="this.form.submit()">
                                    </form>
                                </td>
                                <td>$<%= String.format("%.2f", item.getTotalPrice()) %></td>
                                <td>
                                    <form action="cart" method="POST">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="bookId" value="<%= item.getBook().getId() %>">
                                        <button type="submit" class="btn btn-outline-danger btn-sm">Remove</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title mb-4">Order Summary</h5>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal</span>
                        <span>$<%= String.format("%.2f", total) %></span>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                        <span class="fw-bold">Total</span>
                        <span class="fw-bold text-primary h4">$<%= String.format("%.2f", total) %></span>
                    </div>
                    <a href="checkout.jsp" class="btn btn-success w-100 btn-lg">Proceed to Checkout</a>
                </div>
            </div>
        </div>
    </div>
<% } %>
<%@ include file="footer.jsp" %>
