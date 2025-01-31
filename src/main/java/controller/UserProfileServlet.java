package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CustomerPojo;
import operations.regularuser.RegularUserInterface;
import operations.regularuser.RegularUserImplementation;
@WebServlet("/UserProfile")
public class UserProfileServlet extends HttpServlet {
    private final RegularUserInterface userService = new RegularUserImplementation();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("CustomerID");
        
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        CustomerPojo customer = userService.getCustomerById(customerId);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("CustomerID");
        
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        boolean updated = userService.updateCustomerDetails(customerId, name, email, phone, address);
        
        if (updated) {
            request.setAttribute("message", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }
        
        CustomerPojo customer = userService.getCustomerById(customerId);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }
}