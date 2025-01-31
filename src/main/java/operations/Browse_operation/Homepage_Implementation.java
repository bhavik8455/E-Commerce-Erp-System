package operations.Browse_operation;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.ProductPojo;

public class Homepage_Implementation implements Homepage_Interface {

	@Override
	public List<String> getAllCategories() {
		String qr = "Select DISTINCT Category from Products";
		List<String> categories = new ArrayList<>();
		
		try {
			PreparedStatement stmt = db.GetConnection.getConnection().prepareStatement(qr);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				categories.add(rs.getString("Category"));
			}
				
			
		} catch (Exception e) {
			 e.printStackTrace();
			
		}
		
		
		
		return categories;
	}

	@Override
	public List<ProductPojo> getProductsByCategory(String Category) {
		
		 String query = "SELECT * FROM products WHERE Category = ?";
	        List<ProductPojo> products = new ArrayList<>();
	        
	        try {
	        	
	        	PreparedStatement stmt = db.GetConnection.getConnection().prepareStatement(query);
	        	stmt.setString(1, Category);
	        	ResultSet rs = stmt.executeQuery();
	        	
	        	while(rs.next()) {
	        		ProductPojo product = new ProductPojo();
	        		
	        		product.setId(rs.getInt("ProductID"));
	        		product.setP_Name(rs.getString("Name"));
	        		product.setP_Category(rs.getString("Category"));
	                product.setP_Cost(rs.getDouble("Cost"));
	                product.setP_SellingPrice(rs.getDouble("SellingPrice"));
	                product.setP_Stock(rs.getInt("Stock"));
	                product.setP_ReorderLevel(rs.getInt("ReorderLevel"));
	                product.setP_SupplierInfo(rs.getString("SupplierInfo"));
	                product.setP_ExpiryDate(rs.getDate("ExpiryDate"));
	                products.add(product);
	        		
	        	}
	        	
				
			} catch (Exception e) {
				 e.printStackTrace();
				
			}
	        
	        return products;
		
	}

	@Override
	public List<ProductPojo> getAllProducts() {
		
		String qr = "Select * from Products";
		List<ProductPojo> products = new ArrayList<>();
		
		try {
			
			PreparedStatement stmt = db.GetConnection.getConnection().prepareStatement(qr);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				ProductPojo product = new ProductPojo();
				
				product.setId(rs.getInt("ProductID"));
        		product.setP_Name(rs.getString("Name"));
        		product.setP_Category(rs.getString("Category"));
                product.setP_Cost(rs.getDouble("Cost"));
                product.setP_SellingPrice(rs.getDouble("SellingPrice"));
                product.setP_Stock(rs.getInt("Stock"));
                product.setP_ReorderLevel(rs.getInt("ReorderLevel"));
                product.setP_SupplierInfo(rs.getString("SupplierInfo"));
                product.setP_ExpiryDate(rs.getDate("ExpiryDate"));
                products.add(product);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
		return products;
	}
	
	

}
