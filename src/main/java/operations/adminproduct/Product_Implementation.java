package operations.adminproduct;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.admin.*;

public class Product_Implementation implements Product_Interface {

	public void addProduct(Product_Pojo product) {
        try {
            CallableStatement cs = db.GetConnection.getConnection().prepareCall("{call demo_erp.AddProduct(?,?,?,?,?,?,?,?)}");
            cs.setString(1, product.getP_Name());
            cs.setString(2, product.getP_Category());
            cs.setDouble(3, product.getP_Cost());
            cs.setDouble(4, product.getP_SellingPrice());
            cs.setInt(5, product.getP_Stock());
            cs.setInt(6, product.getP_ReorderLevel());
            cs.setString(7, product.getP_SupplierInfo());  // No more JSON conversion needed
            cs.setDate(8, product.getP_ExpiryDate());
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Product_Pojo> getAllProducts() {
        List<Product_Pojo> productList = new ArrayList<>();
        try {
            ResultSet rs = db.GetConnection.getConnection().createStatement().executeQuery("Select * from Products;");
            while (rs.next()) {
                Product_Pojo product = new Product_Pojo();
                product.setId(rs.getInt("ProductID"));
                product.setP_Name(rs.getString("Name"));
                product.setP_Category(rs.getString("Category"));
                product.setP_Cost(rs.getDouble("Cost"));
                product.setP_SellingPrice(rs.getDouble("SellingPrice"));
                product.setP_Stock(rs.getInt("Stock"));
                product.setP_ReorderLevel(rs.getInt("ReorderLevel"));
                product.setP_SupplierInfo(rs.getString("SupplierInfo"));
                product.setP_ExpiryDate(rs.getDate("ExpiryDate"));
                productList.add(product);

                
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error fetching products: " + e.getMessage());
        }
        return productList;
    }
//    
    @Override
    public Product_Pojo getProductById(int id) {
        Product_Pojo product = null;
        try {
            String query = "SELECT * FROM Products WHERE ProductID = ?";
            PreparedStatement ps = db.GetConnection.getConnection().prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product_Pojo();
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
    public void updateProduct(Product_Pojo product) {
        try {
            CallableStatement cs = db.GetConnection.getConnection()
                    .prepareCall("{call demo_erp.EditProduct(?,?,?,?,?,?,?,?,?)}");
            cs.setInt(1, product.getId());
            cs.setString(2, product.getP_Name());
            cs.setString(3, product.getP_Category());
            cs.setDouble(4, product.getP_Cost());
            cs.setDouble(5, product.getP_SellingPrice());
            cs.setInt(6, product.getP_Stock());
            cs.setInt(7, product.getP_ReorderLevel());
            cs.setString(8, product.getP_SupplierInfo());
            cs.setDate(9, product.getP_ExpiryDate());
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteProduct(int id) {
        try {
            CallableStatement cs = db.GetConnection.getConnection().prepareCall("{call demo_erp.deleteProduct(?)}");
            cs.setInt(1, id);
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
