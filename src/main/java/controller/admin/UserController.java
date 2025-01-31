package controller.admin;



import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.admin.*;
import operations.adminuser.*;
@WebServlet("/UserManagement")
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    User_Management_Interface userManagement = new User_Management_Implementation();

    public UserController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<UserPojo> userList = userManagement.getUserDetails();
        request.setAttribute("userList", userList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/UserManagement.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String mailID = request.getParameter("mailID");

        if ("activate".equals(action)) {
            userManagement.activateUser(mailID);
        } else if ("deactivate".equals(action)) {
            userManagement.deactivateUser(mailID);
        } else if ("edit".equals(action)) {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String name = request.getParameter("name");
            String role = request.getParameter("role");

            UserPojo user = new UserPojo();
            user.setUserID(userID);
            user.setName(name);
            user.setMailID(mailID);
            user.setRole(role);
            userManagement.updateUser(user);
        }
        doGet(request, response);
    }
}