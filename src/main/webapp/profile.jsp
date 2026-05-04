<%@ include file="header.jsp" %>
<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card shadow">
            <div class="card-body p-4">
                <h3 class="card-title mb-4">Your Profile</h3>
                <form action="auth" method="POST">
                    <input type="hidden" name="action" value="updateProfile">
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" value="<%= user.getUsername() %>" readonly disabled>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" value="<%= user.getEmail() %>" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" value="<%= user.getPassword() %>" required>
                    </div>
                    <% if ("CUSTOMER".equals(user.getRole())) { %>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <textarea name="address" class="form-control" rows="3" required><%= user.getAddress() %></textarea>
                    </div>
                    <% } else { %>
                        <input type="hidden" name="address" value="<%= user.getAddress() %>">
                    <% } %>
                    <button type="submit" class="btn btn-primary w-100 mt-3">Update Profile</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="footer.jsp" %>
