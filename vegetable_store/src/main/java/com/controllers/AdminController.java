/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.DAO.AccountDAO;
import com.DAO.UserDAO;
import com.models.Account;
import com.models.User;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author
 */
public class AdminController extends HttpServlet {

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
            out.println("<title>Servlet AdminController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminController at " + request.getContextPath() + "</h1>");
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
        String path = request.getRequestURI();
        PrintWriter out = response.getWriter();
        UserDAO userDAO = new UserDAO();
        AccountDAO accountDAO = new AccountDAO();
        if (path.endsWith("/manage/customer")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/manage_customer.jsp");
            dispatcher.forward(request, response);
        } else if (path.endsWith("/manage/customer/add")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/add_customer.jsp");
            dispatcher.forward(request, response);
        }
        else {
            if (path.startsWith("/admin/manage/customer/edit")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/edit_customer.jsp");
                dispatcher.forward(request, response);
            } else if (path.startsWith("/admin/manage/customer/delete")) {
                String user_id = request.getParameter("id");
                User us = userDAO.getUserByID(user_id);
                int check = userDAO.deleteUserByID(user_id);
                if (check != 0) {
                    check = accountDAO.deleteAccountByEmail(us.getEmail());
                    if (check != 0) {
                        response.sendRedirect(request.getContextPath() + "/admin/manage/customer?success=1");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/manage/customer?fail=1");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/customer?fail=1");
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
        
        if (request.getParameter("btn_update_customer") != null) {
            String id, full_name, email,
                    password, phone, address, role_id;
            id = request.getParameter("id");
            full_name = request.getParameter("full_name");
            email = request.getParameter("email");
            address = request.getParameter("address");
            password = request.getParameter("password");
            phone = request.getParameter("phone");
            role_id = request.getParameter("role_id");
            Account acc = new Account(email, password, role_id);
            User cus = new User(id, full_name, email, phone, address);
            UserDAO cdao = new UserDAO();
            AccountDAO accountDAO = new AccountDAO();

            int check = accountDAO.updateAccount(acc);
            if (check != 0) {
                check = cdao.updateUser(cus);
                if (check != 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/customer?edit_customer=1");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/customer?edit_customer_fail=1");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage/customer?edit_customer_fail=1");
            }

        }
        if (request.getParameter("btn_insert_customer") != null) {
            String id, full_name, email,
                    password, phone, address, role_id;
            id = request.getParameter("id");
            full_name = request.getParameter("full_name");
            email = request.getParameter("email");
            address = request.getParameter("address");
            password = request.getParameter("password");
            phone = request.getParameter("phone");
            role_id = request.getParameter("role_id");
            Account acc = new Account(email, password, role_id);
            User cus = new User(id, full_name, email, phone, address);
            UserDAO cdao = new UserDAO();
            AccountDAO accountDAO = new AccountDAO();
            out.print(email);
            if (!accountDAO.checkAccountExits(email)) {
                int check = accountDAO.InsertAccount(acc);
                if (check != 0) {
                    check = cdao.InsertUserInfor(cus);
                    if (check != 0) {
                        response.sendRedirect(request.getContextPath() + "/admin/manage/customer?add_customer=1");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/manage/customer?add_customer_fail=1");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/customer?add_customer_fail=1");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage/customer/add?error=1");
            }
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
