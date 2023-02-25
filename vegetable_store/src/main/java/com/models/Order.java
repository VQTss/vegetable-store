/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import java.sql.Date;

/**
 *
 * @author
 */
public class Order {
    private String order_id;
    private String order_desc;
    private String user_id;
    private Date order_date;
    private String name;
    private String phone;
    private String address;
    private String payment_id;

    public Order(String order_id, String order_desc, String user_id, Date order_date, String name, String phone, String address, String payment_id) {
        this.order_id = order_id;
        this.order_desc = order_desc;
        this.user_id = user_id;
        this.order_date = order_date;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.payment_id = payment_id;
    }

    public String getOrder_id() {
        return order_id;
    }

    public String getOrder_desc() {
        return order_desc;
    }

    public String getUser_id() {
        return user_id;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddress() {
        return address;
    }

    public String getPayment_id() {
        return payment_id;
    }
    
    
    
    
    
}
