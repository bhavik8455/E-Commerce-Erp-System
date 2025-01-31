<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.admin.*"%>
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

.btn-logout {
	background-color: #e74c3c;
	border-color: #c0392b;
}

.btn-logout:hover {
	background-color: #c0392b;
}

.sticky-top {
	position: sticky;
	top: 0;
	z-index: 1;
	background-color: #212529;
}

.table-responsive::-webkit-scrollbar {
	width: 8px;
	height: 8px;
}

.table-responsive::-webkit-scrollbar-track {
	background: #f1f1f1;
	border-radius: 4px;
}

.table-responsive::-webkit-scrollbar-thumb {
	background: #888;
	border-radius: 4px;
}

.table-responsive::-webkit-scrollbar-thumb:hover {
	background: #555;
}

.product-list-panel {
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 0.25rem;
}

.table th {
	white-space: nowrap;
}

.modal-dialog {
	max-width: 600px;
}
</style>
</head>
<body>
	<!-- Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>

	<!-- Custom JavaScript for Product Management -->
	<script>
    // Function to handle edit product
    function editProduct(id, name, category, cost, sellingPrice, stock, reorderLevel, supplierInfo, expiryDate) {
        // Set values in the edit form
        document.getElementById('editId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editCategory').value = category;
        document.getElementById('editCost').value = cost;
        document.getElementById('editSellingPrice').value = sellingPrice;
        document.getElementById('editStock').value = stock;
        document.getElementById('editReorderLevel').value = reorderLevel;
        document.getElementById('editSupplierInfo').value = supplierInfo;
        document.getElementById('editExpiryDate').value = expiryDate;
        
        // Show the modal
        var editModal = new bootstrap.Modal(document.getElementById('editProductModal'));
        editModal.show();
    }

    // Initialize all modals
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize Bootstrap modals
        var modals = document.querySelectorAll('.modal');
        modals.forEach(function(modal) {
            new bootstrap.Modal(modal);
        });
    });
</script>
	<div class="container-fluid">
		<div class="row">
			<!-- Sidebar -->
			<nav class="col-md-3 col-lg-2 sidebar d-flex flex-column p-3">
				<h4 class="text-center mb-4">Admin Panel</h4>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link"
						href="Admin_Dashboard"> <i class="bi bi-speedometer2 me-2"></i>Dashboard
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="UserManagement.jsp"> <i class="bi bi-people me-2"></i>User
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="product_management.jsp"> <i class="bi bi-box-seam me-2"></i>Product
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="algorithm_monitoring.jsp"> <i class="bi bi-cpu me-2"></i>Algorithm
							Management
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="FeedbackServlet"> <i
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
					<h6 class="mb-0">Welcome, Admin</h6>
					<button type="button" class="btn ms-1 btn btn-outline-danger" onclick="window.location.href='login.jsp'">
    <i class="bi bi-box-arrow-right"></i> Logout
</button>
				</div>

				<!-- Dynamic Content -->
				<div class="main-content">
					<!-- Product Management Section -->
					<div class="container mt-1">
						<div class="card shadow">
							<div class="card-body">
								<h3 class="card-title">Product Management</h3>
								<p class="card-text">Manage products, add new products, and
									edit product details.</p>

								<!-- Add New Product Button -->
								<button type="button" class="btn btn-primary mb-2"
									data-bs-toggle="modal" data-bs-target="#addProductModal">
									Add New Product</button>

								<!-- Form to submit action to "list" -->
								<form action="ProductController" method="GET" class="mb-3">
									<input type="hidden" name="action" value="list">
									<button type="submit" class="btn btn-success">List All
										Products</button>
								</form>

								<!-- Product List Panel -->
								<div class="product-list-panel">
									<div class="table-responsive"
										style="max-height: 500px; overflow-y: auto;">
										<%
                          Product_Pojo pojo = new Product_Pojo();
                          @SuppressWarnings("unchecked")
                          List<Product_Pojo> productList = (List<Product_Pojo>) request.getAttribute("productList");
                      %>
										<table class="table table-bordered table-hover mb-0">
											<thead class="table-dark sticky-top">
												<tr>
													<th>ID</th>
													<th>Name</th>
													<th>Category</th>
													<th>Cost</th>
													<th>Selling Price</th>
													<th>Stock</th>
													<th>SupplierInfo</th>
													<th>Actions</th>
												</tr>
											</thead>
											<tbody>
												<% if (productList != null && !productList.isEmpty()) { %>
												<% for (Product_Pojo product : productList) { %>
												<tr>
													<td><%= product.getId() %></td>
													<td><%= product.getP_Name() %></td>
													<td><%= product.getP_Category() %></td>
													<td><%= product.getP_Cost() %></td>
													<td><%= product.getP_SellingPrice() %></td>
													<td><%= product.getP_Stock() %></td>
													<td><%= product.getP_SupplierInfo() %></td>
													<td>
														<button class="btn btn-sm btn-primary"
															onclick="editProduct(<%= product.getId() %>, '<%= product.getP_Name() %>', '<%= product.getP_Category() %>', <%= product.getP_Cost() %>, <%= product.getP_SellingPrice() %>, <%= product.getP_Stock() %>, <%= product.getP_ReorderLevel() %>, '<%= product.getP_SupplierInfo() %>', '<%= product.getP_ExpiryDate() %>')">Edit</button>
														<a
														href="ProductController?action=delete&id=<%= product.getId() %>"
														class="btn btn-sm btn-danger"
														onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
													</td>
												</tr>
												<% } %>
												<% } else { %>
												<tr>
													<td colspan="7" class="text-center">No products
														available</td>
												</tr>
												<% } %>
											</tbody>
										</table>
									</div>
								</div>

								<!-- Add Product Modal -->
								<div class="modal fade" id="addProductModal" tabindex="-1"
									aria-labelledby="addProductModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="addProductModalLabel">Add
													New Product</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<form action="ProductController" method="POST"
													id="addProductForm">
													<input type="hidden" name="action" value="add">
													<div class="mb-3">
														<label for="name" class="form-label">Product Name</label>
														<input type="text" class="form-control" id="name"
															name="name" required>
													</div>
													<div class="mb-3">
														<label for="category" class="form-label">Category</label>
														<input type="text" class="form-control" id="category"
															name="category" required>
													</div>
													<div class="mb-3">
														<label for="cost" class="form-label">Cost</label> <input
															type="number" class="form-control" id="cost" name="cost"
															required>
													</div>
													<div class="mb-3">
														<label for="sellingPrice" class="form-label">Selling
															Price</label> <input type="number" class="form-control"
															id="sellingPrice" name="sellingPrice" required>
													</div>
													<div class="mb-3">
														<label for="stock" class="form-label">Stock</label> <input
															type="number" class="form-control" id="stock"
															name="stock" required>
													</div>
													<div class="mb-3">
														<label for="reorderLevel" class="form-label">Reorder
															Level</label> <input type="number" class="form-control"
															id="reorderLevel" name="reorderLevel" required>
													</div>
													<div class="mb-3">
														<label for="supplierInfo" class="form-label">Supplier
															Info</label> <input type="text" class="form-control"
															id="supplierInfo" name="supplierInfo" required>
													</div>
													<div class="mb-3">
														<label for="expiryDate" class="form-label">Expiry
															Date</label> <input type="date" class="form-control"
															id="expiryDate" name="expiryDate" required>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-secondary"
															data-bs-dismiss="modal">Close</button>
														<button type="submit" class="btn btn-primary">Add
															Product</button>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>

								<!-- Edit Product Modal -->
								<div class="modal fade" id="editProductModal" tabindex="-1"
									aria-labelledby="editProductModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="editProductModalLabel">Edit
													Product</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<form action="ProductController" method="POST"
													id="editProductForm">
													<input type="hidden" name="action" value="update">
													<input type="hidden" name="id" id="editId">
													<div class="mb-3">
														<label for="editName" class="form-label">Product
															Name</label> <input type="text" class="form-control"
															id="editName" name="name" required>
													</div>
													<div class="mb-3">
														<label for="editCategory" class="form-label">Category</label>
														<input type="text" class="form-control" id="editCategory"
															name="category" required>
													</div>
													<div class="mb-3">
														<label for="editCost" class="form-label">Cost</label> <input
															type="number" class="form-control" id="editCost"
															name="cost" required>
													</div>
													<div class="mb-3">
														<label for="editSellingPrice" class="form-label">Selling
															Price</label> <input type="number" class="form-control"
															id="editSellingPrice" name="sellingPrice" required>
													</div>
													<div class="mb-3">
														<label for="editStock" class="form-label">Stock</label> <input
															type="number" class="form-control" id="editStock"
															name="stock" required>
													</div>
													<div class="mb-3">
														<label for="editReorderLevel" class="form-label">Reorder
															Level</label> <input type="number" class="form-control"
															id="editReorderLevel" name="reorderLevel" required>
													</div>
													<div class="mb-3">
														<label for="editSupplierInfo" class="form-label">Supplier
															Info</label> <input type="text" class="form-control"
															id="editSupplierInfo" name="supplierInfo" required>
													</div>
													<div class="mb-3">
														<label for="editExpiryDate" class="form-label">Expiry
															Date</label> <input type="date" class="form-control"
															id="editExpiryDate" name="expiryDate" required>
													</div>
													<div class="modal-footer">
														<button type="button" class="btn btn-secondary"
															data-bs-dismiss="modal">Close</button>
														<button type="submit" class="btn btn-primary">Update
															Product</button>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>