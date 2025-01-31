package model;

import java.util.Date;


public class SalesPojo {
	
	
	    private int saleId;
	    private int productId;
	    private int customerId;
	    private Date date;
	    private int quantity;
	    private double totalAmount;
	    private String paymentMethod;
	    private String productName;
	    private String productCategory;

	    // Getters and Setters
	    public int getSaleId() {
	        return saleId;
	    }

	    public void setSaleId(int saleId) {
	        this.saleId = saleId;
	    }

	    public int getProductId() {
	        return productId;
	    }

	    public void setProductId(int productId) {
	        this.productId = productId;
	    }

	    public int getCustomerId() {
	        return customerId;
	    }

	    public void setCustomerId(int customerId) {
	        this.customerId = customerId;
	    }

	    public Date getDate() {
	        return date;
	    }

	    public void setDate(Date date) {
	        this.date = date;
	    }

	    public int getQuantity() {
	        return quantity;
	    }

	    public void setQuantity(int quantity) {
	        this.quantity = quantity;
	    }

	    public double getTotalAmount() {
	        return totalAmount;
	    }

	    public void setTotalAmount(double totalAmount) {
	        this.totalAmount = totalAmount;
	    }

	    public String getPaymentMethod() {
	        return paymentMethod;
	    }

	    public void setPaymentMethod(String paymentMethod) {
	        this.paymentMethod = paymentMethod;
	    }
	    
	    public String getProductName() {
	        return productName;
	    }

	    public void setProductName(String productName) {
	        this.productName = productName;
	    }

	    public String getProductCategory() {
	        return productCategory;
	    }

	    public void setProductCategory(String productCategory) {
	        this.productCategory = productCategory;
	    }
	

}
