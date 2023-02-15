/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import java.sql.Connection;

/**
 *
 * @author thaiq
 */
import com.connections.DBConnections;
import com.models.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {

    private Connection conn;

    public UserDAO() {
        conn = DBConnections.getConnection();
    }

    public User getUserByID(String id) {
        User user = null;

        String query = "SELECT * FROM `user` WHERE user_id = ?";

        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                user = new User(rs.getString("user_id"), rs.getString("fullname"), rs.getString("email"), rs.getString("phone"), rs.getString("address"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
    
    public User getUserByEmail(String email) {
        User user = null;

        String query = "SELECT * FROM `user` WHERE email = ?";

        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                user = new User(rs.getString("user_id"), rs.getString("fullname"), rs.getString("email"), rs.getString("phone"), rs.getString("address"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
    
    
    public int InsertUserInfor(User user){
        int count  = 0;
        String query = "INSERT INTO user (user_id,fullname,email,phone,address) "
                + "VALUES (?,?,?,?,?)";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, user.getUser_id());
            pst.setString(2, user.getFull_name());
            pst.setString(3, user.getEmail());
            pst.setString(4, user.getPhone());
            pst.setString(5, user.getAddress());
            count =  pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

}
