package operations.adminuser;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.admin.*;

public class User_Management_Implementation implements User_Management_Interface {
	{

	}

	@Override
	public List<UserPojo> getUserDetails() {
		List<UserPojo> userList = new ArrayList<>();

		try {

			CallableStatement cstmt = db.GetConnection.getConnection()
					.prepareCall("{call demo_erp.ViewRegularUsers()}");
			cstmt.execute();
			ResultSet rs = cstmt.getResultSet();

			while (rs.next()) {
				UserPojo user = new UserPojo();
				user.setUserID(rs.getInt("UserID"));
				user.setMailID(rs.getString("MailID"));
				user.setName(rs.getString("Name"));
				user.setRole(rs.getString("Role"));
				userList.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userList;

	}

	@Override
	public void activateUser(String MailID) {
		try {
			CallableStatement cstmt = db.GetConnection.getConnection()
					.prepareCall("{call ActivateUser(?)}");
			cstmt.setString(1, MailID);
			cstmt.execute();

			ResultSet rs = cstmt.getResultSet();
			if (rs.next()) {
				System.out.println(rs.getString("Message"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deactivateUser(String MailID) {
		try {
			CallableStatement cstmt = db.GetConnection.getConnection()
					.prepareCall("{call DeactivateUser(?)}");
			cstmt.setString(1, MailID);
			cstmt.execute();

			ResultSet rs = cstmt.getResultSet();
			if (rs.next()) {
				System.out.println(rs.getString("Message"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateUser(UserPojo userPojo) {
		try {
			CallableStatement cstmt = db.GetConnection.getConnection()
					.prepareCall("{call demo_erp.EditUserDetails(?, ?, ?, ?)}");
			cstmt.setInt(1, userPojo.getUserID());
			cstmt.setString(2, userPojo.getName());
			cstmt.setString(3, userPojo.getMailID());
			cstmt.setString(4, userPojo.getRole());
			cstmt.execute();

			ResultSet rs = cstmt.getResultSet();
			if (rs.next()) {
				System.out.println(rs.getString("Message"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}