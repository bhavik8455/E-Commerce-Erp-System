<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="model.SalesPojo"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purple Store | Product Feedback</title>
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

        .table tbody tr:hover {
            background-color: rgba(112, 41, 99, 0.05);
            transition: all 0.3s ease;
        }

        .btn-purple {
            background-color: var(--primary-purple);
            color: white;
            border: none;
            padding: 0.5rem 1.25rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-purple:hover {
            background-color: var(--hover-purple);
            color: white;
            transform: translateY(-2px);
        }

        .modal-content {
            background: white;
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            border-bottom: 1px solid rgba(112, 41, 99, 0.1);
            padding: 1.5rem;
        }

        .modal-title {
            color: var(--primary-purple);
            font-weight: 600;
        }

        .modal-body {
            padding: 1.5rem;
            color: #333;
        }

        .modal-footer {
            border-top: 1px solid rgba(112, 41, 99, 0.1);
            padding: 1.5rem;
        }

        .form-label {
            color: var(--primary-purple);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-control {
            border: 2px solid rgba(112, 41, 99, 0.1);
            border-radius: 8px;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 0.25rem rgba(112, 41, 99, 0.25);
        }

        .star-rating {
            display: flex;
            gap: 0.5rem;
            padding: 0.5rem 0;
        }

        .star-rating i {
            color: #ffd700;
            font-size: 2rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .star-rating i:hover {
            transform: scale(1.2);
            color: #ffcd39;
        }

        .alert {
            border: none;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }

        .alert-success {
            background-color: #d1e7dd;
            color: #0f5132;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #842029;
        }

        .text-danger {
            color: #dc3545 !important;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        @media (max-width: 768px) {
            .card-body {
                padding: 1rem;
            }
            
            .table-responsive {
                margin: 0 -1rem;
            }
            
            .modal-body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="card">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="card-title">Product Feedback</h2>
                    <a href="HomePage" class="btn btn-purple">
                        <i class="bi bi-house-fill me-2"></i>Back to Home
                    </a>
                </div>

                <% if(request.getParameter("message") != null && request.getParameter("message").equals("success")) { %>
                    <div class="alert alert-success" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        Thank you for your feedback!
                    </div>
                <% } %>

                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        Failed to submit feedback. Please try again.
                    </div>
                <% } %>

                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Purchase Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            List<SalesPojo> purchases = (List<SalesPojo>) request.getAttribute("purchasedProducts");
                            if(purchases != null && !purchases.isEmpty()) {
                                for(SalesPojo sale : purchases) {
                            %>
                                <tr>
                                    <td><%= sale.getProductName() %></td>
                                    <td><%= sale.getProductCategory() %></td>
                                    <td><%= sale.getDate() %></td>
                                    <td>
                                        <button type="button" class="btn btn-purple btn-sm"
                                                onclick="openFeedbackModal(<%= sale.getProductId() %>)">
                                            <i class="bi bi-star me-1"></i>Give Feedback
                                        </button>
                                    </td>
                                </tr>
                            <%
                                }
                            } else {
                            %>
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                        No products available for feedback
                                    </td>
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

    <!-- Feedback Modal -->
    <div class="modal fade" id="feedbackModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-star-fill me-2"></i>Submit Feedback
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="SubmitFeedback" method="POST" id="feedbackForm" onsubmit="return validateFeedback()">
                    <div class="modal-body">
                        <input type="hidden" id="productId" name="productId">

                        <div class="mb-4">
                            <label class="form-label">Rating</label>
                            <div class="star-rating" id="starRating">
                                <i class="bi bi-star" data-rating="1"></i>
                                <i class="bi bi-star" data-rating="2"></i>
                                <i class="bi bi-star" data-rating="3"></i>
                                <i class="bi bi-star" data-rating="4"></i>
                                <i class="bi bi-star" data-rating="5"></i>
                            </div>
                            <input type="hidden" name="rating" id="ratingInput" required>
                            <div id="ratingError" class="text-danger d-none">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                Please select a rating
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Comments</label>
                            <textarea class="form-control" name="comments" id="commentsInput"
                                    rows="3" placeholder="Share your experience with this product..."
                                    required></textarea>
                            <div id="commentsError" class="text-danger d-none">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                Comments cannot be empty
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-purple">
                            <i class="bi bi-send me-2"></i>Submit Feedback
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openFeedbackModal(productId) {
            document.getElementById('productId').value = productId;
            // Reset form
            document.getElementById('ratingInput').value = '';
            document.getElementById('commentsInput').value = '';
            document.getElementById('ratingError').classList.add('d-none');
            document.getElementById('commentsError').classList.add('d-none');
            
            // Reset stars
            const stars = document.getElementById('starRating').getElementsByTagName('i');
            for(let i = 0; i < stars.length; i++) {
                stars[i].className = 'bi bi-star';
            }
            
            new bootstrap.Modal(document.getElementById('feedbackModal')).show();
        }

        function validateFeedback() {
            const rating = document.getElementById('ratingInput').value;
            const comments = document.getElementById('commentsInput').value.trim();
            
            const ratingError = document.getElementById('ratingError');
            const commentsError = document.getElementById('commentsError');
            
            let isValid = true;
            
            if (!rating) {
                ratingError.classList.remove('d-none');
                isValid = false;
            } else {
                ratingError.classList.add('d-none');
            }
            
            if (comments === '') {
                commentsError.classList.remove('d-none');
                isValid = false;
            } else {
                commentsError.classList.add('d-none');
            }
            
            return isValid;
        }

        document.getElementById('starRating').addEventListener('click', function(e) {
            if(e.target.matches('i')) {
                const rating = e.target.dataset.rating;
                document.getElementById('ratingInput').value = rating;
                document.getElementById('ratingError').classList.add('d-none');
                
                // Update star display
                const stars = this.getElementsByTagName('i');
                for(let i = 0; i < stars.length; i++) {
                    stars[i].className = i < rating ? 'bi bi-star-fill' : 'bi bi-star';
                }
            }
        });

        document.getElementById('starRating').addEventListener('mouseover', function(e) {
            if(e.target.matches('i')) {
                const rating = e.target.dataset.rating;
                const stars = this.getElementsByTagName('i');
                for(let i = 0; i < stars.length; i++) {
                    stars[i].className = i < rating ? 'bi bi-star-fill' : 'bi bi-star';
                }
            }
        });

        // Restore original rating on mouseout
        document.getElementById('starRating').addEventListener('mouseout', function() {
            const currentRating = document.getElementById('ratingInput').value;
            const stars = this.getElementsByTagName('i');
            for(let i = 0; i < stars.length; i++) {
                stars[i].className = i < currentRating ? 'bi bi-star-fill' : 'bi bi-star';
            }
        });
    </script>
</body>
</html>