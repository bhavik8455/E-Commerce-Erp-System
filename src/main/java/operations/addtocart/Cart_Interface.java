package operations.addtocart;

import model.ProductPojo;

public interface Cart_Interface {
    ProductPojo getProductById(int productId);
    boolean checkStockAvailability(int productId, int requestedQuantity);
}