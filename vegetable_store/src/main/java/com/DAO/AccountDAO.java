/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.connections.DBConnections;
import com.models.Account;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author thaiq
 */
public class AccountDAO {

    private Connection conn;

    public AccountDAO() {
        conn = DBConnections.getConnection();
    }

    public boolean checkAccountExits(String email) {
        try {
            String query = "SELECT * FROM `account` WHERE email = ?";
            PreparedStatement pst = conn.prepareCall(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;

    }

    public Account checkExitsAccount(String email) {
        Account acc = null;
        try {
            String query = "SELECT * FROM `account` WHERE email = ?";
            PreparedStatement pst = conn.prepareCall(query);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                acc = new Account(rs.getString("email"), rs.getString("password"), rs.getString("role_id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return acc;

    }

    public int InsertAccount(Account acc) {
        int count = 0;
        try {
            String query = "INSERT INTO account (email,password,role_id)"
                    + "VALUES(?,?,?)";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, acc.getEmail());
            pst.setString(2, acc.getPassword());
            pst.setString(3, acc.getRole_id());
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int CountCustomer() {
        int count = 0;
        String query = "SELECT * FROM account";
        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                if (rs.getString("role_id").equals("customer")) {
                    count++;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count;
    }

    public int deleteAccountByEmail(String email) {
        int count = 0;
        String query = "DELETE FROM account WHERE email=?";
        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(query);
            pst.setString(1, email);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int updateAccount(Account acc) {
        int count = 0;

        String query = "UPDATE account "
                + "SET  password=?, role_id=?"
                + "WHERE email = ?";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, acc.getPassword());
            pst.setString(2, acc.getRole_id());
            pst.setString(3, acc.getEmail());
            count  = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

}
