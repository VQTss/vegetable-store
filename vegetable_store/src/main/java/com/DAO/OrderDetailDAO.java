/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.connections.DBConnections;
import com.models.GenerateID;
import com.models.OrderDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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

    public boolean checkIDOrderDetail(String orderdetail_id) {
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

    public ArrayList<OrderDetails> getAllOrderDetailsByID(String order_id) {
        ArrayList<OrderDetails> arrayList = new ArrayList<>();

        String query = "SELECT * FROM `oder_detail` WHERE order_id=?";

        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, order_id);
            ResultSet set = pst.executeQuery();
            while (set.next()) {
                OrderDetails details = new OrderDetails(set.getString("orderdetail_id"), set.getInt("quantity"),
                        set.getString("product_id"), set.getString("order_id"));
                arrayList.add(details);
            }

        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return arrayList;
    }

    public int deleteOrderDetails(String order_id) {
        int count = 0;
        String query = "DELETE FROM oder_detail WHERE order_id=?";
        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, order_id);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int createOrderDetails(OrderDetails details) {
        int count = 0;

        String query = "INSERT INTO oder_detail (orderdetail_id,quantity,product_id,order_id)"
                + " VALUES(?,?,?,?)";

        try {
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, details.getOrderdetails_id());
            pst.setInt(2, details.getQuantity());
            pst.setString(3, details.getProduct_id());
            pst.setString(4, details.getOrder_id());
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return count;
    }

    public int createOrderDetailsByUserId(String user_id, String order_id) {
        int count = 0;

        CartDAO cartDAO = new CartDAO();
        ResultSet resultSet = cartDAO.getAllCartByID(user_id);

        try {
            while (resultSet.next()) {
                GenerateID generateID = new GenerateID();
                String order_details_id = generateID.generateOrder("order_details");
                OrderDetails details = new OrderDetails(order_details_id, resultSet.getInt("quantity"), resultSet.getString("product_id"), order_id);
                int check_details = createOrderDetails(details);
                int remove_cart = cartDAO.deleteCart(resultSet.getString("cart_id"));
                if (check_details == 0 && remove_cart == 0) {
                    count = 0;
                    break;
                } else {
                    count++;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;

    }

}
