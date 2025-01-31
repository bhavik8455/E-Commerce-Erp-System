package model;

import java.sql.Date;

public class ProductPojo {
    private int id;
    private String p_Name;
    private String p_Category;
    private double p_Cost;
    private double p_SellingPrice;
    private int p_Stock;
    private int p_ReorderLevel;
    private String p_SupplierInfo;
    private Date p_ExpiryDate;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getP_Name() {
        return p_Name;
    }

    public void setP_Name(String p_Name) {
        this.p_Name = p_Name;
    }

    public String getP_Category() {
        return p_Category;
    }

    public void setP_Category(String p_Category) {
        this.p_Category = p_Category;
    }

    public double getP_Cost() {
        return p_Cost;
    }

    public void setP_Cost(double p_Cost) {
        this.p_Cost = p_Cost;
    }

    public double getP_SellingPrice() {
        return p_SellingPrice;
    }

    public void setP_SellingPrice(double p_SellingPrice) {
        this.p_SellingPrice = p_SellingPrice;
    }

    public int getP_Stock() {
        return p_Stock;
    }

    public void setP_Stock(int p_Stock) {
        this.p_Stock = p_Stock;
    }

    public int getP_ReorderLevel() {
        return p_ReorderLevel;
    }

    public void setP_ReorderLevel(int p_ReorderLevel) {
        this.p_ReorderLevel = p_ReorderLevel;
    }

    public String getP_SupplierInfo() {
        return p_SupplierInfo;
    }

    public void setP_SupplierInfo(String p_SupplierInfo) {
        this.p_SupplierInfo = p_SupplierInfo;
    }

    public Date getP_ExpiryDate() {
        return p_ExpiryDate;
    }

    public void setP_ExpiryDate(Date p_ExpiryDate) {
        this.p_ExpiryDate = p_ExpiryDate;
    }
}