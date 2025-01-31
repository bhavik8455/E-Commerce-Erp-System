package model.admin;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import db.GetConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class FeedbackPojo {
    // Private fields
    private int customerId;
    private String comments;
    private int ratings;
//    private String timestamp;
    
    // Getters and setters
    public int getCustomerId() {
        return customerId;
    }
    
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    
    public String getComments() {
        return comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }
    
    public int getRatings() {
        return ratings;
    }
    
    public void setRatings(int ratings) {
        this.ratings = ratings;
    }
    
//    public String getTimestamp() {
//        return timestamp;
//    }
//    
//    public void setTimestamp(String timestamp) {
//        this.timestamp = timestamp;
//    }
    
    // Method to get all feedback
    public static List<FeedbackPojo> getAllFeedback() {
        List<FeedbackPojo> feedbackList = new ArrayList<>();
        
        try (Connection connection = GetConnection.getConnection()) {
            if (connection == null) {
                System.out.println("Database connection failed!");
                return feedbackList;
           
            }
            System.out.println(feedbackList);
            
            String sql = "SELECT * FROM feedback";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
                 ResultSet resultSet = preparedStatement.executeQuery()) {
                
                while (resultSet.next()) {
                    FeedbackPojo feedback = new FeedbackPojo();
                    feedback.setCustomerId(resultSet.getInt("CustomerID"));
                    feedback.setComments(resultSet.getString("Comments"));
                    feedback.setRatings(resultSet.getInt("Ratings"));
//                    feedback.setTimestamp(resultSet.getString("Timestamp"));
                    feedbackList.add(feedback);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching feedback: " + e.getMessage());
            e.printStackTrace();
        }
        
        return feedbackList;
    }
}