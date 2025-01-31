<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.admin.FeedbackPojo"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin Dashboard</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<style>
body {
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	background-color: #ecf0f1;
	margin: 0;
}

.sidebar {
	height: 100vh;
	background-color: #3B1E54;
	color: white;
	padding-top: 20px;
	position: fixed;
}

.sidebar .nav-link {
	color: #ecf0f1;
	transition: all 0.3s ease;
	font-size: 16px;
	border-radius: 5px;
	margin-bottom: 5px;
}

.sidebar .nav-link:hover, .sidebar .nav-link.active {
	background-color: #cbc3e3;
	color: #fff;
}

.content-header {
	background-color: #ecf0f1;
	padding: 15px 20px;
	border-bottom: 1px solid #bdc3c7;
}

.container-fluid {
	padding: 0;
}

.col-md-9.col-lg-10.p-0 {
	margin-left: 16.666667%;
}

.main-content {
	padding: 20px;
	background-color: #f9f9f9;
	min-height: calc(100vh - 61px);
}

.btn-logout {
	background-color: #e74c3c;
	border-color: #c0392b;
}

.btn-logout:hover {
	background-color: #c0392b;
}

table {
	background-color: #ffffff;
	border-radius: 5px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

table th {
	background-color: #2c3e50;
	color: white;
}

table th, table td {
	text-align: center;
	padding: 10px;
}

tbody {
	display: block;
	max-height: 150px;
	overflow-y: scroll;
	width: 100%;
}

table thead, table tbody tr {
	display: table;
	width: 100%;
	table-layout: fixed;
}

.feedback-summary {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.feedback-summary h4 {
	margin-bottom: 20px;
}

.list-group-item {
	font-size: 1rem;
	line-height: 1.5;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<nav class="col-md-3 col-lg-2 sidebar d-flex flex-column p-3">
				<h4 class="text-center mb-4">Admin Panel</h4>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link "
						href="Admin_Dashboard"> <i class="bi bi-speedometer2 me-2"></i>Dashboard
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="UserManagement.jsp"> <i class="bi bi-people me-2"></i>User
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="product_management.jsp"> <i class="bi bi-box-seam me-2"></i>Product
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="algorithm_monitoring.jsp"> <i class="bi bi-cpu me-2"></i>Algorithm
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link active" href="FeedbackServlet">
							<i class="bi bi-chat-dots me-2"></i>Feedback Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="Report_Generation"> <i
							class="bi bi-file-earmark-text me-2"></i>Report Management
					</a></li>
				</ul>
			</nav>

			<!-- Main Content -->
			<div class="col-md-9 col-lg-10 p-0">
				<div
					class="content-header d-flex justify-content-between align-items-center">
					<h5 class="mb-0">Welcome, Admin</h5>
					<button type="button" class="btn ms-1 btn btn-outline-danger" onclick="window.location.href='login.jsp'">
    <i class="bi bi-box-arrow-right"></i> Logout
</button>
					
				</div>
				<div class="main-content" id="main-content">
					<!-- Feedback Table -->
					<h4 class="mb-4">Feedback Data</h4>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Serial No</th>
								<th>User</th>
								<th>Feedback</th>
								<th>Rating</th>
							</tr>
						</thead>
						<tbody>
							<%
                  List<FeedbackPojo> feedbackList = (List<FeedbackPojo>) request.getAttribute("feedbackList");
                  if (feedbackList != null && !feedbackList.isEmpty()) {
                    for (int i = 0; i < feedbackList.size(); i++) {
                      FeedbackPojo feedback = feedbackList.get(i);
                %>
							<tr>
								<td><%= i + 1 %></td>
								<td><%= feedback.getCustomerId() %></td>
								<td><%= feedback.getComments() %></td>
								<td><%= feedback.getRatings() %></td>
							</tr>
							<%
                    }
                  } else {
                %>
							<tr>
								<td colspan="4" class="text-center">No feedback data
									available</td>
							</tr>
							<%
                  }
                %>
						</tbody>
					</table>

					<!-- Feedback Summary -->
					<div class="feedback-summary mt-4">
						<h4>Feedback Summary</h4>
						<ul class="list-group">
							<li class="list-group-item"><strong>Total Feedback:</strong>
								<%= feedbackList != null ? feedbackList.size() : 0 %></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>