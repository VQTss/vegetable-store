/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import com.DAO.UserDAO;

/**
 *
 * @author thaiq
 */
public class GenerateID {
    
    UserDAO userDAO = new UserDAO();
     public String generate(String recognition) {
        String id = "";
        int min = 1;
        int max = 1000;
        while (true) {
            int random_int = (int) (Math.random() * (max - min + 1) + min);
            if (recognition.equals("customer")) {
                id = "CUS_" + String.valueOf(random_int);
                if (userDAO.getUserByID(id) == null) {
                    break;
                }
            } else if (recognition.equals("staff")) {
                id = "STA_" + String.valueOf(random_int);
                if (userDAO.getUserByID(id) == null) {
                    break;
                }
                break;
            } 
        }

        return id;
    }
}
