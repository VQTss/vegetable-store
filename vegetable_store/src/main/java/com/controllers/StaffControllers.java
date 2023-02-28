/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.DAO.CartDAO;
import com.DAO.OrderDAO;
import com.DAO.OrderDetailDAO;
import com.DAO.PaymentDAO;
import com.DAO.ProductDAO;
import com.models.Cart;
import com.models.GenerateID;
import com.models.Order;
import com.models.OrderDetails;
import com.models.Payment;
import com.models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;

/**
 *
 * @author
 */
public class StaffControllers extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String path = request.getRequestURI();
        HttpSession session = request.getSession();
        if (path.endsWith("/staff/order")) {
            request.getRequestDispatcher("/view/staff/staff.jsp").forward(request, response);
        } else {
            if (path.startsWith("/staff/order/buy")) {
                request.getRequestDispatcher("/view/staff/buy_form.jsp").forward(request, response);
            } else if (path.startsWith("/staff/order/delete")) {
                String id = request.getParameter("id");
                OrderDetailDAO detailDAO = new OrderDetailDAO();
                OrderDAO dAO = new OrderDAO();
                int check = detailDAO.deleteOrderDetails(id);
                if (check != 0) {
                    check = dAO.deleteOrder(id);
                    if (check != 0) {
                        response.sendRedirect(request.getContextPath() + "/staff/order?delete_success=1");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/staff/order?delete_success_fail=1");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/staff/order?delete_success_fail=1");
                }
            }
           
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        if (request.getParameter("btn_checkout") != null) {
            String order_id, payment_id;
            order_id = request.getParameter("order_id");
            payment_id = request.getParameter("payment_id");
            OrderDetailDAO detailDAO = new OrderDetailDAO();
            ArrayList<OrderDetails> list = detailDAO.getAllOrderDetailsByID(order_id);
            float totalPrice = 0;
            String user_id = "";
            for (OrderDetails orderDetails : list) {
                ProductDAO aO = new ProductDAO();
                Product product = aO.getAllByID(orderDetails.getProduct_id());
                totalPrice += (orderDetails.getQuantity() * product.getSelling_price());
            }
            PaymentDAO aO = new PaymentDAO();
            OrderDAO dAO = new OrderDAO();
            Order order = dAO.getOrderByID(order_id);
            Payment payment = new Payment(payment_id, order.getUser_id(), totalPrice);
            int check = aO.createPayement(payment);
            if (check != 0) {
                out.print("add payment success");
                check = dAO.updatePaymentIDForOrder(payment.getPayment_id(), order_id);
                if (check != 0) {
                    response.sendRedirect(request.getContextPath() + "/staff/order?success=1");
                } else {
                    response.sendRedirect(request.getContextPath() + "/staff/order?fail=1");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/staff/order?fail=1");
            }
        }
    }

}
