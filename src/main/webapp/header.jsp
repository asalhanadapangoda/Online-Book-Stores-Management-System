<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookStore - Premium Collection</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-5">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
                <span class="text-primary">B</span>ookStore
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <!-- Left side empty -->
                </ul>
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/books">Books</a></li>
                    <% 
                        User user = (User) session.getAttribute("user");
                        if (user == null) {
                    %>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Register</a></li>
                    <% } else { %>
                        <% if ("ADMIN".equals(user.getRole())) { %>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp">Dashboard</a></li>
                        <% } %>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/orders.jsp">Orders</a></li>
                        <% if ("CUSTOMER".equals(user.getRole())) { %>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cart.jsp">Cart</a></li>
                        <% } %>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/profile.jsp">Profile</a></li>
                        <li class="nav-item ms-lg-3"><a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/auth?action=logout">Logout</a></li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
    <div class="main-content">
        <div class="container">
