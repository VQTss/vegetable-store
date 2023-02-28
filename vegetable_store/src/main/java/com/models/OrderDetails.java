/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

/**
 *
 * @author
 */
public class OrderDetails {
    private String orderdetails_id;
    private int quantity;
    private String product_id;
    private String order_id;

    public OrderDetails(String orderdetails_id, int quantity, String product_id, String order_id) {
        this.orderdetails_id = orderdetails_id;
        this.quantity = quantity;
        this.product_id = product_id;
        this.order_id = order_id;
    }

    public String getOrderdetails_id() {
        return orderdetails_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getProduct_id() {
        return product_id;
    }

    public String getOrder_id() {
        return order_id;
    }
    
    
}
