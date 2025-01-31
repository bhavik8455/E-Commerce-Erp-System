package operations.regularuser;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.CustomerPojo;

public class RegularUserImplementation implements RegularUserInterface {
    
    @Override
    public CustomerPojo getCustomerById(int customerId) {
        CustomerPojo customer = null;
        String query = "SELECT CustomerID, Name, Email, Phone, Address, PurchaseHistory, LoyaltyPoints " +
                      "FROM Customers WHERE CustomerID = ?";
        
        try (Connection conn = db.GetConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {
            
            pst.setInt(1, customerId);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    customer = new CustomerPojo();
                    customer.setCustomerId(rs.getInt("CustomerID"));
                    customer.setName(rs.getString("Name"));
                    customer.setEmail(rs.getString("Email"));
                    customer.setPhone(rs.getString("Phone"));
                    customer.setAddress(rs.getString("Address"));
                    customer.setPurchaseHistory(rs.getString("PurchaseHistory"));
                    customer.setLoyaltyPoints(rs.getInt("LoyaltyPoints"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching customer: " + e.getMessage());
            e.printStackTrace();
        }
        return customer;
    }

    @Override
    public boolean updateCustomerDetails(int customerId, String name, String email, String phone, String address) {
        try (Connection conn = db.GetConnection.getConnection();
             CallableStatement cst = conn.prepareCall("{CALL EditCustomerDetails(?, ?, ?, ?, ?)}")) {
            
            // Set parameters for the stored procedure
            cst.setInt(1, customerId);
            cst.setString(2, name);
            cst.setString(3, email);
            cst.setString(4, phone);
            cst.setString(5, address);
            
            // Execute the stored procedure
            try (ResultSet rs = cst.executeQuery()) {
                if (rs.next()) {
                    String message = rs.getString("Message");
                    return message.contains("Edited Successfully");
                }
            }
            
        } catch (SQLException e) {
            if (e.getSQLState().equals("45000")) {
                System.out.println("Customer not found: " + e.getMessage());
            } else if (e.getSQLState().equals("45001")) {
                System.out.println("User not found for customer: " + e.getMessage());
            } else {
                System.out.println("Error updating customer: " + e.getMessage());
            }
            e.printStackTrace();
        }
        return false;
    }
}