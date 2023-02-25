/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.connections.DBConnections;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author
 */
public class CartDAO {

    private Connection conn;
    
    public CartDAO() {
        conn = DBConnections.getConnection();
    }
    
    public boolean checkIDCart(String cart_id) {
        String query = "SELECT * FROM `cart_item` WHERE cart_id=?";
        
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, cart_id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
        
    }
    
    public ResultSet getAllCartByID(String user_id) {
        ResultSet set = null;
        String query = "SELECT * FROM `cart_item` WHERE user_id=?";
        
        try {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user_id);
            set = ps.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return set;
    }
    
    public int deleteCart(String cart_id) {
        int count = 0;
        String query = "DELETE FROM cart_item WHERE cart_id=?";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, cart_id);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
        
    }
    
}
