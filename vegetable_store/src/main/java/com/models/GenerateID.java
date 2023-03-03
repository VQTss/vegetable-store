/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import com.DAO.CartDAO;
import com.DAO.CateogoryDAO;
import com.DAO.OrderDAO;
import com.DAO.OrderDetailDAO;
import com.DAO.PaymentDAO;
import com.DAO.ProductDAO;
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

    public String generateProduct() {
        String id = "";
        int min = 1;
        int max = 1000;
        ProductDAO aO = new ProductDAO();
        while (true) {
            int random_int = (int) (Math.random() * (max - min + 1) + min);
            id = "PRO_" + String.valueOf(random_int);
            if (aO.getAllByID(id) == null) {
                break;
            }
        }

        return id;
    }

    public String generateCategory() {

        String id = "";
        int min = 1;
        int max = 1000;
        CateogoryDAO aO = new CateogoryDAO();
        while (true) {
            int random_int = (int) (Math.random() * (max - min + 1) + min);
            id = "CATE_" + String.valueOf(random_int);
            if (aO.getCategoryByID(id) == null) {
                break;
            }
        }

        return id;
    }

    public String generateCart() {

        String id = "";
        int min = 1;
        int max = 1000;
        CartDAO aO = new CartDAO();
        while (true) {
            int random_int = (int) (Math.random() * (max - min + 1) + min);
            id = "CAR_" + String.valueOf(random_int);
            if (aO.checkIDCart(id)) {
                break;
            }
        }

        return id;
    }

    public String generateOrder(String recognition) {
        String id = "";
        int min = 1;
        int max = 1000;
        OrderDAO orderDAO = new OrderDAO();
        PaymentDAO paymentDAO = new PaymentDAO();
        OrderDetailDAO detailDAO = new OrderDetailDAO();
        while (true) {
            int random_int = (int) (Math.random() * (max - min + 1) + min);
            if (recognition.equals("order")) {
                id = "OR" + String.valueOf(random_int);
                if (orderDAO.getOrderByID(id) == null) {
                    break;
                }
            } else if (recognition.equals("order_details")) {
                id = "ORD_" + String.valueOf(random_int);
                if (!detailDAO.checkIDOrderDetail(id)) {
                    break;
                }
                break;
            } else if (recognition.equals("payment")) {
                id = "PAY_" + String.valueOf(random_int);
                if (!paymentDAO.checkIDPayment(id)) {
                    break;
                }
                break;
            }
        }

        return id;
    }

    

}
