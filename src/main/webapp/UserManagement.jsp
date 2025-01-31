<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="model.admin.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
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
}

.sidebar {
	background-color: #3B1E54;
	color: white;
	height: 100vh;
	position: sticky;
	top: 0;
	overflow-y: auto;
}

.sidebar .nav-link {
	color: white;
	font-size: 16px;
	margin-bottom: 10px;
	transition: background 0.3s ease;
}

.sidebar .nav-link:hover, .sidebar .nav-link.active {
	background-color: #D4BEE4;
	border-radius: 5px;
	color: #EEEEEE;
}

.content-header {
	background-color: #ecf0f1;
	padding: 15px 20px;
	border-bottom: 1px solid #bdc3c7;
}

.main-content {
	padding: 20px;
	background-color: #f9f9f9;
	min-height: calc(100vh - 61px);
}

.btn-primary {
	background-color: #007BFF;
	color: white;
	padding: 12px 24px;
	border: none;
	cursor: pointer;
	font-size: 16px;
	border-radius: 6px;
	transition: background-color 0.3s ease;
	margin-bottom: 20px;
}

.btn-primary:hover {
	background-color: #0056b3;
}

table {
	width: 100%;
	margin-top: 20px;
	border-collapse: collapse;
}

th, td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #f9f9f9;
	color: #333;
}

td {
	background-color: #f4f7fc;
}

tr:hover {
	background-color: #f1f1f1;
}

.toggle-btn {
	padding: 10px 20px;
	border: none;
	cursor: pointer;
	font-size: 14px;
	border-radius: 6px;
}

.active {
	background-color: #4CAF50;
	color: white;
}

.inactive {
	background-color: #f44336;
	color: white;
}

.action-buttons {
	display: flex;
	gap: 10px;
}

.toggle-btn:focus {
	outline: none;
}
</style>
<script>
        function toggleButton(button, mailID, currentState) {
            var form = button.closest('form');
            if (currentState === 'Active') {
                form.action = 'UserManagement';
                button.classList.remove('active');
                button.classList.add('inactive');
                button.innerHTML = 'Deactivate';
                form.querySelector('[name="action"]').value = 'deactivate';
            } else {
                form.action = 'UserManagement';
                button.classList.remove('inactive');
                button.classList.add('active');
                button.innerHTML = 'Activate';
                form.querySelector('[name="action"]').value = 'activate';
            }
            form.submit();
        }
    </script>
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
					<li class="nav-item"><a class="nav-link active"
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
					<li class="nav-item"><a class="nav-link"
						href="FeedBackServlet"> <i
							class="bi bi-chat-dots me-2"></i>Feedback Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="Report_Generation"> <i
							class="bi bi-file-earmark-text me-2"></i>Report Management
					</a></li>
				</ul>
			</nav>

			<!-- Main Content -->
			<div class="col-md-9 col-lg-10 p-0">
				<!-- Header -->
				<div
					class="content-header d-flex justify-content-between align-items-center">
					<h5 class="mb-0">User Management</h5>
					<button type="button" class="btn ms-1 btn btn-outline-danger" onclick="window.location.href='login.jsp'">
    <i class="bi bi-box-arrow-right"></i> Logout
</button>
				</div>

				<!-- Dynamic Content -->
				<div class="main-content" id="main-content">
					<div class="container">
						<h1>User Management</h1>
						<p>Manage users, view user profiles, and assign roles.</p>

						<!-- View Users Button -->
						<form method="POST" action="UserManagement">
							<button type="submit" class="btn-primary">View Users</button>
						</form>

						<!-- Scrollable Table Panel -->
						<div
							style="max-height: 400px; overflow-y: auto; margin-top: 20px; border: 1px solid #ddd; border-radius: 8px; padding: 10px; background-color: white;">
							<table>
								<thead>
									<tr>
										<th>ID</th>
										<th>Name</th>
										<th>Email</th>
										<th>Role</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<% 
                                  List<UserPojo> userList = (List<UserPojo>) request.getAttribute("userList");
                                  if (userList != null) {
                                      for (UserPojo user : userList) {
                                          boolean isActive = !user.getRole().startsWith("Inactive_");
                                          String buttonClass = isActive ? "inactive" : "active";
                                          String buttonLabel = isActive ? "Deactivate" : "Activate";
                              %>
									<tr>
										<td><%= user.getUserID() %></td>
										<td><%= user.getName() %></td>
										<td><%= user.getMailID() %></td>
										<td><%= user.getRole() %></td>
										<td>
											<form method="POST" action="UserManagement"
												style="display: inline;">
												<input type="hidden" name="mailID"
													value="<%= user.getMailID() %>"> <input
													type="hidden" name="userID" value="<%= user.getUserID() %>">
												<input type="hidden" name="name"
													value="<%= user.getName() %>"> <input type="hidden"
													name="role" value="<%= user.getRole() %>">
												<button type="button" class="toggle-btn <%= buttonClass %>"
													onclick="toggleButton(this, '<%= user.getMailID() %>', '<%= isActive ? "Active" : "Inactive" %>')">
													<%= buttonLabel %>
												</button>
												<input type="hidden" name="action"
													value="<%= isActive ? "deactivate" : "activate" %>">
											</form>
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
				</div>
			</div>
		</div>
	</div>
</body>
</html>