package operations.login;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;

import model.LoginPojo;

public class LoginImplementation implements LoginInterface {

	@Override
	public String loginuser(LoginPojo pojo) {
		String result = null;
		CallableStatement callableStatement;

		try {
			callableStatement =  db.GetConnection.getConnection().prepareCall("SELECT demo_erp.Authentication(?,?)");
			callableStatement.setString(1, pojo.getPname());
			callableStatement.setString(2, pojo.getPword());

			ResultSet rs = callableStatement.executeQuery();

			if (rs.next()) {

				result = rs.getString(1);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("errorrr");
		}

		return result;
	}

	@Override
	public String adminuser(LoginPojo pojo) {
		String result = null;
		java.sql.CallableStatement callableStatement;

		try {
			callableStatement = db.GetConnection.getConnection().prepareCall("SELECT demo_erp.AdminAuthentication(?,?)");
			callableStatement.setString(1, pojo.getPname());
			callableStatement.setString(2, pojo.getPword());

			ResultSet rs = callableStatement.executeQuery();

			if (rs.next()) {

				result = rs.getString(1);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("errorrr");
		}

		return result;
	}

	@Override
	public int getCustomerID(String MailID) {
		
		 int userID = -1; // Default value if no user is found
	        
	        PreparedStatement preparedStatement = null;
	        ResultSet resultSet = null;

	        try {
	      

	            // Prepare the SQL query
	            String query = "SELECT UserID FROM users WHERE MailID=?";
	            preparedStatement = db.GetConnection.getConnection().prepareStatement(query);
	            preparedStatement.setString(1, MailID);

	            // Execute the query
	            resultSet = preparedStatement.executeQuery();

	            // Extract the user ID from the result set
	            if (resultSet.next()) {
	                userID = resultSet.getInt("UserID");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace(); // Handle SQL exceptions
	        } 

	        return userID;
	    }
		
	}
	


