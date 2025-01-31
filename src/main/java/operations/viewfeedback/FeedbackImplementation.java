package operations.viewfeedback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.FeedbackPojo;
import model.ProductPojo;

public class FeedbackImplementation implements FeedbackInterface {

    @Override
    public List<FeedbackPojo> getFeedbacksByCustomerId(int customerId) {
        List<FeedbackPojo> feedbacks = new ArrayList<>();

        String query = "SELECT f.*, p.Name AS ProductName, p.Category AS ProductCategory, p.SellingPrice AS ProductSellingPrice " +
                       "FROM Feedback f " +
                       "JOIN Products p ON f.ProductID = p.ProductID " +
                       "WHERE f.CustomerID = ? " +
                       "ORDER BY f.Timestamp DESC";

        try (Connection conn = db.GetConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setInt(1, customerId);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    FeedbackPojo feedback = new FeedbackPojo();
                    feedback.setFeedbackId(rs.getInt("FeedbackID"));
                    feedback.setProductId(rs.getInt("ProductID"));
                    feedback.setCustomerId(rs.getInt("CustomerID"));
                    feedback.setComments(rs.getString("Comments"));
                    feedback.setRatings(rs.getInt("Ratings"));
                    feedback.setTimestamp(rs.getTimestamp("Timestamp"));

                    ProductPojo product = new ProductPojo();
                    product.setId(rs.getInt("ProductID"));
                    product.setP_Name(rs.getString("ProductName"));
                    product.setP_Category(rs.getString("ProductCategory"));
                    product.setP_SellingPrice(rs.getDouble("ProductSellingPrice"));

                    feedback.setProduct(product);
                    feedbacks.add(feedback);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching feedbacks: " + e.getMessage());
            e.printStackTrace();
        }
        return feedbacks;
    }

    @Override
    public boolean updateFeedback(int feedbackId, String comments, int ratings) {
        String query = "UPDATE Feedback SET Comments = ?, Ratings = ? WHERE FeedbackID = ?";

        try (Connection conn = db.GetConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setString(1, comments);
            pst.setInt(2, ratings);
            pst.setInt(3, feedbackId);

            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating feedback: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteFeedback(int feedbackId) {
        String query = "DELETE FROM Feedback WHERE FeedbackID = ?";

        try (Connection conn = db.GetConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setInt(1, feedbackId);
            int rowsAffected = pst.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting feedback: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}