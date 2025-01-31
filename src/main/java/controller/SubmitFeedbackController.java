package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.FeedbackPojo;
import operations.feedback.Feedback_Implementation;
import operations.feedback.Feedback_Interface;
@WebServlet("/SubmitFeedback")
public class SubmitFeedbackController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Feedback_Interface feedbackInterface = new Feedback_Implementation();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("CustomerID");
        
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int productId = Integer.parseInt(request.getParameter("productId"));
        String comments = request.getParameter("comments");
        int rating = Integer.parseInt(request.getParameter("rating"));
        
        FeedbackPojo feedback = new FeedbackPojo();
        feedback.setProductId(productId);
        feedback.setCustomerId(customerId);
        feedback.setComments(comments);
        feedback.setRatings(rating);
        
        boolean success = feedbackInterface.submitFeedback(feedback);
        
        if (success) {
            response.sendRedirect("Feedback?message=success");
        } else {
            response.sendRedirect("Feedback?error=true");
        }
    }
}