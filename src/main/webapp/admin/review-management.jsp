<%@ page import="model.Review, service.ReviewService, java.util.List" %>
<%@ include file="../header.jsp" %>
<% 
    String dataPath = service.FileService.DATA_PATH;
    ReviewService reviewService = new ReviewService(dataPath);
    List<Review> reviews = reviewService.getAllReviews();
%>

<h2 class="mb-4">Customer Review Management</h2>

<div class="card shadow-sm">
    <div class="card-body">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Book ID</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (reviews.isEmpty()) { %>
                    <tr><td colspan="6" class="text-center text-muted">No reviews found.</td></tr>
                <% } else { %>
                    <% for (Review r : reviews) { %>
                    <tr>
                        <td><%= r.getId() %></td>
                        <td><%= r.getUserId() %></td>
                        <td><%= r.getBookId() %></td>
                        <td>
                            <span class="text-warning">
                                <%= "★".repeat(r.getRating()) + "☆".repeat(5-r.getRating()) %>
                            </span>
                        </td>
                        <td><%= r.getComment() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/reviews?action=delete&id=<%= r.getId() %>" 
                               class="btn btn-outline-danger btn-sm" 
                               onclick="return confirm('Are you sure you want to delete this review?')">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<div class="mt-4">
    <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>

<%@ include file="../footer.jsp" %>
