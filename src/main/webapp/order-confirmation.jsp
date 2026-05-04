<%@ include file="header.jsp" %>
<div class="text-center py-5">
    <div class="mb-4">
        <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-check-circle-fill text-success" viewBox="0 0 16 16">
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
        </svg>
    </div>
    <h1 class="fw-bold">Order Placed Successfully!</h1>
    <p class="lead text-muted">Thank you for your purchase. Your order ID is: <strong><%= request.getParameter("orderId") %></strong></p>
    <div class="mt-5">
        <a href="books" class="btn btn-primary btn-lg">Continue Shopping</a>
        <a href="orders.jsp" class="btn btn-outline-dark btn-lg ms-2">View Order History</a>
    </div>
</div>
<%@ include file="footer.jsp" %>
