<%@page import="java.util.concurrent.atomic.AtomicInteger"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.DAO.PaymentDAO"%>
<%@page import="com.DAO.AccountDAO"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        <link rel="stylesheet" href="/view/customer/styles.css" />
        <title>Admin Dashboard</title>

    </head>

    <body>
        <%

            if (session.getAttribute("admin") == null) {
                response.sendRedirect(request.getContextPath() + "/account/login");
            } else {

        %>
        <div class="d-flex" id="wrapper">
            <!--Sidebar--> 
            <div class="bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading text-center py-4 primary-text fs-4 fw-bold text-uppercase border-bottom">
                    <img src="/view/admin/logo.png" alt="alt"/></div>
                <div class="list-group list-group-flush my-3">
                    <a href="<%= request.getContextPath()%>/login/admin" class="list-group-item list-group-item-action bg-transparent second-text active"><i
                            class="fas fa-tachometer-alt me-2"></i>Dashboard Admin</a>
                    <a href="<%= request.getContextPath()%>/admin/manage/customer" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-project-diagram me-2"></i>Manage customer</a>
                    <a href="<%= request.getContextPath()%>/admin/manage/staff" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-chart-line me-2"></i>Manage staff</a>
                    <a href="<%= request.getContextPath()%>/admin/manage/product" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-gift me-2"></i>Products</a>
                    <a href="/account/logout" class="list-group-item list-group-item-action bg-transparent text-danger fw-bold"><i
                            class="fas fa-power-off me-2"></i>Logout</a>
                </div>
            </div>
            <!--/#sidebar-wrapper--> 

            <!--Page Content--> 
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
                                    <i class="fas fa-user me-2"></i>Admin
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <li><a class="dropdown-item" href="/account/logout">Logout</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </nav>

                <%
                    AccountDAO accountDAO = new AccountDAO();
                    int countUser = accountDAO.CountCustomer();
                    int countStaff = accountDAO.CountStaff();
                %>

                <div class="container-fluid px-4">
                    <div class="row g-3 my-2">
                        <div class="col-md-3">
                            <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                                <div>
                                    <h3 class="fs-2"><%= countUser%></h3>
                                    <p class="fs-5">User Active</p>
                                </div>
                                <!--<i class="fa-solid fa-user"></i>-->
                                <i class="fas fa-user me-2 fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                                <div>
                                    <h3 class="fs-2"><%= countStaff%></h3>
                                    <p class="fs-5">Staff</p>
                                </div>
                                <i class="fas fa-user me-2 fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                                <div>
                                    <%
                                     PaymentDAO paymentDAO = new PaymentDAO();
                                     int order_count = paymentDAO.getAllPaymentOrder();
                                    %>
                                    <h3 class="fs-2"><%= order_count %></h3>
                                    <p class="fs-5">Order</p>
                                </div>
                                <i class="fas fa-truck fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                                <div>
                                    <%
                                   
                                    double total = paymentDAO.getAllTotalPrice();
                                    
                                    %>
                                    <h3 class="fs-2">$<%= total %></h3>
                                    <p class="fs-5">Revenue</p>
                                </div>
                                <i class="fas fa-chart-line fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                            </div>
                        </div>
                    </div>

                    <div class="row my-5">
                        <h3 class="fs-4 mb-3">Recent Orders</h3>
                        <div class="col">
                            <table class="table bg-white rounded shadow-sm  table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col" width="50">#</th>
                                        <th scope="col">Payment ID</th>
                                        <th scope="col">User ID</th>
                                        <th scope="col">Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        ResultSet set = paymentDAO.getAllPayment();
                                        AtomicInteger count = new AtomicInteger(1);
                                        while (set.next()) {
                                    %>
                                    <tr>
                                        <th scope="row"><%= count.getAndIncrement() %></th>
                                        <td><%= set.getString("payment_id") %></td>
                                        <td><%= set.getString("user_id") %></td>
                                        <td>$<%= set.getFloat("total_price")  %></td>
                                    </tr>

                                    <%
                                        }
                                    %>



                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!--/#page-content-wrapper--> 
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        var el = document.getElementById("wrapper");
        var toggleButton = document.getElementById("menu-toggle");

        toggleButton.onclick = function () {
            el.classList.toggle("toggled");
        };
    </script>
    <%            }
    %>
</body>

</html>