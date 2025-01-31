package controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.admin.*;
import operations.adminproduct.*;

@WebServlet("/ProductController")
public class Product_Management extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Product_Implementation productDao = new Product_Implementation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default action
        }

        try {
            switch (action) {
                case "new":
                    request.setAttribute("formAction", "add");
                    request.setAttribute("product", new Product_Pojo()); // Empty product for form
                    forwardToJsp(request, response);
                    break;
                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Product_Pojo existingProduct = productDao.getProductById(id);
                    request.setAttribute("product", existingProduct);
                    request.setAttribute("formAction", "update");
                    forwardToJsp(request, response);
                    break;
                case "delete":
                    deleteProduct(request, response);
                    break;
                default:
                    listProducts(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addProduct(request, response);
                    break;
                case "update":
                    updateProduct(request, response);
                    break;
                default:
                    response.sendRedirect("ProductController?action=list");
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product_Pojo> productList = productDao.getAllProducts();
        request.setAttribute("productList", productList);
        forwardToJsp(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double cost = Double.parseDouble(request.getParameter("cost"));
        double sellingPrice = Double.parseDouble(request.getParameter("sellingPrice"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        int reorderLevel = Integer.parseInt(request.getParameter("reorderLevel"));
        String supplierInfo = request.getParameter("supplierInfo");
        Date expiryDate = Date.valueOf(request.getParameter("expiryDate"));

        Product_Pojo product = new Product_Pojo();
        product.setP_Name(name);
        product.setP_Category(category);
        product.setP_Cost(cost);
        product.setP_SellingPrice(sellingPrice);
        product.setP_Stock(stock);
        product.setP_ReorderLevel(reorderLevel);
        product.setP_SupplierInfo(supplierInfo); // Directly store supplier info as plain string
        product.setP_ExpiryDate(expiryDate);

        productDao.addProduct(product);

        response.sendRedirect("ProductController?action=list");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product_Pojo product = new Product_Pojo();
        product.setId(id);
        product.setP_Name(request.getParameter("name"));
        product.setP_Category(request.getParameter("category"));
        product.setP_Cost(Double.parseDouble(request.getParameter("cost")));
        product.setP_SellingPrice(Double.parseDouble(request.getParameter("sellingPrice")));
        product.setP_Stock(Integer.parseInt(request.getParameter("stock")));
        product.setP_ReorderLevel(Integer.parseInt(request.getParameter("reorderLevel")));
        product.setP_SupplierInfo(request.getParameter("supplierInfo")); // Directly set supplier info
        product.setP_ExpiryDate(java.sql.Date.valueOf(request.getParameter("expiryDate")));

        productDao.updateProduct(product);
        response.sendRedirect("ProductController?action=list");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productDao.deleteProduct(id);
        response.sendRedirect("ProductController?action=list");
    }

    private void forwardToJsp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("product_management.jsp");
        dispatcher.forward(request, response);
    }
}