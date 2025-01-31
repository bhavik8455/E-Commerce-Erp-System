package operations.feedback;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import db.GetConnection;
import model.FeedbackPojo;
import model.ProductPojo;
import model.SalesPojo;

public class Feedback_Implementation implements Feedback_Interface {
    
	@Override
	public List<SalesPojo> getPurchasedProducts(int customerId) {
	    List<SalesPojo> purchases = new ArrayList<>();
	    String query = "SELECT s.SaleID, s.ProductID, s.CustomerID, s.Quantity, s.Date, s.TotalAmount, " +
	                   "p.Name AS ProductName, p.Category AS ProductCategory, " +
	                   "c.Name AS CustomerName, c.Email AS CustomerEmail " +
	                   "FROM Sales s " +
	                   "JOIN Products p ON s.ProductID = p.ProductID " +
	                   "JOIN Customers c ON s.CustomerID = c.CustomerID " +
	                   "WHERE s.CustomerID = ?";

	    try (PreparedStatement stmt = GetConnection.getConnection().prepareStatement(query)) {
	        stmt.setInt(1, customerId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            SalesPojo sale = new SalesPojo();
	            sale.setSaleId(rs.getInt("SaleID"));
	            sale.setProductId(rs.getInt("ProductID"));
	            sale.setCustomerId(rs.getInt("CustomerID"));
	            sale.setQuantity(rs.getInt("Quantity"));
	            sale.setDate(rs.getDate("Date"));
	            sale.setTotalAmount(rs.getDouble("TotalAmount"));
	            
	            // Set additional fields
	            sale.setProductName(rs.getString("ProductName"));
	            sale.setProductCategory(rs.getString("ProductCategory"));

	            purchases.add(sale);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return purchases;
	}

    @Override
    public boolean submitFeedback(FeedbackPojo feedback) {
        String query = "INSERT INTO Feedback (ProductID, CustomerID, Comments, Ratings) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = GetConnection.getConnection().prepareStatement(query)) {
            stmt.setInt(1, feedback.getProductId());
            stmt.setInt(2, feedback.getCustomerId());
            stmt.setString(3, feedback.getComments());
            stmt.setInt(4, feedback.getRatings());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}