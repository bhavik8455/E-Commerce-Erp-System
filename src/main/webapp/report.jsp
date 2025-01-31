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
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.31/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
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
.chart-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.chart-container label {
    margin-bottom: 10px;
    font-weight: bold;
    color: #333;
}

.chart-container select {
    width: 100%;
    max-width: 300px;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    appearance: none;
    background-color: white;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath d='M1 4l5 5 5-5z' fill='%23999'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
}

.chart-container select:focus {
    outline: none;
    border-color: #48207d;
    box-shadow: 0 0 5px rgba(72, 32, 125, 0.3);
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
                <div class="main-content" id="main-content">
          
                    <div class="chart-container">
                     <label for="algorithmSelect">Select Algorithm:</label>
                     <select id="algorithmSelect">
                         <option value="">-- Select --</option>
                         <option value="abc">ABC Classification</option>
                         <option value="salesTrend">Sales Trend Analysis</option>
                         <option value="turnover">Inventory Turnover Ratio</option>
                         <option value="productProfitability">Product Profitability</option>
                         <option value="demandForecast">Demand Forecast</option>
                     </select><br><br>
         
                     <label for="formatSelect">Select Format:</label>
                     <select id="formatSelect">
                         <option value="">-- Select --</option>
                         <option value="excel">Excel</option>
                         <option value="pdf">PDF</option>
                     </select><br><br>
         
                     <button onclick="generateReport()" style="color:white">Generate Report</button>
                     </div>
                     
                   </div>
			</div>
		</div>
	</div>
</body>
<script>
    function jsonToExcel(jsonArray, filename = "data.xlsx") {
        if (!jsonArray || jsonArray.length === 0) return;
        try {
            const worksheet = XLSX.utils.json_to_sheet(jsonArray);
            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, "Sheet1");
            XLSX.writeFile(workbook, filename);
        } catch (error) {
            console.error("Excel Error:", error);
            alert("Error generating Excel. Check the console.");
        }
    }

    function jsonToPDFMake(jsonArray, algorithm, filename = "data.pdf") {
        if (!jsonArray || jsonArray.length === 0) return;

        try {
            const colors = {
                secondary: '#3498DB',
                background: '#F4F6F7'
            };

            let tableBody = [];
            let contentHeader = "Data Report";
            let tableHeaders = [];

            switch (algorithm) {
                case "abc":
                    contentHeader = "ABC Classification Report";
                    tableHeaders = ["Category", "Item", "Value"];
                    tableBody = [
                        tableHeaders,
                        ...jsonArray.map(obj => [obj.category, obj.item, obj.value])
                    ];
                    break;

                case "salesTrend":
                    contentHeader = "Sales Trend Report";
                    tableHeaders = ["Month", "Sales"];
                    tableBody = [
                        tableHeaders,
                        ...jsonArray.map(obj => [obj.month, obj.sales])
                    ];
                    break;

                case "turnover":
                    contentHeader = "Inventory Turnover Ratio Report";
                    tableHeaders = ["Item", "Turnover Ratio"];
                    tableBody = [
                        tableHeaders,
                        ...jsonArray.map(obj => [obj.item, obj.turnoverRatio.toFixed(2)])
                    ];
                    break;

                case "productProfitability":
                    contentHeader = "Product Profitability Report";
                    tableHeaders = ["Product ID", "Product Name", "Profit ($)", "Profit Margin (%)"];
                    tableBody = [
                        tableHeaders,
                        ...jsonArray.map(obj => [
                            obj.ProductID,
                            obj.ProductName,
                            obj.Profit.toFixed(2),
                            obj.ProfitMargin.toFixed(2)
                        ])
                    ];
                    break;

                case "demandForecast":
                    contentHeader = "Demand Forecast Report";
                    tableHeaders = ["Product", "Forecasted Demand"];
                    tableBody = [
                        tableHeaders,
                        ...jsonArray.map(obj => [obj.product, obj.forecastedDemand])
                    ];
                    break;

                default:
                    tableHeaders = Object.keys(jsonArray[0]);
                    tableBody = [
                        tableHeaders,
                        ...jsonArray.map(obj => Object.values(obj))
                    ];
            }

            const documentDefinition = {
                content: [
                    { 
                        text: contentHeader, 
                        style: 'header',
                        alignment: 'center',
                        margin: [0, 0, 0, 10]
                    },
                    {
                        table: { 
                            headerRows: 1,
                            widths: '*',
                            body: tableBody
                        },
                        layout: {
                            fillColor: (rowIndex) => {
                                return rowIndex === 0 ? colors.secondary : 
                                       (rowIndex % 2 === 0 ? colors.background : 'white');
                            }
                        },
                        alignment: 'center'
                    }
                ],
                styles: {
                    header: {
                        fontSize: 22,
                        bold: true
                    }
                }
            };

            pdfMake.createPdf(documentDefinition).download(filename);
        } catch (error) {
            console.error("pdfMake Error:", error);
            alert("Error generating PDF. Check the console.");
        }
    }
    function generateReport() {
        const algorithm = document.getElementById("algorithmSelect").value;
        const format = document.getElementById("formatSelect").value;
        const allData = {
            abc: <%= request.getAttribute("abc_classificationData") %>,
            salesTrend: <%= request.getAttribute("salesTrendData") %>,
            turnover: <%= request.getAttribute("inventoryratio") %>,
            productProfitability: <%= request.getAttribute("profitability") %>,
            demandForecast: <%= request.getAttribute("demandForecast") %>
        };

        let dataToUse;
        let filenameBase;

        switch (algorithm) {
            case "abc": dataToUse = allData.abc; filenameBase = "abc"; break;
            case "salesTrend": dataToUse = allData.salesTrend; filenameBase = "sales_trend"; break;
            case "turnover": dataToUse = allData.turnover; filenameBase = "turnover"; break;
            case "productProfitability":
                dataToUse = allData.productProfitability.AllProfitProducts || [];
                filenameBase = "product_profitability";
                break;
            case "demandForecast": dataToUse = allData.demandForecast; filenameBase = "demand_forecast"; break;
            default: alert("Please select an algorithm."); return;
        }

        if (!dataToUse || dataToUse.length === 0) {
            alert("No data available for the selected algorithm.");
            return;
        }

        switch (format) {
            case "excel": jsonToExcel(dataToUse, filenameBase + ".xlsx"); break;
            case "pdf": jsonToPDFMake(dataToUse, filenameBase + "_pdfmake.pdf"); break;
            default: alert("Please select a format."); return;
        }
    }
</script>
</html>