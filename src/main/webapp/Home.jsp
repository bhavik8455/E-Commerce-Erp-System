<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.ProductPojo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purple Store | Product Catalog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-purple: #702963;
            --light-purple: #e6ccf7;
            --dark-purple: #2e1a36;
            --hover-purple: #5a1f5f;
        }

        body {
            background: linear-gradient(135deg, var(--dark-purple), var(--primary-purple));
            min-height: 100vh;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        .navbar {
            background: rgba(46, 26, 54, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .nav-link {
            color: white !important;
            transition: color 0.3s;
        }

        .nav-link:hover {
            color: var(--light-purple) !important;
        }

        .btn-purple {
            background-color: var(--primary-purple);
            color: white;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-purple:hover {
            background-color: var(--hover-purple);
            color: white;
            transform: translateY(-2px);
        }

        .btn-outline-purple {
            color: var(--primary-purple);
            border-color: var(--primary-purple);
            background-color: white;
            transition: all 0.3s ease;
        }

        .btn-outline-purple:hover {
            background-color: var(--primary-purple);
            color: white;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .category-btn.active {
            background-color: var(--primary-purple) !important;
            color: white !important;
        }

        .cart-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: var(--primary-purple);
            color: white;
            border-radius: 50%;
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
        }

        .product-price {
            color: var(--primary-purple);
            font-size: 1.5rem;
            font-weight: bold;
        }

        .stock-badge {
            background-color: #4CAF50;
            color: white;
            padding: 0.5rem;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .out-of-stock-badge {
            background-color: #f44336;
            color: white;
            padding: 0.5rem;
            border-radius: 8px;
            font-size: 0.9rem;
        }

        .quantity-input {
            max-width: 100px;
            border: 1px solid var(--primary-purple);
            border-radius: 8px;
        }

        .add-to-cart-btn {
            background-color: var(--primary-purple);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        }

        .add-to-cart-btn:hover {
            background-color: var(--hover-purple);
            transform: translateY(-2px);
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .navbar-brand img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 2px solid rgba(255, 255, 255, 0.2);
        }

        .search-bar {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 0.5rem 1rem;
            color: white;
        }

        .search-bar::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand text-white" href="#">
                <img src="https://cdn3d.iconscout.com/3d/premium/thumb/e-commerce-website-3d-icon-download-in-png-blend-fbx-gltf-file-formats--online-search-product-shopping-site-pack-icons-5966600.png?f=webp" alt="Logo">
                <span>Purple Store</span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="Home.jsp">Home</a>
                    </li>
                </ul>

                <div class="d-flex gap-3 align-items-center">
                    <button class="btn btn-outline-light" onclick="window.location.href='ViewFeedbacks'">
                        <i class="bi bi-chat-dots"></i> Feedbacks
                    </button>

                    <button class="btn btn-outline-light position-relative" onclick="window.location.href='ViewCart'">
                        <i class="bi bi-cart3"></i>
                        <span class="cart-badge">
                            <%= session.getAttribute("cartCount") != null ? session.getAttribute("cartCount") : "0" %>
                        </span>
                    </button>

                    <button class="btn btn-outline-light" onclick="window.location.href='UserProfile'">
                        <i class="bi bi-person-circle"></i>
                    </button>

                    <button class="btn btn-outline-danger" onclick="window.location.href='login.jsp'">
                        <i class="bi bi-box-arrow-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </nav>

    <!-- Error Message -->
    <% if(request.getAttribute("errorMessage") != null) { %>
    <div class="container mt-4">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= request.getAttribute("errorMessage") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
    <% } %>

    <!-- Main Content -->
    <div class="container py-5">
        <!-- Categories -->
        <div class="card mb-4">
            <div class="card-body">
                <h4 class="card-title mb-4">Browse Categories</h4>
                <div class="d-flex flex-wrap gap-2">
                    <a href="HomePage" class="btn btn-outline-purple <%= request.getParameter("Category") == null ? "active" : "" %>">
                        All Products
                    </a>
                    <% 
                    List<String> categories = (List<String>) request.getAttribute("categories");
                    if(categories != null) {
                        for(String category : categories) {
                            String isActive = category.equals(request.getParameter("Category")) ? "active" : "";
                    %>
                    <a href="HomePage?Category=<%= category %>" class="btn btn-outline-purple <%= isActive %>">
                        <%= category %>
                    </a>
                    <% 
                        }
                    }
                    %>
                </div>
            </div>
        </div>

        <!-- Products Grid -->
        <div class="row g-4">
            <%
            List<ProductPojo> products = (List<ProductPojo>) request.getAttribute("products");
            if(products != null) {
                for(ProductPojo product : products) {
            %>
            <div class="col-12 col-md-6 col-lg-4 col-xl-3">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title mb-3"><%= product.getP_Name() %></h5>
                        <p class="text-muted mb-2">
                            <i class="bi bi-tag"></i> <%= product.getP_Category() %>
                        </p>
                        <p class="product-price mb-3">
                            $<%= String.format("%.2f", product.getP_SellingPrice()) %>
                        </p>

                        <% if(product.getP_Stock() > 0) { %>
                            <div class="stock-badge mb-3">
                                <i class="bi bi-check-circle"></i> In Stock (<%= product.getP_Stock() %> available)
                            </div>
                            <form action="AddToCart" method="POST">
                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <input type="hidden" name="currentCategory" value="<%= request.getParameter("Category") %>">
                                <div class="d-flex gap-1">
                                    <input type="number" 
                                           class="form-control quantity-input" 
                                           name="quantity" 
                                           value="1" 
                                           min="1" 
                                           max="<%= product.getP_Stock() %>"
                                           required>
                                    <button type="submit" class="btn add-to-cart-btn flex-grow-1">
                                        <i class="bi bi-cart-plus"></i> Add to Cart
                                    </button>
                                </div>
                            </form>
                        <% } else { %>
                            <div class="out-of-stock-badge mb-3">
                                <i class="bi bi-x-circle"></i> Out of Stock
                            </div>
                            <button class="btn add-to-cart-btn w-100" disabled>
                                <i class="bi bi-cart-plus"></i> Add to Cart
                            </button>
                        <% } %>
                    </div>
                </div>
            </div>
            <%
                }
            }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>