/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

/**
 *
 * @author
 */
public class Cart {
    private String card_id;
    private int quantity;
    private String product_id;
    private String user_id;

    public Cart(String card_id, int quantity, String product_id, String user_id) {
        this.card_id = card_id;
        this.quantity = quantity;
        this.product_id = product_id;
        this.user_id = user_id;
    }

    public String getCard_id() {
        return card_id;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getProduct_id() {
        return product_id;
    }

    public String getUser_id() {
        return user_id;
    }
    
}
