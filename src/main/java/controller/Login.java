package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.LoginPojo;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String password = request.getParameter("pword");
        int CustomerID;

        // Validate password (should not be numbers only)
        if (password != null && password.matches("^\\d+$")) {
            request.setAttribute("error", "Password cannot contain only numbers & minimum character 6");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        LoginPojo login_pojo = new LoginPojo();
        login_pojo.setPname(request.getParameter("pname"));
        login_pojo.setPword(request.getParameter("ppass"));

        if ("Admin".equals(role)) {
            String result = login_pojo.adminuser(login_pojo);
            System.out.println(result);
            if ("Authentication Successful!".equals(result)) {
                System.out.println("i am here");
                response.sendRedirect("Admin_Dashboard");
            } else {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if ("Regular".equals(role)) {
            String result = login_pojo.loginuser(login_pojo);
            System.out.println(result);

            if ("Authentication Successful!".equals(result)) {
                CustomerID = login_pojo.getCustomerID(login_pojo.getPname());
                System.out.println("Customerid is " + CustomerID);
                
                // Store CustomerID in session
                HttpSession session = request.getSession();
                session.setAttribute("CustomerID", CustomerID);

                response.sendRedirect("Home.jsp");
            } else {
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}
