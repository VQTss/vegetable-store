/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

/**
 *
 * @author
 */
public class Payment {
    private String payment_id;
    private String user_id;
    private float price;

    public String getPayment_id() {
        return payment_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public float getPrice() {
        return price;
    }

    public Payment(String payment_id, String user_id, float price) {
        this.payment_id = payment_id;
        this.user_id = user_id;
        this.price = price;
    }
    
    
}
