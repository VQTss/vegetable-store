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
    
    
    public int countOrderIsPaymented(){
        int count = 0;
        String query =  "SELECT * FROM `order` WHERE payment_id = null;";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            ResultSet resultSet = pst.executeQuery();
            while (resultSet.next()) {                
                count++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
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
    
    public int updatePaymentIDForOrder(String payment_id, String order_id){
        int count = 0;
        
        String query ="UPDATE `order` "
                + "SET `payment_id`=? "
                + "WHERE `order`.`order_id`=? ";
        
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, payment_id);
            pst.setString(2, order_id);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
    
    public int deleteOrder(String order_id){
        int count = 0;
        String query = "DELETE FROM `order` WHERE `order`.`order_id`=?";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, order_id);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
    
    
    public ResultSet getAllOrderByUser(String user_id){
        ResultSet resultSet = null;
        
        String query = "SELECT * FROM `order` WHERE user_id=?";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, user_id);
            resultSet = pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        return resultSet;
    }

}
