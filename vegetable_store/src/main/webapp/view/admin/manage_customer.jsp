<%@page import="java.sql.ResultSet"%>
<%@page import="com.DAO.UserDAO"%>
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
        <title>Manage customer</title>
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
                    <a href="<%= request.getContextPath()%>/login/admin" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-tachometer-alt me-2"></i>Dashboard Admin</a>
                    <a href="<%= request.getContextPath()%>/admin/manage/customer" class="list-group-item list-group-item-action bg-transparent second-text active"><i
                            class="fas fa-project-diagram me-2"></i>Manage customer</a>
                    <a href="<%= request.getContextPath()%>/admin/manage/staff" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-chart-line me-2"></i>Manage staff</a>
                    <a href="#" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-paperclip me-2"></i>Reports</a>
                    <a href="#" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-shopping-cart me-2"></i>Store Mng</a>
                    <a href="#" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-gift me-2"></i>Products</a>
                    <a href="#" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-comment-dots me-2"></i>Chat</a>
                    <a href="#" class="list-group-item list-group-item-action bg-transparent second-text fw-bold"><i
                            class="fas fa-map-marker-alt me-2"></i>Outlet</a>
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
                        <h2 class="fs-2 m-0">Hello!</h2>
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

                %>
                <div class="container-fluid px-4">
                    <div class="row g-3 my-2">
                        <div class="col-md-4">
                            <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                                <div>
                                    <h3 class="fs-2"><%= countUser%></h3>
                                    <p class="fs-5">User Active</p>
                                </div>
                                <i class="fas fa-user me-2 fs-1 primary-text border rounded-full secondary-bg p-3"></i>

                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                                <div>
                                    <a href="<%= request.getContextPath()%>/admin/manage/customer/add"><button type="button" class="btn btn-primary btn-lg">Add</button></a>
                                    <p class="fs-5">New customer</p>
                                </div>
                                <i class="fas fa-address-book fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                                <div>
                                    <a href="<%= request.getContextPath()%>/admin/manage/staff/add"><button type="button" class="btn btn-primary btn-lg">Add</button></a>
                                    <p class="fs-5">New staff</p>
                                </div>
                                <i class="fas fa-address-book fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                            </div>
                        </div>

                    </div>

                    <div class="row my-5">
                        <h3 class="fs-4 mb-3">Management Account Customer</h3>
                        <%
                            if (request.getParameter("success") != null) {
                                if (request.getParameter("success").equals("1")) {
                        %>
                        <div class="alert alert-success alert-dismissible fade show">
                            <strong>Success!</strong> Delete customer success.
                        </div>
                        <%
                        } else if (request.getParameter("success").equals("2")) {
                        %>

                        <%
                                }
                            }
                            if (request.getParameter("fail") != null) {
                                if (request.getParameter("fail").equals("1")) {
                        %>
                        <div class="alert alert-danger">
                            <strong>Danger!</strong> Delete fail
                        </div>
                        <%
                        } else if (request.getParameter("fail").equals("2")) {
                        %>

                        <%
                                }
                            }

                            if (request.getParameter("edit_customer") != null) {
                        %>
                        <div class="alert alert-success alert-dismissible fade show">
                            <strong>Success!</strong> Edited customer success.
                        </div>
                        <%
                            } else {

                            }

                            if (request.getParameter("add_customer") != null) {
                        %>
                        <div class="alert alert-success alert-dismissible fade show">
                            <strong>Success!</strong> Added customer success.
                        </div>
                        <%
                        } else if (request.getParameter("add_customer_fail") != null) {
                        %>
                        <div class="alert alert-danger">
                            <strong>Danger!</strong> Add fail
                        </div>

                        <%
                            }

                        %>
                        <div style="padding: 20px 10px" class="col bg-white rounded shadow-sm  table-hover">
                            <table id="example" class="display " style="width:100%">
                                <thead>
                                    <tr>
                                        <th>User ID</th>
                                        <th>Full name</th>
                                        <th>Email</th>
                                        <th>Password</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%                                        UserDAO userDAO = new UserDAO();
                                        ResultSet rs = userDAO.getAllCustomer();
                                        while (rs.next()) {


                                    %>
                                    <tr>
                                        <td><%= rs.getString("user_id")%></td>
                                        <td><%= rs.getString("fullname")%></td>
                                        <td><%= rs.getString("email")%></td>
                                        <td><%= rs.getString("password")%></td>
                                        <td><%= rs.getString("phone")%></td>
                                        <td><%= rs.getString("address")%></td>
                                        <td>
                                            <!-- Call to action buttons -->
                                            <ul class="list-inline m-0">
                                                <li class="list-inline-item">
                                                    <a href="<%= request.getContextPath()%>/admin/manage/customer/edit?id=<%= rs.getString("user_id")%>"><button class="btn btn-success btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="Edit"><i class="fa fa-edit"></i></button></a>
                                                </li>
                                                <li class="list-inline-item">
                                                    <a href="<%= request.getContextPath()%>/admin/manage/customer/delete?id=<%= rs.getString("user_id")%>"><button class="btn btn-danger btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i></button></a>
                                                </li>
                                            </ul>
                                        </td>
                                    </tr>

                                    <%
                                        }
                                    %>

                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th>User ID</th>
                                        <th>Full name</th>
                                        <th>Email</th>
                                        <th>Password</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Action</th>
                                    </tr>
                                </tfoot>
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
    <%        }
    %>
</body>

</html>