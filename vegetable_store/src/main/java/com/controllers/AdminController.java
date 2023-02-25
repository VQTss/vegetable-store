/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.DAO.AccountDAO;
import com.DAO.ProductDAO;
import com.DAO.UserDAO;
import com.models.Account;
import com.models.Product;
import com.models.User;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 *
 * @author
 */
@MultipartConfig
public class AdminController extends HttpServlet {

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
        // customer
        if (path.endsWith("/manage/customer")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/manage_customer.jsp");
            dispatcher.forward(request, response);
        } else if (path.endsWith("/manage/customer/add")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/add_customer.jsp");
            dispatcher.forward(request, response);
            // staff
        } else if (path.endsWith("/manage/staff")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/manage_staff.jsp");
            dispatcher.forward(request, response);
        } else if (path.endsWith("/manage/staff/add")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/add_staff.jsp");
            dispatcher.forward(request, response);

            // product and category
        } else if (path.endsWith("/manage/product")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/manage_product.jsp");
            dispatcher.forward(request, response);
        } else if (path.endsWith("/manage/product/addproduct")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/add_product.jsp");
            dispatcher.forward(request, response);
        } else if (path.endsWith("/manage/product/addcategory")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/add_category.jsp");
            dispatcher.forward(request, response);
        } else {
            /*
            Customer update and delete
             */
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

            /*
            Staff update and delete
             */
            if (path.startsWith("/admin/manage/staff/edit")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/edit_staff.jsp");
                dispatcher.forward(request, response);
            } else if (path.startsWith("/admin/manage/staff/delete")) {
                String user_id = request.getParameter("id");
                User us = userDAO.getUserByID(user_id);
                int check = userDAO.deleteUserByID(user_id);
                if (check != 0) {
                    check = accountDAO.deleteAccountByEmail(us.getEmail());
                    if (check != 0) {
                        response.sendRedirect(request.getContextPath() + "/admin/manage/staff?success=1");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/manage/staff?fail=1");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/staff?fail=1");
                }

            }
            /*
            Product update and delete
             */
            if (path.startsWith("/admin/manage/product/editproduct")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/edit_product.jsp");
                dispatcher.forward(request, response);
            } else if (path.startsWith("/admin/manage/product/deleteproduct")) {
                String id = request.getParameter("id");
                ProductDAO pdao = new ProductDAO();
                int check = pdao.deleteProduct(id);
                if (check != 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/product?success=1");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/product?fail=1");
                }
            }

            // category
            if (path.startsWith("/admin/manage/product/editcategory")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/view/admin/edit_category.jsp");
                dispatcher.forward(request, response);
            } else if (path.startsWith("/admin/manage/product/deletecategory")) {
                String id = request.getParameter("id");
                ProductDAO pdao = new ProductDAO();
                int check = pdao.deleteCategory(id);
                if (check != 0) {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/product?success=2");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/product?fail=2");
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

        // customer
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

        // staff
        if (request.getParameter("btn_update_staff") != null) {
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
                    response.sendRedirect(request.getContextPath() + "/admin/manage/staff?edit_staff=1");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/manage/staff?edit_staff_fail=1");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage/staff?edit_staff_fail=1");
            }

        }

        if (request.getParameter("btn_insert_staff") != null) {
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

            if (!accountDAO.checkAccountExits(email)) {
                int check = accountDAO.InsertAccount(acc);
                if (check != 0) { // add dã thành công hay chua
                    check = cdao.InsertUserInfor(cus);
                    if (check != 0) { //  add user information thanh cong
                        response.sendRedirect(request.getContextPath() + "/admin/manage/staff?add_staff=1");
                    } else { // add user that bai
                        response.sendRedirect(request.getContextPath() + "/admin/manage/staff?add_staff_fail=1");
                    }
                } else { // chua thanh cong
                    response.sendRedirect(request.getContextPath() + "/admin/manage/staff?add_staff_fail=1");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage/staff/add?error=1");
            }
        }

        // product 
        if (request.getParameter("btn_update_product") != null) {
            String product_id, product_name, product_desc, selling_price, image, category_id, quantity;
            product_id = request.getParameter("id");
            product_name = request.getParameter("product_name");
            product_desc = request.getParameter("desc");
            selling_price = request.getParameter("price");
            category_id = request.getParameter("role");
            quantity = request.getParameter("quantity");
            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName();
            if (fileName.equals("")) {
                fileName = request.getParameter("image1");
            } else {
                String filePath = "E:\\Individual\\Project\\Vegetable\\vegetable_store\\vegetable_store\\src\\main\\webapp\\img\\product\\" + fileName;
                filePart.write(filePath);

            }
            Product p = new Product(product_id, product_name, Float.valueOf(selling_price), category_id,
                    product_desc, Integer.valueOf(quantity), fileName);
            ProductDAO pdao = new ProductDAO();
            int check = pdao.UpdateProduct(p);
            if (check != 0) {
                response.sendRedirect(request.getContextPath() + "/admin/manage/product?update_product=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage/product?update_product_fail=1");
            }
        }

        if (request.getParameter("btn_insert_product") != null) {
            String product_id, product_name, product_desc, selling_price, image, category_id, quantity;
            product_id = request.getParameter("id");
            product_name = request.getParameter("product_name");
            product_desc = request.getParameter("desc");
            selling_price = request.getParameter("price");
            category_id = request.getParameter("role");
            quantity = request.getParameter("quantity");
            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName(); // tên file
            String filePath = "E:\\Individual\\Project\\Vegetable\\vegetable_store\\vegetable_store\\src\\main\\webapp\\img\\product\\" + fileName;
            filePart.write(filePath);
            ProductDAO dAO = new ProductDAO();
            Product p = new Product(product_id, product_name, Float.valueOf(selling_price), category_id,
                    product_desc, Integer.valueOf(quantity), fileName);
            int check = dAO.InsertProduct(p);
            if (check != 0) {
                response.sendRedirect(request.getContextPath() + "/admin/manage/product?add_product=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage/product?add_product_fail=1");
            }

        }

        // category
        if (request.getParameter("btn_update_category") != null) {
            String id, name;
            id = request.getParameter("id");
            name = request.getParameter("name");
            ProductDAO dAO = new ProductDAO();
            int check = dAO.UpdateCategory(id, name);
           if (check != 0) {
                response.sendRedirect(request.getContextPath() + "/admin/manage/product?update_category=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage/product?update_category_fail=1");
            }
        }

        if (request.getParameter("btn_insert_category") != null) {
            String id, name;
            id = request.getParameter("id");
            name = request.getParameter("name");
            ProductDAO dAO = new ProductDAO();
            int check = dAO.addCategory(id, name);
            if (check != 0) {
                response.sendRedirect(request.getContextPath() + "/admin/manage/product?add_category=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/manage/product?add_category_fail=1");
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
