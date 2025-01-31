<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin Dashboard - Algorithm Monitoring</title>
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
}

.sidebar {
	height: 100vh;
	background-color: #3B1E54;
	color: white;
	padding-top: 20px;
	position: fixed;
}

.sidebar .nav-link {
	color: white;
	transition: all 0.3s ease;
	font-size:16px;
	border-radius: 5px;
	margin-bottom: 5px;
}

.sidebar .nav-link:hover, .sidebar .nav-link.active {
	background-color: #D4BEE4;
	color: #EEEE;
}

.content-header {
	background-color: #ecf0f1;
	padding: 15px 20px;
	border-bottom: 1px solid #bdc3c7;
}

.col-md-9.col-lg-10.p-0 {
	margin-left: 16.666667%;
}

.main-content {
	padding: 20px;
	background-color: #f9f9f9;
	min-height: calc(100vh - 61px);
	margin: 0;
	overflow-y: auto;
}

.btn-logout {
	background-color: #e74c3c;
	border-color: #c0392b;
}

.btn-logout:hover {
	background-color: #c0392b;
}

.button-group {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-bottom: 10px;
	justify-content: center;
}

button {
	padding: 10px 20px;
	background-color: #48207d;
	border: none;
	color: white;
	font-size: 16px;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #800080;
}

.output-container {
	border: 1px solid #ccc;
	padding: 5px;
	border-radius: 5px;
	background-color: #f8f8f8;
	overflow-x: auto;
	word-break: break-word;
	max-width: 100%;
	min-height: 50px;
}

.error-message {
	color: red;
	font-weight: bold;
}

.table-container {
	max-height: 200px;
	overflow-y: auto;
	position: relative;
	margin-top: 10px;
}

.table thead th {
	position: sticky;
	top: 0;
	background-color: #ecf0f1;
	z-index: 1;
	text-align: center;
}

.table {
	width: 80%;
	margin: 0 auto;
	table-layout: fixed;
	font-size: 14px;
}

.table th, .table td {
	word-wrap: break-word;
	max-width: 120px;
	text-align: center;
	padding: 8px;
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
					<li class="nav-item"><a class="nav-link"
						href="Admin_Dashboard"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a></li>
					<li class="nav-item"><a class="nav-link"
						href="UserManagement.jsp"><i class="bi bi-people me-2"></i>User
							Management</a></li>
					<li class="nav-item"><a class="nav-link"
						href="product_management.jsp"><i class="bi bi-box-seam me-2"></i>Product
							Management</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="algorithm_monitoring.jsp"><i
							class="bi bi-cpu me-2"></i>Algorithm Management</a></li>
					<li class="nav-item"><a class="nav-link" href="FeedbackServlet"><i
							class="bi bi-chat-dots me-2"></i>Feedback Management</a></li>
					<li class="nav-item"><a class="nav-link"
						href="Report_Generation"><i
							class="bi bi-file-earmark-text me-2"></i>Report Management</a></li>
				</ul>
			</nav>

			<!-- Main Content -->
			<div class="col-md-9 col-lg-10 p-0">
				<!-- Header -->
				<div
					class="content-header d-flex justify-content-between align-items-center">
					<h5 class="mb-0">Welcome, Admin</h5>
					<button type="button" class="btn ms-1 btn btn-outline-danger" onclick="window.location.href='login.jsp'">
    <i class="bi bi-box-arrow-right"></i> Logout
</button>
				</div>

				<!-- Dynamic Content -->
				<div class="main-content" id="main-content">
					<h1 class="text-center">Algorithm Monitoring</h1>

					<form action="Algorithm" method="post" class="text-center">
						<div class="button-group">
							<button type="submit" name="algorithm" value="salesTrend">Sales
								Trend Analysis</button>
							<button type="submit" name="algorithm" value="profit">Profit
								Analysis</button>
							<button type="submit" name="algorithm" value="abc">ABC
								Classification</button>
							<button type="submit" name="algorithm" value="turnover">Inventory
								Turnover Ratio</button>
							<button type="submit" name="algorithm" value="demandForecast">Demand
								Forecast</button>
						</div>
					</form>

					<div class="output-container">
						<% 
                String jsonData = "";
                List<Map<String, String>> resultList = null;

                if (request.getAttribute("salestrend") != null) {
                    jsonData = (String) request.getAttribute("salestrend");
                } else if (request.getAttribute("profitanalysis") != null) {
                    jsonData = (String) request.getAttribute("profitanalysis");
                } else if (request.getAttribute("abc") != null) {
                    jsonData = (String) request.getAttribute("abc");
                } else if (request.getAttribute("turnover") != null) {
                    jsonData = (String) request.getAttribute("turnover");
                } else if (request.getAttribute("demandForecast") != null) {
                    jsonData = (String) request.getAttribute("demandForecast");
                } else if (request.getAttribute("errorMessage") != null) {
                    out.print("<div class='error-message'>" + request.getAttribute("errorMessage") + "</div>");
                }

                if (!jsonData.isEmpty()) {
                    Gson gson = new Gson();

                    if (jsonData.startsWith("{")) {
                        Map<String, String> singleResult = gson.fromJson(jsonData, Map.class);
                        resultList = new ArrayList<>();
                        resultList.add(singleResult);
                    } else {
                        resultList = gson.fromJson(jsonData, List.class);
                    }
                }

                if (resultList != null && !resultList.isEmpty()) {
              %>

						<div class="table-container">
							<table class="table table-bordered">
								<thead>
									<tr>
										<% 
                        Set<String> keys = resultList.get(0).keySet();
                        boolean hasPercentageChange = false;  // Flag to check if the column exists
                        for (String key : keys) {
                          if (key.equalsIgnoreCase("percentage change") && request.getAttribute("salestrend") != null) {
                            hasPercentageChange = true;
                          }
                      %>
										<th><%= key %></th>
										<% 
                        }
                        
                        // If "Percentage Change" column is not in the keys and the current algorithm is "Sales Trend", add it manually
                        if (!hasPercentageChange && request.getAttribute("salestrend") != null) {
                      %>
										<th>Percentage Change</th>
										<% 
                        }
                      %>
									</tr>
								</thead>
								<tbody>
									<% 
                      for (Map<String, String> row : resultList) { 
                    %>
									<tr>
										<% 
                          for (String key : row.keySet()) { 
                            Object value = row.get(key);
                        %>
										<td>
											<% 
                              if (value == null) {
                            %> N/A <% 
                              } else if (value instanceof Integer) {
                            %>  <%= Math.round((Double) value) %>
											<% 
                              } else {
                            %> <%= value.toString() %> <!-- Fallback for other types -->
											<% 
                              }
                            %>
										</td>
										<% } %>
									</tr>
									<% 
                      }
                    %>
								</tbody>
							</table>
						</div>

						<% 
                } else { 
              %>
						<p>No data available to display.</p>
						<% 
                } 
              %>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>