<%@ page import="model.*, java.util.List" %>
<%@ include file="header.jsp" %>
<% 
    String dataPath = service.FileService.DATA_PATH;
    Book b = (Book) request.getAttribute("book");
    if (b != null) {
%>
<div class="row justify-content-center">
    <div class="col-md-9">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="books" class="text-decoration-none">Books</a></li>
                <li class="breadcrumb-item active"><%= b.getCategory() %></li>
            </ol>
        </nav>

        <!-- Book Main Info -->
        <div class="card border-0 shadow-sm mb-5 overflow-hidden">
            <div class="card-body p-5">
                <div class="row align-items-center">
                    <div class="col-lg-7">
                        <h1 class="display-5 fw-bold mb-2"><%= b.getTitle() %></h1>
                        <p class="h4 text-muted mb-4">by <%= b.getAuthor() %></p>
                        
                        <div class="d-flex align-items-center gap-4 mb-4">
                            <div class="text-primary h2 fw-bold mb-0">$<%= String.format("%.2f", b.getPrice()) %></div>
                            <span class="badge bg-light text-dark border p-2"><%= b.getType() %></span>
                        </div>

                        <% if (b instanceof EBook) { EBook eb = (EBook) b; %>
                            <div class="alert alert-light border mb-4">
                                <strong>Digital Details:</strong> File Size: <%= eb.getFileSize() %>
                            </div>
                        <% } else { %>
                            <p class="text-muted"><i class="bi bi-box-seam me-2"></i>Physical Printed Edition</p>
                        <% } %>

                        <% if (user != null) { %>
                            <% if ("CUSTOMER".equals(user.getRole())) { %>
                                <form action="cart" method="POST">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="bookId" value="<%= b.getId() %>">
                                    <button type="submit" class="btn btn-primary btn-lg px-5 py-3 shadow">Add to Shopping Cart</button>
                                </form>
                            <% } else { %>
                                <div class="alert alert-secondary">Admins are in management mode. Shopping is disabled.</div>
                            <% } %>
                        <% } else { %>
                            <div class="alert alert-info">Please <a href="login.jsp" class="fw-bold">login</a> to purchase this book.</div>
                        <% } %>
                    </div>
                    <div class="col-lg-5 text-center mt-4 mt-lg-0">
                        <div class="p-4 bg-light rounded-4 border border-dashed">
                            <div class="h1 text-primary mb-2"><%= b.getStock() %></div>
                            <div class="text-muted text-uppercase small fw-bold">Items in Stock</div>
                            <hr>
                            <div class="small text-muted">Ready for immediate delivery/download</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reviews Section -->
        <div class="row">
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm sticky-top" style="top: 2rem;">
                    <div class="card-body p-4">
                        <h4 class="mb-4">Leave a Review</h4>
                        <% if (user != null) { %>
                            <form action="reviews" method="POST">
                                <input type="hidden" name="bookId" value="<%= b.getId() %>">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold">Your Rating</label>
                                    <select name="rating" class="form-select">
                                        <option value="5">5 Stars - Excellent</option>
                                        <option value="4">4 Stars - Very Good</option>
                                        <option value="3">3 Stars - Good</option>
                                        <option value="2">2 Stars - Fair</option>
                                        <option value="1">1 Star - Poor</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold">Comment</label>
                                    <textarea name="comment" class="form-control" rows="3" placeholder="Tell us what you think..." required></textarea>
                                </div>
                                <button type="submit" class="btn btn-dark w-100 py-2">Submit Review</button>
                            </form>
                        <% } else { %>
                            <p class="text-muted">You must be logged in to leave a review.</p>
                        <% } %>
                    </div>
                </div>
            </div>
            <div class="col-lg-8 mt-4 mt-lg-0">
                <div class="card border-0 shadow-sm">
                    <div class="card-body p-4">
                        <h4 class="mb-4">Customer Feedback</h4>
                        <% 
                            service.ReviewService reviewService = new service.ReviewService(dataPath);
                            service.UserService userService = new service.UserService(dataPath);
                            List<Review> reviews = reviewService.getReviewsByBookId(b.getId());
                            if (!reviews.isEmpty()) {
                                for (Review r : reviews) {
                                    User reviewer = userService.getUserById(r.getUserId());
                                    String reviewerName = (reviewer != null) ? reviewer.getUsername() : "Unknown User";
                        %>
                            <div class="border-bottom pb-4 mb-4 last-child-mb-0">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="fw-bold"><i class="bi bi-person-circle me-2"></i>User: <%= reviewerName %></span>
                                    <div class="mb-0">
                                        <% 
                                            String badgeClass = "secondary";
                                            String rateText = "Unknown";
                                            switch(r.getRating()) {
                                                case 5: badgeClass = "success"; rateText = "Excellent"; break;
                                                case 4: badgeClass = "info text-dark"; rateText = "Very Good"; break;
                                                case 3: badgeClass = "primary"; rateText = "Good"; break;
                                                case 2: badgeClass = "warning text-dark"; rateText = "Fair"; break;
                                                case 1: badgeClass = "danger"; rateText = "Poor"; break;
                                            }
                                        %>
                                        <span class="badge bg-<%= badgeClass %>"><%= rateText %></span>
                                    </div>
                                </div>
                                <p class="text-muted mb-0"><%= r.getComment() %></p>
                            </div>
                        <% 
                                }
                            } else {
                        %>
                            <div class="text-center py-5">
                                <p class="text-muted">No reviews yet. Be the first to review this book!</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<% } else { %>
    <div class="alert alert-warning text-center py-5 mt-5">
        <h3>Book Not Found</h3>
        <p>Sorry, we couldn't find the book you are looking for.</p>
        <a href="books" class="btn btn-primary mt-3">Back to Collection</a>
    </div>
<% } %>
<%@ include file="footer.jsp" %>
