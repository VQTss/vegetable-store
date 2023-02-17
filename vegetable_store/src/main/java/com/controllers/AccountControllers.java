/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.DAO.AccountDAO;
import com.DAO.UserDAO;
import com.models.Account;
import com.models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author thaiq
 */
public class AccountControllers extends HttpServlet {

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
            out.println("<title>Servlet AccountControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountControllers at " + request.getContextPath() + "</h1>");
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
//        out.print(path);
        if (path.endsWith("account/sign-up")) {
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        } else if (path.endsWith("account/login")) {
            request.getRequestDispatcher("/signin.jsp").forward(request, response);
        } else if (path.endsWith("/account/sign-up/staff")) {
            request.getRequestDispatcher("/signup_1.jsp").forward(request, response);
        }
        if (path.endsWith("/account/logout")) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("/");
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
        AccountDAO accountDAO;
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
            accountDAO = new AccountDAO();
            out.print(email);
            if (!accountDAO.checkAccountExits(email)) {
                int check = accountDAO.InsertAccount(acc);
                if (check != 0) {
                    check = cdao.InsertUserInfor(cus);
                    if (check != 0) {
                        response.sendRedirect(request.getContextPath() + "/account/login?success=1");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/account/sign-up?error=1");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/account/sign-up?error=1");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/account/sign-up?error=1");
            }
        }

        if (request.getParameter("btn_signin") != null) {
            HttpSession session = request.getSession();
            String email, password;
            email = request.getParameter("email");
            password = request.getParameter("password");
            accountDAO = new AccountDAO();
            Account acc = accountDAO.checkExitsAccount(email); // check user name
            if (acc == null) { // user name không ton tai
                response.sendRedirect(request.getContextPath() + "/account/login?fail=1");
            } else {
                
                if (acc.getRole_id().equals("customer")) {
                    if (acc.getPassword().equals(password)) {
                        session.setAttribute("name", acc.getEmail());
                        response.sendRedirect(request.getContextPath() + "/login/customer");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/account/login?fail=1");
                    }
                } else if (acc.getRole_id().equals("admin")) {
                    if (acc.getPassword().equals(password)) {
                        session.setAttribute("admin", "done_admin");
                        response.sendRedirect(request.getContextPath() + "/login/admin");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/account/login?fail=1");
                    }
                } else if (acc.getRole_id().equals("staff")) {
                    if (acc.getPassword().equals(password)) {
                        session.setAttribute("name_1", acc.getEmail());
                        response.sendRedirect(request.getContextPath() + "/login/staff");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/account/login?fail=1");
                    }
                }
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
