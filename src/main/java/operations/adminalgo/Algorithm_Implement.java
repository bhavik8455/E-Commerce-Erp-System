package operations.adminalgo;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.GetConnection;
import model.admin.Algorithm_Pojo;


public class Algorithm_Implement implements Algorithms{
	
	@Override
	public String getsalestrendata(Algorithm_Pojo pojo) {
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
	public String getdemandforecastdata(Algorithm_Pojo pojo) {
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
	public String getabclassificationdata(Algorithm_Pojo pojo) {
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
	public String getinvenotoryratio(Algorithm_Pojo pojo) {
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
	public String getproductprfotability(Algorithm_Pojo pojo) {
		String result = null;

		try {
			CallableStatement callableStatement = GetConnection.getConnection().prepareCall("SELECT demo_erp.GetProfitabilityAnalysis3();");

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
