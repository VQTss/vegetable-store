/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.connections.DBConnections;
import com.models.Order;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author
 */
public class OrderDAO {

    private Connection conn;

    public OrderDAO() {
        conn = DBConnections.getConnection();
    }

    public ResultSet getRecentOrder() {
        ResultSet rs = null;

        String query = "SELECT * FROM `order` WHERE order_date <= DATE(NOW())";

        try {
            PreparedStatement pst = conn.prepareStatement(query);
            rs = pst.executeQuery();

        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    public Order getOrderByID(String order_id) {
        Order order = null;
        String query = "SELECT * FROM `order` WHERE order_id =?";
        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, order_id);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {                
                order = new Order(rs.getString("order_id"), rs.getString("order_desc"), rs.getString("user_id"), 
                        rs.getDate("order_date"), rs.getString("name"), 
                        rs.getString("phone"), rs.getString("address"), rs.getString("payment_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return order;
    }

}
