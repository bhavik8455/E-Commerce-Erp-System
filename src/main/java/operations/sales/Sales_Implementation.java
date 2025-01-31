package operations.sales;

import java.sql.Connection;
import java.sql.CallableStatement;
import java.sql.SQLException;
import model.SalesPojo;
import db.GetConnection;

public class Sales_Implementation implements Sales_Interface {

    @Override
    public boolean processSale(SalesPojo sale) {
        Connection conn = null;
        CallableStatement cs = null;
        boolean success = false;

        try {
            conn = GetConnection.getConnection();
            conn.setAutoCommit(false);

            // Call the stored procedure to process the sale
            String sql = "{CALL PurchaseProduct(?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);

            // Set the parameters for the stored procedure
            cs.setInt(1, sale.getProductId());
            cs.setInt(2, sale.getCustomerId());
            cs.setInt(3, sale.getQuantity());
            cs.setString(4, sale.getPaymentMethod());

            // Execute the stored procedure
            cs.execute();

            // If the stored procedure was successful, commit the transaction
            conn.commit();
            success = true;

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (cs != null) cs.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }
}
