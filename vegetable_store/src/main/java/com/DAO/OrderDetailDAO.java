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
public class OrderDetailDAO {
     private Connection conn;

    public OrderDetailDAO() {
        conn = DBConnections.getConnection();
    }
     
    
      public boolean  checkIDOrderDetail(String orderdetail_id){
        String query = "SELECT * FROM `oder_detail` WHERE orderdetail_id=?";
        
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, orderdetail_id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;

    }
}
