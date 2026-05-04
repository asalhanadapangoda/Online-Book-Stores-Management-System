<%@ page import="model.Book, java.util.List" %>
<%@ include file="header.jsp" %>
<h2 class="mb-4">Available Books</h2>
<div class="row">
    <% 
        List<Book> books = (List<Book>) request.getAttribute("books");
        if (books != null) {
            for (Book b : books) {
    %>
    <div class="col-md-3 mb-4">
        <div class="card h-100 shadow-sm">
            <div class="card-body">
                <h5 class="card-title"><%= b.getTitle() %></h5>
                <p class="text-muted small">by <%= b.getAuthor() %></p>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-primary">$<%= String.format("%.2f", b.getPrice()) %></span>
                    <span class="badge bg-secondary"><%= b.getType() %></span>
                </div>
            </div>
            <div class="card-footer bg-transparent border-top-0">
                <a href="books?id=<%= b.getId() %>" class="btn btn-outline-dark btn-sm w-100">View Details</a>
            </div>
        </div>
    </div>
    <% 
            }
        } else {
    %>
    <div class="col-12 text-center py-5">
        <p class="text-muted">No books available. Check back later!</p>
    </div>
    <% } %>
</div>
<%@ include file="footer.jsp" %>
