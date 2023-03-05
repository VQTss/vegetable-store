<%@page import="java.sql.ResultSet"%>
<%@page import="com.models.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.DAO.OrderDAO"%>
<%@page import="com.DAO.CateogoryDAO"%>
<%@page import="java.util.Locale.Category"%>
<%@page import="com.DAO.ProductDAO"%>
<%@page import="com.models.User"%>
<%@page import="com.DAO.UserDAO"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        <link rel="stylesheet" href="/view/customer/styles.css" />
        <title>Staff Dashboard</title>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.2/css/jquery.dataTables.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.13.2/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });

        </script>
    </head>

    <body>
        <%
            if (session.getAttribute("name") == null) {
                response.sendRedirect(request.getContextPath() + "/account/login");
            }

            String email = session.getAttribute("name").toString();
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email);
        %> 

        <div class="d-flex" id="wrapper">
            <!-- Sidebar -->
            <div class="bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading text-center py-4 primary-text fs-4 fw-bold text-uppercase border-bottom">
                    <img src="/view/admin/logo.png" alt="alt"/></div>
                <div class="list-group list-group-flush my-3">
                    <a href="<%= request.getContextPath()%>/login/customer" class="list-group-item list-group-item-action bg-transparent second-text "><i
                            class="fas fa-tachometer-alt me-2"></i>Order</a>
                    <a href="<%= request.getContextPath()%>/customer/profile?id=<%= user.getEmail()%>" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-project-diagram me-2"></i>Profile</a>
                    <a href="/account/logout" class="list-group-item list-group-item-action bg-transparent text-danger fw-bold"><i
                            class="fas fa-power-off me-2"></i>Logout</a>
                </div>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper">
                <nav class="navbar navbar-expand-lg navbar-light bg-transparent py-4 px-4">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-align-left primary-text fs-4 me-3" id="menu-toggle"></i>
                        <h2 class="fs-2 m-0">Dashboard</h2>
                    </div>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle second-text fw-bold" href="#" id="navbarDropdown"
                                   role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-user me-2"></i><%= user.getFull_name()%>
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <li><a class="dropdown-item" href="/account/logout">Logout</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>

                <%
                    if (request.getParameter("update_sucess") != null) {
                %>
                <div class="alert alert-success" role="alert">
                    Update profile success.
                </div>
                <%
                } else if (request.getParameter("update_fail") != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    Update profile fail.
                </div>
                <%
                    }
                %>

                <div class="d-flex" id="wrapper">



                    <div class="container-fluid px-4">

                        <div class="row my-5">
                            <h3 class="fs-4 mb-3">Recent Orders</h3>

                            <div style="padding: 20px 10px" class="col  bg-white rounded shadow-sm  table-hover">
                                <table id="example" class="display" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Name</th>
                                            <th>Order date</th>
                                            <th>Note</th>
                                          

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            OrderDAO dAO = new OrderDAO();
                                            ResultSet elem = dAO.getAllOrderByUser(user.getUser_id());
                                            while (elem.next()) {

                                        %>
                                        <tr>
                                            <td><%= elem.getString("order_id")%></td>
                                            <td><%= elem.getString("name")%></td>
                                            <td><%= elem.getDate("order_date")%></td>
                                            <td><%= elem.getString("order_desc")%></td>
                                        <%
                                            }

                                        %>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Name</th>
                                            <th>Order date</th>
                                            <th>Note</th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <!-- /#page-content-wrapper -->
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            var el = document.getElementById("wrapper");
            var toggleButton = document.getElementById("menu-toggle");

            toggleButton.onclick = function () {
                el.classList.toggle("toggled");
            };
        </script>

    </body>

</html>