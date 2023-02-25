/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

/**
 *
 * @author
 */
public class Product {
    private String product_id;
    private String product_name;
    private float selling_price;
    private String category_id;
    private String product_desc;
    private int quantity;
    private String image;

    public Product(String product_id, String product_name, float selling_price, String category_id, String product_desc, int quantity, String image) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.selling_price = selling_price;
        this.category_id = category_id;
        this.product_desc = product_desc;
        this.quantity = quantity;
        this.image = image;
    }

    
    
    public String getProduct_id() {
        return product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public float getSelling_price() {
        return selling_price;
    }

    public String getCategory_id() {
        return category_id;
    }

    public String getProduct_desc() {
        return product_desc;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getImage() {
        return image;
    }
    
    
}
