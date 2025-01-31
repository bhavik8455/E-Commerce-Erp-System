<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.CustomerPojo"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Customer Profile</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
    min-height: 100vh;
    background: linear-gradient(135deg, #f5f3ff 0%, #e9d5ff 100%);
    font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0;
    padding: 20px;
}

.container {
    width: 100%;
    max-width: 500px; /* Reduced from 600px */
}

.profile-container {
    margin: 0 auto;
    padding: 25px; /* Reduced from 35px */
    background-color: rgba(255, 255, 255, 0.95);
    border-radius: 16px;
    box-shadow: 0 10px 25px rgba(149, 128, 168, 0.15);
    backdrop-filter: blur(10px);
}

.profile-header {
    text-align: center;
    margin-bottom: 25px; /* Reduced from 35px */
    padding-bottom: 15px; /* Reduced from 25px */
    border-bottom: 2px solid #f0f0f7;
}

.profile-avatar {
    width: 100px; /* Reduced from 130px */
    height: 100px; /* Reduced from 130px */
    border-radius: 50px;
    margin-bottom: 15px; /* Reduced from 20px */
    padding: 3px;
    border: 2px solid #8b7aa8;
    transition: transform 0.3s ease;
}

.profile-avatar:hover {
    transform: scale(1.05);
}

.profile-header h2 {
    color: #4a4169;
    font-weight: 600;
    margin-top: 10px;
    font-size: 1.5rem; /* Slightly smaller */
}

.form-label {
    color: #4a4169;
    font-weight: 500;
    font-size: 0.9rem;
    margin-bottom: 6px;
}

.form-control {
    border: 1.5px solid #e0e0ea;
    border-radius: 10px;
    padding: 8px 12px; /* Reduced padding */
    transition: all 0.3s ease;
}

.mb-3 {
    margin-bottom: 15px !important; /* Reduced from default bootstrap spacing */
}

textarea.form-control {
    min-height: 60px; /* Reduced from 100px */
    resize: none;
}

.btn {
    padding: 10px 16px; /* Reduced padding */
    font-weight: 500;
    border-radius: 10px;
    transition: all 0.3s ease;
}

.btn-primary {
    background-color: #6c5b7b;
    border: none;
}

.btn-primary:hover {
    background-color: #574a63;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(108, 91, 123, 0.2);
}

.btn-secondary {
    background-color: #f8f7fc;
    border: 1.5px solid #e0e0ea;
    color: #4a4169;
}

.btn-secondary:hover {
    background-color: #e8e5f0;
    border-color: #d5d1e0;
    color: #4a4169;
}

.d-grid.gap-2 {
    margin-top: 20px; /* Reduced from 30px */
}

.alert {
    border-radius: 10px;
    border: none;
    padding: 12px; /* Reduced padding */
    margin-bottom: 20px;
}

/* Glass effect for profile container */
@supports (-webkit-backdrop-filter: none) or (backdrop-filter: none) {
    .profile-container {
        background-color: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
    }
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .profile-container {
        margin: 0 auto;
        padding: 20px;
    }
    
    body {
        padding: 15px;
    }
}
</style>
</head>
<body>
	<div class="container">
		<div class="profile-container">
			<div class="profile-header">
				<img src="https://cdn-icons-png.flaticon.com/512/10813/10813372.png"
					alt="Profile Avatar" class="profile-avatar">
				<h2>Customer Profile</h2>
			</div>

			<% if(request.getAttribute("message") != null) { %>
			<div class="alert alert-success alert-dismissible fade show"
				role="alert">
				<%= request.getAttribute("message") %>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
			<% } %>

			<% if(request.getAttribute("error") != null) { %>
			<div class="alert alert-danger alert-dismissible fade show"
				role="alert">
				<%= request.getAttribute("error") %>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					aria-label="Close"></button>
			</div>
			<% } %>

			<% CustomerPojo customer = (CustomerPojo) request.getAttribute("customer"); %>
			<form action="UserProfile" method="POST">
				<div class="mb-3">
					<label for="name" class="form-label">Name</label> <input
						type="text" class="form-control" id="name" name="name"
						value="<%= customer != null ? customer.getName() : "" %>" required>
				</div>
				<div class="mb-3">
					<label for="email" class="form-label">Email</label> <input
						type="email" class="form-control" id="email" name="email"
						value="<%= customer != null ? customer.getEmail() : "" %>"
						required>
				</div>
				<div class="mb-3">
					<label for="phone" class="form-label">Phone</label> <input
						type="tel" class="form-control" id="phone" name="phone"
						value="<%= customer != null ? customer.getPhone() : "" %>">
				</div>
				<div class="mb-3">
					<label for="address" class="form-label">Address</label>
					<textarea class="form-control" id="address" name="address" rows="3"><%= customer != null ? customer.getAddress() : "" %></textarea>
				</div>
				<div class="mb-3">
					<label for="loyaltyPoints" class="form-label">Loyalty
						Points</label> <input type="text" class="form-control readonly-field"
						id="loyaltyPoints"
						value="<%= customer != null ? customer.getLoyaltyPoints() : "0" %>"
						readonly>
				</div>
				<div class="d-grid gap-2">
					<button type="submit" class="btn btn-primary">Update
						Profile</button>
					<a href="HomePage" class="btn btn-secondary">Back to Home</a>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>