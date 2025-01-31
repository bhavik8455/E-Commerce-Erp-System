package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.SalesPojo;
import operations.feedback.Feedback_Implementation;
import operations.feedback.Feedback_Interface;
@WebServlet("/Feedback")
public class FeedbackController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Feedback_Interface feedbackInterface = new Feedback_Implementation();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("CustomerID");
        
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<SalesPojo> purchasedProducts = feedbackInterface.getPurchasedProducts(customerId);
        request.setAttribute("purchasedProducts", purchasedProducts);
        
        request.getRequestDispatcher("RegFeedback.jsp").forward(request, response);
    }
}