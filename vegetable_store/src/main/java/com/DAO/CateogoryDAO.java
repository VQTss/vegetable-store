/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.connections.DBConnections;
import com.models.Category;
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
public class CateogoryDAO {
    private Connection conn;

    public CateogoryDAO() {
        conn =  DBConnections.getConnection();
    }
    
    public ResultSet getAllCategory(){
        ResultSet resultSet = null;
        
        String query = "SELECT * FROM product_category";
        
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            resultSet = pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(CateogoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        return resultSet;
    }
    
   public Category getCategoryByID(String id){
       Category c =  null;
       
        String query = "SELECT * FROM product_category WHERE catagory_id=?";
        
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, id);
            ResultSet s = pst.executeQuery();
            if (s.next()) {
                // catagory_id,category_name
                c = new Category(s.getString("catagory_id"), s.getString("category_name"),s.getString("image") );
            }
        } catch (SQLException ex) {
            Logger.getLogger(CateogoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return c;
   }
   
     public int countCategory(){
        int count = 0;
        String query = "SELECT * FROM product_category";
        
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {                
                count++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return count;
    }
    
    
}
