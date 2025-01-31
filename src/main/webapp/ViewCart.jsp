<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purple Store | Your Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-purple: #702963;
            --light-purple: #e6ccf7;
            --dark-purple: #2e1a36;
            --hover-purple: #5a1f5f;
            --bg-gradient: linear-gradient(135deg, var(--dark-purple), var(--primary-purple));
        }

        body {
            background: var(--bg-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: #fff;
        }

        .navbar {
            background: rgba(46, 26, 54, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: white !important;
            font-weight: 600;
        }

        .navbar-brand img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 2px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease;
        }

        .navbar-brand:hover img {
            transform: scale(1.1);
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .card-title {
            color: var(--primary-purple);
            font-weight: 700;
            font-size: 1.75rem;
        }

        .table {
            color: #333;
            margin-bottom: 0;
        }

        .table thead th {
            background: rgba(112, 41, 99, 0.1);
            color: var(--primary-purple);
            font-weight: 600;
            border: none;
            padding: 1rem;
        }

        .table td {
            padding: 1rem;
            vertical-align: middle;
            border-color: rgba(112, 41, 99, 0.1);
        }

        .product-name {
            color: var(--primary-purple);
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .product-category {
            color: #666;
            font-size: 0.875rem;
        }

        .btn-purple {
            background-color: var(--primary-purple);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-purple:hover {
            background-color: var(--hover-purple);
            color: white;
            transform: translateY(-2px);
        }

        .btn-outline-purple {
            color: var(--primary-purple);
            border: 2px solid var(--primary-purple);
            background: transparent;
            padding: 0.5rem 1.25rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-outline-purple:hover {
            background-color: var(--primary-purple);
            color: white;
            transform: translateY(-2px);
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background-color: #bb2d3b;
            transform: translateY(-2px);
        }

        .empty-cart {
            padding: 3rem 0;
            text-align: center;
        }

        .empty-cart i {
            font-size: 4rem;
            color: var(--primary-purple);
            margin-bottom: 1rem;
        }

        .empty-cart p {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }

        .form-select {
            border: 2px solid var(--primary-purple);
            border-radius: 8px;
            padding: 0.5rem 2.25rem 0.5rem 1rem;
            background-color: white;
            color: var(--primary-purple);
            font-weight: 500;
        }

        .form-select:focus {
            border-color: var(--hover-purple);
            box-shadow: 0 0 0 0.25rem rgba(112, 41, 99, 0.25);
        }

        .total-row {
            background-color: rgba(112, 41, 99, 0.1);
            font-weight: 700;
        }

        .total-row td {
            color: var(--primary-purple);
        }

        .alert {
            border: none;
            border-radius: 8px;
        }

        .alert-danger {
            background-color: #fde8e8;
            color: #dc3545;
        }

        .checkout-section {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            padding: 1.5rem;
            margin-top: 1.5rem;
        }

        @media (max-width: 768px) {
            .table-responsive {
                border-radius: 8px;
            }
            
            .checkout-section {
                flex-direction: column;
                gap: 1rem;
            }
            
            .form-select {
                width: 100% !important;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="HomePage">
                <img src="https://cdn3d.iconscout.com/3d/premium/thumb/e-commerce-website-3d-icon-download-in-png-blend-fbx-gltf-file-formats--online-search-product-shopping-site-pack-icons-5966600.png?f=webp" alt="Logo">
                <span>Purple Store</span>
            </a>
        </div>
    </nav>

    <div class="container py-5">
        <div class="card">
            <div class="card-body p-4">
                <h2 class="card-title mb-4">Shopping Cart</h2>
                
                <%-- Error Messages --%>
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                        <% if(request.getParameter("error").equals("processingError")) { %>
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            Failed to process payment. Please try again.
                        <% } else if(request.getParameter("error").equals("emptyCart")) { %>
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            Your cart is empty. Please add items before checkout.
                        <% } %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if(cart == null || cart.isEmpty()) {
                %>
                    <div class="empty-cart">
                        <i class="bi bi-cart-x"></i>
                        <p>Your shopping cart is empty</p>
                        <a href="HomePage" class="btn btn-purple">
                            <i class="bi bi-arrow-left me-2"></i>Continue Shopping
                        </a>
                    </div>
                <%
                } else {
                %>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                double total = 0;
                                for(CartItem item : cart) {
                                    total += item.getSubtotal();
                                %>
                                    <tr>
                                        <td>
                                            <div class="product-name"><%= item.getProduct().getP_Name() %></div>
                                            <div class="product-category"><%= item.getProduct().getP_Category() %></div>
                                        </td>
                                        <td>$<%= String.format("%.2f", item.getProduct().getP_SellingPrice()) %></td>
                                        <td><%= item.getQuantity() %></td>
                                        <td>$<%= String.format("%.2f", item.getSubtotal()) %></td>
                                        <td>
                                            <form action="RemoveFromCart" method="POST" style="display: inline;">
                                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                                <button type="submit" class="btn btn-danger btn-sm" 
                                                        onclick="return confirm('Are you sure you want to remove this item?')">
                                                    <i class="bi bi-trash me-1"></i>Remove
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                <%
                                }
                                %>
                                <tr class="total-row">
                                    <td colspan="3" class="text-end">Total:</td>
                                    <td colspan="2">$<%= String.format("%.2f", total) %></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <a href="HomePage" class="btn btn-outline-purple">
                            <i class="bi bi-arrow-left me-2"></i>Continue Shopping
                        </a>
                        
                        <form action="ProcessSale" method="POST" class="d-flex gap-3 align-items-center">
                            <select name="paymentMethod" class="form-select" style="width: auto;" required>
                                <option value="">Select Payment Method</option>
                                <option value="Cash">Cash</option>
                                <option value="GPay">GPay</option>
                            </select>
                            
                            <button type="submit" class="btn btn-purple">
                                <i class="bi bi-credit-card me-2"></i>Pay Now
                            </button>
                        </form>
                    </div>
                <%
                }
                %>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>