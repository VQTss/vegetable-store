

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

        <div class="d-flex" id="wrapper">

            <jsp:include page="../staff/sliderandnav.jsp"/>

            <div class="container-fluid px-4">
                <div class="row g-3 my-2">
                    <div class="col-md-4">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <%
                                    ProductDAO aO = new ProductDAO();
                                    int sum_product = aO.countProduct();
                                %>
                                <h3 class="fs-2"><%= sum_product%></h3>
                                <p class="fs-5">Products</p>
                            </div>
                            <i class="fas fa-gift fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <%
                                    CateogoryDAO c = new CateogoryDAO();
                                    int sum_category = c.countCategory();
                                %>
                                <h3 class="fs-2"><%= sum_category%></h3>
                                <p class="fs-5">Category</p>
                            </div>
                            <i
                                class="fas fa-hand-holding-usd fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <%
                                    OrderDAO aO1 = new OrderDAO();
                                    int new_order = aO1.countOrderIsPaymented();
                                %>
                                <h3 class="fs-2"><%= new_order%></h3>

                                <p class="fs-5">New order</p>
                            </div>
                            <i class="fas fa-truck fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                        </div>
                    </div>


                </div>

                <div class="row my-5">
                    <h3 class="fs-4 mb-3">Recent Orders</h3>
                    <%
                        if (request.getParameter("success") != null) {
                    %>
                    <div class="alert alert-success alert-dismissible fade show">
                        <strong>Success!</strong> Payment success.
                    </div>
                    <%
                    } else if (request.getParameter("fail") != null) {
                    %>
                    <div class="alert alert-danger">
                        <strong>Danger!</strong> Payment fail
                    </div>
                    <%
                        }
                        if (request.getParameter("delete_success") != null) {
                    %>
                    <div class="alert alert-success alert-dismissible fade show">
                        <strong>Success!</strong> Cancel success.
                    </div>
                    <%
                    } else if (request.getParameter("delete_success_fail") != null) {
                    %>
                    <div class="alert alert-danger">
                        <strong>Danger!</strong> Cancel fail
                    </div>
                    <%
                        }
                    %>
                    <div style="padding: 20px 10px" class="col  bg-white rounded shadow-sm  table-hover">
                        <table id="example" class="display" style="width:100%">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Name</th>
                                    <th>Order date</th>
                                    <th>Note</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    OrderDAO dAO = new OrderDAO();
                                    ResultSet elem = dAO.getRecentOrder();

                                    while (elem.next()) {
                                        if (elem.getString("payment_id") == null) {
                                %>
                                <tr>
                                    <td><%= elem.getString("order_id")%></td>
                                    <td><%= elem.getString("name")%></td>
                                    <td><%= elem.getDate("order_date")%></td>
                                    <td><%= elem.getString("order_desc")%></td>
                                    <td>
                                        <ul class="list-inline m-0">
                                            <li class="list-inline-item">
                                                <a href="<%= request.getContextPath()%>/staff/order/buy?id=<%= elem.getString("order_id")%>"><button class="btn btn-success btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="Edit">Accept</button></a>
                                            </li>
                                            <li class="list-inline-item">
                                                <a href="<%= request.getContextPath()%>/staff/order/delete?id=<%= elem.getString("order_id")%>"><button class="btn btn-danger btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="Delete">Delete</button></a>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                                <%
                                        }
                                    }

                                %>

                            </tbody>
                            <tfoot>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Name</th>
                                    <th>Order date</th>
                                    <th>Note</th>
                                    <th>Action</th>
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