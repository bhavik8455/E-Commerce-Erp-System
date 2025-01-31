package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItem;

@WebServlet("/RemoveFromCart")
public class RemoveFromCartController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get productId to remove
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        // Get current cart
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart != null) {
            // Remove item with matching productId
            cart.removeIf(item -> item.getProduct().getId() == productId);
            
            // Update cart in session
            session.setAttribute("cart", cart);
            session.setAttribute("cartCount", cart.size());
        }
        
        // Redirect back to cart page
        response.sendRedirect("ViewCart");
    }
}
