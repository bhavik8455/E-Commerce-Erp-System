package operations.adminproduct;
import java.util.List;
import model.admin.*;

public interface Product_Interface {
	
    void addProduct(Product_Pojo product);
    List<Product_Pojo> getAllProducts();
    Product_Pojo getProductById(int id);
    void updateProduct(Product_Pojo product);
    void deleteProduct(int id);
    
}