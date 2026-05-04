<%@ page import="model.*, service.UserService, java.util.List, java.util.ArrayList" %>
<%@ include file="../header.jsp" %>
<% 
    String dataPath = service.FileService.DATA_PATH;
    UserService userService = new UserService(dataPath);
    List<User> allUsers = userService.getAllUsers();
    List<User> admins = new ArrayList<>();
    for (User u : allUsers) {
        if ("ADMIN".equals(u.getRole())) {
            admins.add(u);
        }
    }
%>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Manage Administrators</h2>
    <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#addAdminModal">+ Add New Admin</button>
</div>

<div class="card shadow-sm">
    <div class="card-body">
        <table class="table align-middle">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (User a : admins) { %>
                <tr>
                    <td><%= a.getId() %></td>
                    <td><%= a.getUsername() %></td>
                    <td><%= a.getEmail() %></td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="editAdmin('<%= a.getId() %>', '<%= a.getUsername() %>', '<%= a.getPassword() %>', '<%= a.getEmail() %>')">Edit</button>
                        <% if (!a.getUsername().equals(user.getUsername())) { %>
                            <a href="${pageContext.request.contextPath}/admin?action=deleteUser&id=<%= a.getId() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Remove this admin?')">Remove</a>
                        <% } %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Admin Modal -->
<div class="modal fade" id="addAdminModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="POST">
                <input type="hidden" name="action" value="addAdmin">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Administrator</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Admin</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Admin Modal -->
<div class="modal fade" id="editAdminModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin" method="POST">
                <input type="hidden" name="action" value="updateAdmin">
                <input type="hidden" name="id" id="editAdminId">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Administrator</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" id="editAdminUsername" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" id="editAdminPassword" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" id="editAdminEmail" class="form-control" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Update Admin</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function editAdmin(id, username, password, email) {
    document.getElementById('editAdminId').value = id;
    document.getElementById('editAdminUsername').value = username;
    document.getElementById('editAdminPassword').value = password;
    document.getElementById('editAdminEmail').value = email;
    
    var editModal = new bootstrap.Modal(document.getElementById('editAdminModal'));
    editModal.show();
}
</script>

<%@ include file="../footer.jsp" %>
