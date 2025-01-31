package model;

public class CartItem {
    private ProductPojo product;
    private int quantity;
    
    public CartItem(ProductPojo product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }
    
    public ProductPojo getProduct() {
        return product;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getSubtotal() {
        return product.getP_SellingPrice() * quantity;
    }
}