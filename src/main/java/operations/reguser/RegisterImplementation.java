package operations.reguser;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

import java.sql.CallableStatement;

import model.RegPojo;
import db.GetConnection;

public class RegisterImplementation implements RegisterInterface {

	@Override
	public String registerUser(RegPojo pojo) {
			String result=null;
		
		try {
			CallableStatement callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.Registration(?,?,?,?)");
			callableStatement.setString(1, pojo.getMail());
			callableStatement.setString(2, pojo.getName());
			callableStatement.setString(3, pojo.getPword());
			callableStatement.setString(4, pojo.getRole());
			
			ResultSet rs = callableStatement.executeQuery();
			
			if(rs.next()) {
				
				 result = rs.getString(1);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return result;
	}
		
	
	
	
//    // Email validation regex pattern
//    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
//    
//    @Override
//    public String registerUser(RegPojo pojo) {
//        // Validate input
//        if (!validateInput(pojo)) {
//            return "Validation Failed";
//        }
//        
//        String result = null;
//        Connection conn = null;
//        PreparedStatement pstmt = null;
//        
//        try {
//            conn = GetConnection.getConnection();
//            
//            // Use prepared statement for insertion
//            String sql = "INSERT INTO USERS (MailID, Name, Password, Role) VALUES (?, ?, SHA2(?, 256), ?)";
//            pstmt = conn.prepareStatement(sql);
//            
//            pstmt.setString(1, pojo.getMail());
//            pstmt.setString(2, pojo.getName());
//            pstmt.setString(3, pojo.getPword());
//            pstmt.setString(4, pojo.getRole());
//            
//            int rowsAffected = pstmt.executeUpdate();
//            
//            if (rowsAffected > 0) {
//                result = "Successfully Registered!!";
//            }
//            
//        } catch (SQLException e) {
//            // Log the exception
//            e.printStackTrace();
//            
//            // Check for duplicate entry
//            if (e.getMessage().contains("Duplicate entry")) {
//                result = "Email already exists";
//            } else {
//                result = "Registration Failed";
//            }
//        } finally {
//            // Close resources
//            try {
//                if (pstmt != null) pstmt.close();
//                if (conn != null) conn.close();
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//        
//        return result;
//    }
//    
//    // Validate input method
//    private boolean validateInput(RegPojo pojo) {
//        // Validate email
//        if (pojo.getMail() == null || !EMAIL_PATTERN.matcher(pojo.getMail()).matches()) {
//            return false;
//        }
//        
//        // Validate name
//        if (pojo.getName() == null || pojo.getName().trim().isEmpty()) {
//            return false;
//        }
//        
//        // Validate password
//        if (pojo.getPword() == null || pojo.getPword().length() < 6 || 
//            pojo.getPword().matches("^\\d+$")) {
//            return false;
//        }
//        
//        // Validate role
//        if (pojo.getRole() == null || pojo.getRole().trim().isEmpty()) {
//            return false;
//        }
//        
//        return true;
//    }
	
	
}


