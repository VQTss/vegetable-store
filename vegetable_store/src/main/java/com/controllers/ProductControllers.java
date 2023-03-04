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
import com.DAO.UserDAO;
import com.models.GenerateID;
import com.models.Order;
import com.models.Payment;
import com.models.Product;
import com.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;

/**
 *
 * @author
 */
public class ProductControllers extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductControllers at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        if (path.startsWith("/product/cart")) {
            request.getRequestDispatcher("/shoping-cart.jsp").forward(request, response);
        }
        if (path.endsWith("/product/all")) {
            request.getRequestDispatcher("/shop-grid.jsp").forward(request, response);
        }else if (path.endsWith("/product/contact")) {
            request.getRequestDispatcher("/contact.jsp").forward(request, response);
        }else if (path.endsWith("/product/blog")) {
            request.getRequestDispatcher("/blog.jsp").forward(request, response);
        }else {
            if (path.startsWith("/product/payment")) {
                String id = request.getParameter("id");
                CartDAO cartDAO = new CartDAO();
                float total =  cartDAO.totalProduct(id);
                PaymentDAO paymentDAO = new PaymentDAO();
                GenerateID gid = new GenerateID();
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByID(id);
                Payment payment = new Payment(gid.generateOrder("payment"), id, total);
                int check = paymentDAO.createPayement(payment);
                if (check  != 0) {
                    Order order = new Order(gid.generateOrder("order"), "Giao hang dung gio", user.getUser_id(), user.getFull_name(), user.getPhone(), user.getAddress(), payment.getPayment_id());
                    OrderDAO orderDAO = new OrderDAO();
                    check = orderDAO.createOrder(order);
                    if (check != 0) {
                        OrderDetailDAO detailDAO = new OrderDetailDAO();
                        check = detailDAO.createOrderDetailsByUserId(user.getUser_id(), order.getOrder_id());
                        if (check != 0) {
                           response.sendRedirect("/");
                        }else{
                            out.print("order details fail");
                        }
                    }else{
                        out.print("order fail");
                    }
                }else{
                    out.print("payment fail");
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
        String path = request.getRequestURI();
        if (request.getParameter("btn_sort_price") != null) {
            request.getRequestDispatcher("shop-grid.jsp").forward(request, response);
        }
        
        if (request.getParameter("update_cart") != null) {
            String[] quanties = request.getParameterValues("quantity");
            String[] product_ids = request.getParameterValues("product_id");
            for (int i = 0; i < quanties.length; i++) {
                ProductDAO productDAO = new ProductDAO();
                productDAO.addToCardProduct(Integer.valueOf(quanties[i]), product_ids[i]);
            }
            response.sendRedirect(request.getContextPath()+"/product/cart");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
