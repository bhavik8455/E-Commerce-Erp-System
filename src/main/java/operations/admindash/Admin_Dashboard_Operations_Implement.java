package operations.admindash;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.GetConnection;
import model.admin.Admin_Dashoboard_Pojo;

public class Admin_Dashboard_Operations_Implement implements Admin_Dashboard_Operations {

	@Override
	public String getsalestrendata(Admin_Dashoboard_Pojo pojo) {
		String result = null;

		try {
			CallableStatement callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.SalesTrend()");

			ResultSet rs = callableStatement.executeQuery();

			if(rs.next()) {
				result = rs.getString(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public String getdemandforecastdata(Admin_Dashoboard_Pojo pojo) {
		String result = null;

		try {
			CallableStatement callableStatement = GetConnection.getConnection().prepareCall("select demo_erp.ForecastDemand();");

			ResultSet rs = callableStatement.executeQuery();

			if(rs.next()) {
				result = rs.getString(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public String getabclassificationdata(Admin_Dashoboard_Pojo pojo) {
		String result = null;

		try {
			CallableStatement callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.ABC_Classification()");

			ResultSet rs = callableStatement.executeQuery();

			if(rs.next()) {
				result = rs.getString(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public String getinvenotoryratio(Admin_Dashoboard_Pojo pojo) {
		String result = null;

		try {
			CallableStatement callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.RatioTurnoverYearly()");

			ResultSet rs = callableStatement.executeQuery();

			if(rs.next()) {
				result = rs.getString(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public String getproductprfotability(Admin_Dashoboard_Pojo pojo) {
		String result = null;

		try {
			CallableStatement callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.GetProfitabilityAnalysis();");

			ResultSet rs = callableStatement.executeQuery();

			if(rs.next()) {
				result = rs.getString(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int gettotalrevenue(Admin_Dashoboard_Pojo pojo) {
		int result = 0;

		try {
			PreparedStatement preparedStatement = GetConnection.getConnection().prepareStatement("SELECT SUM(TotalAmount) AS TotalRevenue From Sales;");

			ResultSet rs = preparedStatement.executeQuery();

			if(rs.next()) {
				result = rs.getInt(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int gettotalusers(Admin_Dashoboard_Pojo pojo) {
		int result = 0;

		try {
			PreparedStatement preparedStatement = GetConnection.getConnection().prepareStatement("SELECT COUNT(*) AS TotalUsers from Users;");
					

			ResultSet rs = preparedStatement.executeQuery();

			if(rs.next()) {
				result = rs.getInt(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int gettotalproducts(Admin_Dashoboard_Pojo pojo) {
		int result = 0;

		try {
			PreparedStatement preparedStatement = GetConnection.getConnection().prepareStatement("SELECT COUNT(*) AS TotalProducts from products;");

			ResultSet rs = preparedStatement.executeQuery();

			if(rs.next()) {
				result = rs.getInt(1);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return result;
	}

	

}
