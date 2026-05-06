<%@ page import="model.User, service.UserService, java.util.List" %>
<%@ include file="header.jsp" %>
<% 
    String dataPath = service.FileService.DATA_PATH;
    UserService userService = new UserService(dataPath);
    List<User> users = userService.getAllUsers();
%>

<div class="mb-4">
    <h2>Manage Users</h2>
</div>

<div class="card shadow-sm">
    <div class="card-body">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Address</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (User u : users) { 
                        if (!"ADMIN".equals(u.getRole())) { 
                %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getUsername() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><span class="badge bg-info"><%= u.getRole() %></span></td>
                    <td><%= u.getAddress() %></td>
                    <td>
                        <a href="admin?action=deleteUser&id=<%= u.getId() %>" class="btn btn-outline-danger btn-sm" onclick="return confirm('Delete this user?')">Remove</a>
                    </td>
                </tr>
                <% 
                        }
                    } 
                %>
            </tbody>
        </table>
    </div>
</div>
<%@ include file="footer.jsp" %>
