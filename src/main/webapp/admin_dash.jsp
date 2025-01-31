<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.stream.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
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
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease-in-out;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .table-container {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
        }
        .table-container .table {
            margin-bottom: 0;
        }
        .table-container thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 1;
        }
        .class-badge {
            display: inline-block;
            padding: 0.25em 0.75em;
            font-size: 0.875em;
            font-weight: 600;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.25rem;
        }
        .class-A { background-color: #d4edda; color: #155724; }
        .class-B { background-color: #fff3cd; color: #856404; }
        .class-C { background-color: #f8d7da; color: #721c24; }
        .cards-container {
            display: flex;
            gap: 1rem;
        }
        .info-card {
            color: white;
            flex: 1;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            padding: 1rem;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }
        .info-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
        }
        .info-card i {
            font-size: 3rem;
            margin-bottom: 0.5rem;
        }
        .info-card h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }
        .info-card p {
            font-size: 1.8rem;
            font-weight: bold;
        }
        .total-revenue { background: linear-gradient(135deg, #ff7eb3, #ff758c); }
        .total-users { background: linear-gradient(135deg, #6a85b6, #bac8e0); }
        .total-products { background: linear-gradient(135deg, #6decb9, #3cd28d); }
    </style>
</head>
<body>
    <%
	String jsonData = (String) request.getAttribute("salesTrendData");
	Gson gson = new Gson();
	JsonArray salesTrendArray = JsonParser.parseString(jsonData).getAsJsonArray();
	StringBuilder salesTrendLabels = new StringBuilder();
	StringBuilder salesTrendData = new StringBuilder();

	salesTrendLabels.append("[");
	salesTrendData.append("[");

	for (int i = 0; i < salesTrendArray.size(); i++) {
		JsonObject obj = salesTrendArray.get(i).getAsJsonObject();
		salesTrendLabels.append("'" + obj.get("month").getAsString() + "'");
		salesTrendData
		.append(obj.get("percentage_change").isJsonNull() ? "null" : obj.get("percentage_change").getAsDouble());

		if (i < salesTrendArray.size() - 1) {
			salesTrendLabels.append(",");
			salesTrendData.append(",");
		}
	}
	salesTrendLabels.append("]");
	salesTrendData.append("]");

	String abcData = (String) request.getAttribute("abc_classificationData");
	JsonArray abcArray = JsonParser.parseString(abcData).getAsJsonArray();
	Map<String, Integer> abcTotals = new HashMap<>();

	// Count the number of products in each class instead of summing product IDs
	for (int i = 0; i < abcArray.size(); i++) {
		JsonObject obj = abcArray.get(i).getAsJsonObject();
		String className = obj.get("class").getAsString();
		// Increment the count by 1 for each product instead of adding the product ID
		abcTotals.put(className, abcTotals.getOrDefault(className, 0) + 1);
	}

	StringBuilder abcLabels = new StringBuilder("[");
	StringBuilder abcDataPoints = new StringBuilder("[");

	int count = 0;
	for (Map.Entry<String, Integer> entry : abcTotals.entrySet()) {
		abcLabels.append("'Class " + entry.getKey() + "'");
		abcDataPoints.append(entry.getValue());
		if (++count < abcTotals.size()) {
			abcLabels.append(",");
			abcDataPoints.append(",");
		}
	}
	abcLabels.append("]");
	abcDataPoints.append("]");

	String productJson = (String) request.getAttribute("abc_classificationData");

	String demandForecastData = (String) request.getAttribute("demandForecast"); // Replace with actual attribute
	JsonArray demandForecastArray = JsonParser.parseString(demandForecastData).getAsJsonArray();

	// Prepare data for the chart
	StringBuilder demandForecastLabels = new StringBuilder("[");
	StringBuilder demandForecastDataPoints = new StringBuilder("[");

	for (int i = 0; i < demandForecastArray.size(); i++) {
		JsonObject obj = demandForecastArray.get(i).getAsJsonObject();
		demandForecastLabels.append("'").append(obj.get("ProductName").getAsString()).append("'");
		demandForecastDataPoints.append(obj.get("PredictedDemand").getAsDouble());
		if (i < demandForecastArray.size() - 1) {
			demandForecastLabels.append(", ");
			demandForecastDataPoints.append(", ");
		}
	}
	demandForecastLabels.append("]");
	demandForecastDataPoints.append("]");

	String turnoverData = (String) request.getAttribute("inventoryratio"); // Replace with actual attribute
	JsonArray turnoverArray = JsonParser.parseString(turnoverData).getAsJsonArray();

	// Prepare data for the chart
	StringBuilder turnoverYears = new StringBuilder("[");
	StringBuilder turnoverRatios = new StringBuilder("[");

	for (int i = 0; i < turnoverArray.size(); i++) {
		JsonObject obj = turnoverArray.get(i).getAsJsonObject();
		turnoverYears.append(obj.get("Year").getAsInt());
		turnoverRatios.append(obj.get("Ratio").getAsDouble());
		if (i < turnoverArray.size() - 1) {
			turnoverYears.append(", ");
			turnoverRatios.append(", ");
		}
	}
	turnoverYears.append("]");
	turnoverRatios.append("]");

	String profitData = (String) request.getAttribute("profitability"); // Replace with actual attribute
	JsonObject profitJson = JsonParser.parseString(profitData).getAsJsonObject();

	// Extract the top 5 products based on profit margin
	JsonArray allProfitProducts = profitJson.getAsJsonArray("AllProfitProducts");
	List<JsonObject> topProducts = new ArrayList<>();
	for (int i = 0; i < Math.min(5, allProfitProducts.size()); i++) {
		topProducts.add(allProfitProducts.get(i).getAsJsonObject());
	}

	// Prepare data for the chart
	StringBuilder productNames = new StringBuilder("[");
	StringBuilder profitMargins = new StringBuilder("[");

	// Populate top 5 product data
	for (int i = 0; i < topProducts.size(); i++) {
		JsonObject product = topProducts.get(i);
		productNames.append("'").append(product.get("ProductName").getAsString()).append("'");
		profitMargins.append(product.get("ProfitMargin").getAsDouble());
		if (i < topProducts.size() - 1) {
			productNames.append(", ");
			profitMargins.append(", ");
		}
	}

	productNames.append("]");
	profitMargins.append("]");

	// Set these values as request attributes for dynamic rendering
	request.setAttribute("productNames", productNames.toString());
	request.setAttribute("profitMargins", profitMargins.toString());
	%>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 sidebar d-flex flex-column p-3">
                <h4 class="text-center mb-4">Admin Panel</h4>
                <ul class="nav flex-column">
                    <li class="nav-item"><a class="nav-link active" href="Admin_Dashboard"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="UserManagement.jsp"><i class="bi bi-people me-2"></i>User Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="product_management.jsp"><i class="bi bi-box-seam me-2"></i>Product Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="algorithm_monitoring.jsp"><i class="bi bi-cpu me-2"></i>Algorithm Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="FeedbackServlet"><i class="bi bi-chat-dots me-2"></i>Feedback Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="Report_Generation"><i class="bi bi-file-earmark-text me-2"></i>Report Management</a></li>
                </ul>
            </nav>
            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Dashboard</h1>
                    <button type="button" class="btn btn-outline-danger" onclick="window.location.href='login.jsp'">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </button>
                </div>

                <!-- Cards Section -->
                <div class="cards-container d-flex justify-content-between mb-4">
                    <div class="info-card total-revenue">
                        <i class="bx bx-dollar-circle bx-lg"></i>
                        <h3>Total Revenue</h3>
                        <p>$<%=request.getAttribute("totalRevenue")%></p>
                    </div>
                    <div class="info-card total-users">
                        <i class="bx bx-user bx-lg"></i>
                        <h3>Total Users</h3>
                        <p><%=request.getAttribute("totalUsers")%></p>
                    </div>
                    <div class="info-card total-products">
                        <i class="bx bx-box bx-lg"></i>
                        <h3>Total Products</h3>
                        <p><%=request.getAttribute("totalProducts")%></p>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="row">
                    <div class="col-12 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Monthly Sales Trend</h5>
                                <canvas id="salesTrendChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">ABC Classification</h5>
                                <canvas id="abcChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <!-- ABC Classification Table -->
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">ABC Classification Details</h5>
                                <div class="mb-3">
                                    <select id="classFilter" class="form-select">
                                        <option value="">All Classes</option>
                                        <%
                                        // Fetching the "abc" data from request attributes
                                        String jsonData2 = (String) request.getAttribute("abc_classificationData");
                                        List<Map<String, String>> resultList = null;

                                        if (request.getAttribute("abc") != null) {
                                            jsonData2 = (String) request.getAttribute("abc");
                                        }

                                        if (jsonData2 != null && !jsonData2.isEmpty()) {
                                            Gson gson2 = new Gson();

                                            // Parse JSON data into a list of maps
                                            if (jsonData2.startsWith("{")) {
                                                Map<String, String> singleResult = gson2.fromJson(jsonData2, Map.class);
                                                resultList = new ArrayList<>();
                                                resultList.add(singleResult);
                                            } else {
                                                resultList = gson2.fromJson(jsonData2, new TypeToken<List<Map<String, String>>>() {}.getType());
                                            }

                                            // Extract unique classes
                                            Set<String> uniqueClasses = resultList.stream().map(row -> row.get("class")).collect(Collectors.toSet());
                                            for (String className : uniqueClasses) {
                                        %>
                                        <option value="<%=className%>">Class <%=className%></option>
                                        <%
                                            }
                                        }
                                        %>
                                    </select>
                                </div>
                                <div class="table-container">
                                    <table id="dataTable" class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <%
                                                if (resultList != null && !resultList.isEmpty()) {
                                                    // Dynamically create table headers
                                                    Set<String> keys = resultList.get(0).keySet();
                                                    for (String key : keys) {
                                                %>
                                                <th><%=key%></th>
                                                <%
                                                    }
                                                }
                                                %>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                            if (resultList != null && !resultList.isEmpty()) {
                                                // Populate table rows with data
                                                for (Map<String, String> row : resultList) {
                                            %>
                                            <tr data-class="<%=row.get("class")%>">
                                                <%
                                                for (String key : row.keySet()) {
                                                    Object value = row.get(key);
                                                %>
                                                <td><%=value != null ? value.toString() : ""%></td>
                                                <%
                                                }
                                                %>
                                            </tr>
                                            <%
                                                }
                                            } else {
                                            %>
                                            <tr>
                                                <td colspan="100%">No data available to display.</td>
                                            </tr>
                                            <%
                                            }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Demand Forecast</h5>
                                <canvas id="demandForecastChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Inventory Turnover Ratio</h5>
                                <canvas id="turnoverChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 mb-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Product Profit Comparison</h5>
                                <canvas id="profitChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Sales Trend Chart
	const salesTrendCtx = document.getElementById("salesTrendChart").getContext("2d")
	new Chart(salesTrendCtx, {
	    type: 'line',
	    data: {
	        labels: <%=salesTrendLabels.toString()%>,
	        datasets: [{
	            label: 'Percentage Change',
	            data: <%=salesTrendData.toString()%>,
	            borderColor: 'rgba(75, 192, 192, 1)',
	            backgroundColor: 'rgba(75, 192, 192, 0.2)',
	            fill: true,
	            tension: 0.1
	        }]
	    },
	    options: {
	        responsive: true,
	        plugins: {
	            legend: { position: 'top' },
	            tooltip: {
	                callbacks: {
	                    label: (context) => {
	                        let label = context.dataset.label || '';
	                        if (label) {
	                            label += ': ';
	                        }
	                        if (context.parsed.y !== null) {
	                            label += context.parsed.y + '%';
	                        }
	                        return label;
	                    }
	                }
	            }
	        },
	        scales: {
	            y: { beginAtZero: true }
	        }
	    }
	});

	// ABC Classification Chart
	const abcCtx = document.getElementById("abcChart").getContext("2d")
	new Chart(abcCtx, {
	    type: 'pie',
	    data: {
	        labels: <%=abcLabels.toString()%>,
	        datasets: [{
	            data: <%=abcDataPoints.toString()%>,
	            backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
	            hoverOffset: 4
	        }]
	    },
	    options: {
	        responsive: true,
	        plugins: {
	            legend: { position: 'top' },
	        }
	    }
	});

	// Demand Forecast Chart
	const demandForecastCtx = document.getElementById("demandForecastChart").getContext("2d")
	new Chart(demandForecastCtx, {
	    type: 'bar',
	    data: {
	        labels: <%=demandForecastLabels.toString()%>,
	        datasets: [{
	            label: 'Predicted Demand',
	            data: <%=demandForecastDataPoints.toString()%>,
	            backgroundColor: [
	                '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'
	            ],
	            borderColor: [
	                '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF', '#FF9F40'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        responsive: true,
	        scales: {
	            y: { beginAtZero: true }
	        }
	    }
	});

	// Inventory Turnover Ratio Chart
	const turnoverCtx = document.getElementById("turnoverChart").getContext("2d")
	new Chart(turnoverCtx, {
	    type: 'line',
	    data: {
	        labels: <%=turnoverYears.toString()%>,
	        datasets: [{
	            label: 'Turnover Ratio',
	            data: <%=turnoverRatios.toString()%>,
	            fill: false,
	            borderColor: '#4BC0C0',
	            tension: 0.1
	        }]
	    },
	    options: {
	        responsive: true,
	        plugins: {
	            legend: { position: 'top' },
	        },
	        scales: {
	            y: { beginAtZero: true }
	        }
	    }
	});

	// Product Profit Comparison Chart
	const profitCtx = document.getElementById("profitChart").getContext("2d")
	new Chart(profitCtx, {
	    type: 'bar',
	    data: {
	        labels: <%=productNames%>,
	        datasets: [{
	            label: 'Profit Margin (%)',
	            data: <%=profitMargins%>,
	            backgroundColor: [
	                '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF'
	            ],
	            borderColor: [
	                '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF'
	            ],
	            borderWidth: 1
	        }]
	    },
	    options: {
	        responsive: true,
	        plugins: {
	            legend: { position: 'top' },
	        },
	        scales: {
	            y: { beginAtZero: true }
	        }
	    }
	});


        document.addEventListener('DOMContentLoaded', function() {
            const classFilter = document.getElementById('classFilter');
            const rows = document.querySelectorAll('#dataTable tbody tr');

            classFilter.addEventListener('change', function() {
                const selectedClass = this.value;

                rows.forEach(row => {
                    if (selectedClass === '' || row.getAttribute('data-class') === selectedClass) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>