package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.FeedbackPojo;
import operations.viewfeedback.FeedbackInterface;
import operations.viewfeedback.FeedbackImplementation;

@WebServlet("/ViewFeedbacks")
public class ViewFeedbackServlet extends HttpServlet {
    private final FeedbackInterface feedbackService = new FeedbackImplementation();

    // Handle GET requests (display feedbacks)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Integer customerId = (Integer) session.getAttribute("CustomerID");

            if (customerId == null) {
                // Redirect to login if customer ID is not found in session
                response.sendRedirect("LoginPage");
                return;
            }

            List<FeedbackPojo> feedbacks = feedbackService.getFeedbacksByCustomerId(customerId);
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving feedbacks");
            request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
        }
    }

    // Handle POST requests (edit or delete feedback)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            // Handle edit feedback
            int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
            String comments = request.getParameter("comments");
            int ratings = Integer.parseInt(request.getParameter("ratings"));

            try {
                boolean isUpdated = feedbackService.updateFeedback(feedbackId, comments, ratings);
                if (isUpdated) {
                    response.sendRedirect("ViewFeedbacks");
                } else {
                    request.setAttribute("error", "Failed to update feedback");
                    request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error updating feedback");
                request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
            }
        } else if ("delete".equals(action)) {
            // Handle delete feedback
            int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));

            try {
                boolean isDeleted = feedbackService.deleteFeedback(feedbackId);
                if (isDeleted) {
                    response.sendRedirect("ViewFeedbacks");
                } else {
                    request.setAttribute("error", "Failed to delete feedback");
                    request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error deleting feedback");
                request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
            }
        }
    }
}