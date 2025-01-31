package operations.Browse_operation;

import java.util.List;

import model.ProductPojo;

public interface Homepage_Interface {
	List<String> getAllCategories();
	List<ProductPojo> getProductsByCategory(String Category);
	default List<ProductPojo> getAllProducts() {
		return null;
	}
	

}
