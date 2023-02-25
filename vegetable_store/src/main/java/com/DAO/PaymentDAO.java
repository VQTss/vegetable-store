/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.connections.DBConnections;
import com.models.Payment;
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

    public boolean checkIDPayment(String payment_id) {
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

    public int createPayement(Payment pay) {
        int count = 0;
        String query = "INSERT INTO payment VALUES(?,?,?)";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, pay.getPayment_id());
            pst.setString(2, pay.getUser_id());
            pst.setFloat(3, pay.getPrice());
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public Payment getPaymentByID(String payment_id) {
        Payment p = null;
        String query = "SELECT * FROM `payment` WHERE payment_id=?";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, payment_id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                p = new Payment(rs.getString("payment_id"), rs.getString("user_id"), rs.getFloat("total_price"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(PaymentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return p;
    }

}
