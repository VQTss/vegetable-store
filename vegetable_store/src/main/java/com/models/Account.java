/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

/**
 *
 * @author thaiq
 */
public class Account {
    private String email;
    private String password;
    private String role_id;

    public Account(String email, String password, String role_id) {
        this.email = email;
        this.password = password;
        this.role_id = role_id;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getRole_id() {
        return role_id;
    }
    
}
