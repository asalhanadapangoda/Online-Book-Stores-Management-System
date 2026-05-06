<%@ include file="header.jsp" %>
<link href="${pageContext.request.contextPath}/css/admin.css" rel="stylesheet">
<h2 class="mb-4">Admin Dashboard</h2>
<div class="row g-4">
    <div class="col-md-4 mb-4">
        <div class="card h-100 shadow-sm border-secondary">
            <div class="card-body text-center">
                <h5 class="card-title">Admin Management</h5>
                <p class="text-muted">Manage system administrators and roles.</p>
                <a href="manage-admins.jsp" class="btn btn-secondary">Go to Admins</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card h-100 shadow-sm border-primary">
            <div class="card-body text-center">
                <h5 class="card-title">Manage Books</h5>
                <p class="text-muted">Add, Edit or Delete books and manage stock.</p>
                <a href="manage-books.jsp" class="btn btn-primary">Go to Books</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card h-100 shadow-sm border-success">
            <div class="card-body text-center">
                <h5 class="card-title">Manage Users</h5>
                <p class="text-muted">View and manage customers and admins.</p>
                <a href="manage-users.jsp" class="btn btn-success">Go to Users</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card h-100 shadow-sm border-warning">
            <div class="card-body text-center">
                <h5 class="card-title">Order History</h5>
                <p class="text-muted">View all customer orders and update payment status.</p>
                <a href="manage-payments.jsp" class="btn btn-warning">View History</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card h-100 shadow-sm border-info">
            <div class="card-body text-center">
                <h5 class="card-title">User Reviews</h5>
                <p class="text-muted">Moderate and delete customer feedback.</p>
                <a href="review-management.jsp" class="btn btn-info">Manage Reviews</a>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
