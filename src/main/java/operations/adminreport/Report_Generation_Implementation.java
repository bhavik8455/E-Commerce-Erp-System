package operations.adminreport;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.GetConnection;
import model.admin.report_generation_pojo;

public class Report_Generation_Implementation implements Report_Generation {

	@Override
	public String getsalestrendata(report_generation_pojo pojo) {
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
	public String getdemandforecastdata(report_generation_pojo pojo) {
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
	public String getabclassificationdata(report_generation_pojo pojo) {
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
	public String getinvenotoryratio(report_generation_pojo pojo) {
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
	public String getproductprfotability(report_generation_pojo pojo) {
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

	


}
