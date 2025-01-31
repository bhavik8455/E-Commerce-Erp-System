package operations.addtocart;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.ProductPojo;

public class Cart_Implementation implements Cart_Interface {
    
    @Override
    public ProductPojo getProductById(int productId) {
        String query = "SELECT * FROM Products WHERE ProductID = ?";
        ProductPojo product = null;
        
        try {
            PreparedStatement stmt = db.GetConnection.getConnection().prepareStatement(query);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()) {
                product = new ProductPojo();
                product.setId(rs.getInt("ProductID"));
                product.setP_Name(rs.getString("Name"));
                product.setP_Category(rs.getString("Category"));
                product.setP_Cost(rs.getDouble("Cost"));
                product.setP_SellingPrice(rs.getDouble("SellingPrice"));
                product.setP_Stock(rs.getInt("Stock"));
                product.setP_ReorderLevel(rs.getInt("ReorderLevel"));
                product.setP_SupplierInfo(rs.getString("SupplierInfo"));
                product.setP_ExpiryDate(rs.getDate("ExpiryDate"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }
    
    @Override
    public boolean checkStockAvailability(int productId, int requestedQuantity) {
        String query = "SELECT Stock FROM Products WHERE ProductID = ?";
        try {
            PreparedStatement stmt = db.GetConnection.getConnection().prepareStatement(query);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            
            if(rs.next()) {
                int availableStock = rs.getInt("Stock");
                return availableStock >= requestedQuantity;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}