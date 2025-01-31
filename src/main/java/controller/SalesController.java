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
import model.SalesPojo;
import operations.sales.Sales_Interface;
import operations.sales.Sales_Implementation;
import java.util.Date;
@WebServlet("/ProcessSale")
public class SalesController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final Sales_Interface salesInterface = new Sales_Implementation();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("CustomerID");
        
        if (customerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        String paymentMethod = request.getParameter("paymentMethod");
        
        if (cart != null && !cart.isEmpty()) {
            try {
                for (CartItem item : cart) {
                    SalesPojo sale = new SalesPojo();
                    sale.setProductId(item.getProduct().getId());
                    sale.setCustomerId(customerId);
                    sale.setDate(new Date());
                    sale.setQuantity(item.getQuantity());
                    sale.setTotalAmount(item.getSubtotal());
                    sale.setPaymentMethod(paymentMethod);
                    
                    boolean success = salesInterface.processSale(sale);
                    if (!success) {
                        throw new Exception("Sale processing failed");
                    }
                }
                
                session.removeAttribute("cart");
                session.removeAttribute("cartCount");
                
                response.sendRedirect("Feedback");
                
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("ViewCart?error=processingError");
            }
        } else {
            response.sendRedirect("ViewCart?error=emptyCart");
        }
    }
}
