<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.FeedbackPojo" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Feedbacks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(to bottom right, #e9ecef, #dee2e6);
            font-family: 'Roboto', sans-serif;
        }
        .custom-navbar {
            background: linear-gradient(to right, #4b134f, #2e1a36);
            color: white;
        }
        .custom-navbar .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
        .feedback-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 15px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .feedback-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .feedback-header h2 {
            background: linear-gradient(to right, #4b134f, #2e1a36);
            color: white;
            padding: 10px;
            border-radius: 5px;
        }
        .feedback-card {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            margin-bottom: 20px;
            transition: all 0.3s;
        }
        .feedback-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
        }
        .star-rating {
            color: #ffc107;
            margin-top: 5px;
        }
        .timestamp, .customer-info {
            font-size: 0.85rem;
            color: #6c757d;
        }
        .feedback-card .product-details, .feedback-card .customer-details {
            margin-bottom: 15px;
        }
        .feedback-empty {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            margin-top: 30px;
        }
        .btn-secondary {
            background: linear-gradient(to right, #6c757d, #495057);
            color: white;
            border: none;
        }
        .btn-secondary:hover {
            background: linear-gradient(to right, #5a6268, #343a40);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="https://cdn3d.iconscout.com/3d/premium/thumb/e-commerce-website-3d-icon-download-in-png-blend-fbx-gltf-file-formats--online-search-product-shopping-site-pack-icons-5966600.png?f=webp" class="rounded-circle" alt="" height="40" width="40"/>
                 <span>Purple Store</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="HomePage">Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container feedback-container">
        <div class="feedback-header">
            <h2>Your Feedbacks</h2>
        </div>
        
        <% if(request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <%
        List<FeedbackPojo> feedbacks = (List<FeedbackPojo>) request.getAttribute("feedbacks");
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy HH:mm");
        
        if(feedbacks != null && !feedbacks.isEmpty()) {
            for(FeedbackPojo feedback : feedbacks) {
        %>
            <div class="feedback-card p-3">
                <div class="product-details mb-2">
                    <h5><%= feedback.getProduct().getP_Name() %></h5>
                    <p class="text-muted">Category: <%= feedback.getProduct().getP_Category() %></p>
                </div>
                <div class="ratings-details d-flex justify-content-between align-items-center">
                    <div class="star-rating">
                        <% for(int i = 0; i < feedback.getRatings(); i++) { %>
                            <i class="bi bi-star-fill"></i>
                        <% } %>
                        <% for(int i = feedback.getRatings(); i < 5; i++) { %>
                            <i class="bi bi-star"></i>
                        <% } %>
                    </div>
                    <div class="timestamp">
                        <i class="bi bi-clock me-1"></i>
                        <%= dateFormat.format(feedback.getTimestamp()) %>
                    </div>
                </div>
                <p class="mt-3"><%= feedback.getComments() %></p>
                
                <!-- Edit and Delete Buttons -->
                <div class="text-end">
                    <button type="button" class="btn btn-primary btn-sm me-2" data-bs-toggle="modal" data-bs-target="#editFeedbackModal" 
                            onclick="setEditFormData('<%= feedback.getFeedbackId() %>', '<%= feedback.getComments() %>', '<%= feedback.getRatings() %>')">
                        <i class="bi bi-pencil"></i> Edit
                    </button>
                    <form action="ViewFeedbacks" method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this feedback?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="feedbackId" value="<%= feedback.getFeedbackId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">
                            <i class="bi bi-trash"></i> Delete
                        </button>
                    </form>
                </div>
            </div>
        <%
            }
        } else {
        %>
            <div class="feedback-empty">
                <i class="bi bi-info-circle me-2"></i>
                No feedbacks available yet. Share your thoughts with us!
            </div>
        <%
        }
        %>
        
        <div class="text-center mt-4">
            <a href="HomePage" class="btn btn-secondary">
                <i class="bi bi-arrow-left me-2"></i>Back to Home
            </a>
        </div>
    </div>

    <!-- Edit Feedback Modal -->
    <div class="modal fade" id="editFeedbackModal" tabindex="-1" aria-labelledby="editFeedbackModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editFeedbackModalLabel">Edit Feedback</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="ViewFeedbacks" method="POST">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="feedbackId" id="editFeedbackId">
                        <div class="mb-3">
                            <label for="editComments" class="form-label">Comments</label>
                            <textarea class="form-control" id="editComments" name="comments" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="editRatings" class="form-label">Ratings</label>
                            <select class="form-control" id="editRatings" name="ratings" required>
                                <option value="1">1 Star</option>
                                <option value="2">2 Stars</option>
                                <option value="3">3 Stars</option>
                                <option value="4">4 Stars</option>
                                <option value="5">5 Stars</option>
                            </select>
                        </div>
                        <div class="text-end">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Function to populate the edit form with feedback data
        function setEditFormData(feedbackId, comments, ratings) {
            document.getElementById('editFeedbackId').value = feedbackId;
            document.getElementById('editComments').value = comments;
            document.getElementById('editRatings').value = ratings;
        }
    </script>
</body>
</html>