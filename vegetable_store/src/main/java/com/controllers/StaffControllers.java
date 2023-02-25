/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.DAO.CartDAO;
import com.models.Cart;
import com.models.GenerateID;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
            request.getRequestDispatcher("/view/staff/order.jsp").forward(request, response);
        } else {
            if (path.startsWith("/staff/cart/order")) {
                String id = request.getParameter("id");
                GenerateID generateID = new GenerateID();
                CartDAO aO = new CartDAO();
                Cart c = aO.getCartByID(id);
                if (session.getAttribute("payment_id") == null) {
                    String payment_id = generateID.generateOrder("payment");
                    String order_id = generateID.generateOrder("order");
                    session.setAttribute("payment_id", payment_id);
                    session.setAttribute("order_id", order_id);
                } else {
                    String payment_id = session.getAttribute("payment_id").toString();
                    String order_id = session.getAttribute("order_id").toString();
                }

            } else if (path.startsWith("/staff/cart/delete")) {
                String id = request.getParameter("id");
                CartDAO cdao = new CartDAO();
                int count = cdao.deleteCart(id);
                if (count != 0) {
                    response.sendRedirect(request.getContextPath() + "/staff/cart?delete_cart=1");
                } else {
                    response.sendRedirect(request.getContextPath() + "/staff/cart?delete_cart=2");
                }
            } else if (path.startsWith("/staff/cart")) {
                request.getRequestDispatcher("/view/staff/cart.jsp").forward(request, response);
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
        if (request.getParameter("btn_add_cart_item") != null) {
            String product_id, user_id, quantity, cart_id;
        }
    }

}
