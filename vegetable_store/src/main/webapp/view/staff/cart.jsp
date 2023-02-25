<%@page import="com.DAO.CartDAO"%>
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



                <div class="row my-5">
                    <h3 class="fs-4 mb-3">Recent Orders</h3>
                    <%
                        if (request.getParameter("delete_cart") != null) {
                            if (request.getParameter("delete_cart").equals("1")) {
                    %>
                    <div class="alert alert-success alert-dismissible fade show">
                        <strong>Success!</strong> Delete  success.
                    </div>
                    <%
                    } else if (request.getParameter("delete_cart").equals("2")) {
                    %>
                    <div class="alert alert-danger">
                        <strong>Danger!</strong> Delete fail
                    </div>
                    <%
                            }
                        }
                    %>
                    <div style="padding: 20px 10px" class="col  bg-white rounded shadow-sm  table-hover">
                        <table id="example" class="display" style="width:100%">
                            <thead>
                                <tr>
                                    <th>Cart ID</th>
                                    <th>User</th>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    CartDAO cdao = new CartDAO();
                                    String id = request.getParameter("id");
                                    ResultSet elem = cdao.getAllCartByID(id);
                                    while (elem.next()) {
                                %>
                                <tr>
                                    <td><%= elem.getString("cart_id")%></td>
                                    <td><%= elem.getString("user_id")%></td>
                                    <td><%= elem.getString("product_id")%></td>
                                    <td>Quantity</td>
                                    <td>Price</td>
                                    <td>
                                        <ul class="list-inline m-0">
                                            <li class="list-inline-item">
                                                <a class="btn btn-primary" href="<%= request.getContextPath()%>/staff/cart/order?id=<%= elem.getString("cart_id")%>" >Accept</a>
                                            </li>
                                            <li class="list-inline-item">
                                                <a class="btn btn-primary" href="<%= request.getContextPath()%>/staff/cart/delete?id=<%= elem.getString("cart_id")%>" >Delete</a>
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
                                    <th>Cart ID</th>
                                    <th>User</th>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
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