/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.connections.DBConnections;
import com.mysql.cj.xdevapi.Result;
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
public class PaymentDAO {
    private Connection conn;

    public PaymentDAO() {
        conn = DBConnections.getConnection();
    }
    
    public boolean  checkIDPayment(String payment_id){
        String query = "SELECT * FROM `payment` WHERE payment_id=?";
        
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, payment_id);
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
