<%@ include file="header.jsp" %>
<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card shadow">
            <div class="card-body p-4">
                <h3 class="card-title mb-4 text-center">Complete Your Order</h3>
                <form action="payment" method="POST">
                    <div class="mb-4">
                        <h6>Shipping Address:</h6>
                        <p class="text-muted border p-2 rounded bg-light"><%= user.getAddress() %></p>
                        <a href="profile.jsp" class="btn btn-link btn-sm p-0">Edit Address</a>
                    </div>
                    
                    <div class="mb-4">
                        <h6>Select Payment Method:</h6>
                        <div class="form-check border p-3 rounded mb-2">
                            <input class="form-check-input" type="radio" name="method" id="paynow" value="PAYNOW" required checked>
                            <label class="form-check-label w-100" for="paynow">
                                <strong>PayNow</strong>
                                <small class="d-block text-muted">Instant payment. Order marked as Paid immediately.</small>
                            </label>
                        </div>
                        <div class="form-check border p-3 rounded">
                            <input class="form-check-input" type="radio" name="method" id="cod" value="COD">
                            <label class="form-check-label w-100" for="cod">
                                <strong>Cash on Delivery</strong>
                                <small class="d-block text-muted">Pay when you receive the items. Order marked as Pending.</small>
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 btn-lg">Place Order</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
