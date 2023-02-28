<%@page import="com.DAO.ProductDAO"%>
<%@page import="java.sql.ResultSet"%>
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
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.2/css/jquery.dataTables.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.13.2/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#example').DataTable();
            });

        </script>
        <script>
            $(document).ready(function () {
                $('#example1').DataTable();
            });

        </script>
    </head>

    <body>
        <%

            if (session.getAttribute("admin") == null) {
                response.sendRedirect(request.getContextPath() + "/account/login");
            } else {

        %>
        <jsp:include page="../admin/sliderandnav.jsp" />


        <div class="container-fluid px-4">
            <div class="row g-3 my-2">
                <div class="col-md-3">
                    <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                        <div>
                            <h3 class="fs-2"></h3>
                            <p class="fs-5">Product</p>
                        </div>
                        <!--<i class="fa-solid fa-user"></i>-->
                        <i class="fas fa-user me-2 fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                        <div>
                            <h3 class="fs-2"></h3>
                            <p class="fs-5">Category</p>
                        </div>
                        <i class="fas fa-user me-2 fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                        <div>
                            <a href="<%= request.getContextPath()%>/admin/manage/product/addproduct"><button type="button" class="btn btn-primary btn-lg">Add</button></a>
                            <p class="fs-5">Add product</p>
                        </div>
                        <i class="fas fa-truck fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                        <div>
                            <a href="<%= request.getContextPath()%>/admin/manage/product/addcategory"><button type="button" class="btn btn-primary btn-lg">Add</button></a>
                            <p class="fs-5">Add category</p>
                        </div>
                        <i class="fas fa-truck fs-1 primary-text border rounded-full secondary-bg p-3"></i>
                    </div>
                </div>
            </div>

            <div class="row my-5">
                <h3 class="fs-4 mb-3">Product</h3>
                <%
                    if (request.getParameter("success") != null) {
                        if (request.getParameter("success").equals("1")) {
                %>
                <div class="alert alert-success alert-dismissible fade show">
                    <strong>Success!</strong> Delete product success.
                </div>
                <%
                } else if (request.getParameter("success").equals("2")) {
                %>
                <div class="alert alert-success alert-dismissible fade show">
                    <strong>Success!</strong> Delete category success.
                </div>
                <%
                        }
                    }
                    if (request.getParameter("fail") != null) {
                        if (request.getParameter("fail").equals("1")) {
                %>
                <div class="alert alert-danger">
                    <strong>Danger!</strong> Delete product fail
                </div>
                <%
                } else if (request.getParameter("fail").equals("2")) {
                %>
                <div class="alert alert-danger">
                    <strong>Danger!</strong> Delete category fail
                </div>
                <%
                        }
                    }

                    if (request.getParameter("update_product") != null) {
                %>
                <div class="alert alert-success alert-dismissible fade show">
                    <strong>Success!</strong> Edited product success.
                </div>
                <%
                } else if (request.getParameter("update_product_fail") != null) {
                %>
                <div class="alert alert-danger">
                    <strong>Danger!</strong> Edited product fail.
                </div>
                <%
                    }
                     if (request.getParameter("update_category") != null) {
                %>
                <div class="alert alert-success alert-dismissible fade show">
                    <strong>Success!</strong> Edited category success.
                </div>
                <%
                } else if (request.getParameter("update_category_fail") != null) {
                %>
                <div class="alert alert-danger">
                    <strong>Danger!</strong> Edited category fail.
                </div>
                <%
                    }
                %>
                
                
                <%
                    if (request.getParameter("add_product") != null) {
                %>
                <div class="alert alert-success alert-dismissible fade show">
                    <strong>Success!</strong> Added product success.
                </div>
                <%
                } else if (request.getParameter("add_product_fail") != null) {
                %>
                <div class="alert alert-danger">
                    <strong>Danger!</strong> Add fail
                </div>

                <%
                    }

                %>

                <%                    if (request.getParameter("add_category") != null) {
                %>
                <div class="alert alert-success alert-dismissible fade show">
                    <strong>Success!</strong> Added category success.
                </div>
                <%
                } else if (request.getParameter("add_category_fail") != null) {
                %>
                <div class="alert alert-danger">
                    <strong>Danger!</strong> Add category fail.
                </div>

                <%
                    }

                %>

                <div  style="padding: 20px 10px" class=" col bg-white rounded shadow-sm  table-hover"   >
                    <table id="example" class="hover"  style="width:100%">
                        <thead>
                            <tr>
                                <th>Product id</th>
                                <th>Product name</th>
                                <th>Price</th>
                                <th>Category</th>
                                <th>Description</th>
                                <th>Quantity</th>
                                <th>Image</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%                                        ProductDAO aO = new ProductDAO();
                                ResultSet set = aO.getAllProduct();
//                                       
                                while (set.next()) {
                            %>
                            <tr>
                                <td><%= set.getString("product_id")%></td>
                                <td><%= set.getString("product_name")%></td>
                                <td><%= set.getString("selling_price")%></td>
                                <td><%= set.getString("category_name")%></td>
                                <td><%= aO.usingSubstringMethod(set.getString("product_desc"), 20)%></td>
                                <td><%= set.getString("quantity")%></td>

                                <td>
                                    <img style="width: 50px; height: 50px" src="/img/product/<%= set.getString("image")%>" alt="alt"/>
                                </td>
                                <td>
                                    <!-- Call to action buttons -->
                                    <ul class="list-inline m-0">
                                        <li class="list-inline-item">
                                            <a href="<%= request.getContextPath()%>/admin/manage/product/editproduct?id=<%= set.getString("product_id")%>"><button class="btn btn-success btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="Edit"><i class="fa fa-edit"></i></button></a>
                                        </li>
                                        <li class="list-inline-item">
                                            <a href="<%= request.getContextPath()%>/admin/manage/product/deleteproduct?id=<%= set.getString("product_id")%>"><button class="btn btn-danger btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i></button></a>
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
                                <th>Product id</th>
                                <th>Product name</th>
                                <th>Price</th>
                                <th>Category</th>
                                <th>Description</th>
                                <th>Quantity</th>
                                <th>Image</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                    </table>
                </div>

            </div>

            <h4>Category</h4>
            <div style="padding: 20px 10px" class=" col bg-white rounded shadow-sm  table-hover"  >
                <table id="example1" class="hover"  style="width:100%">
                    <thead>
                        <tr>
                            <th>Category id</th>
                            <th>Category name</th>
                            <th>Category Image</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            ResultSet resultSet = aO.getAllCategory();
                            while (resultSet.next()) {
                        %>
                        <tr>
                            <td><%= resultSet.getString("catagory_id")%></td>
                            <td><%= resultSet.getString("category_name")%></td>
                            <td>
                                <img src="/img/categories/<%= resultSet.getString("image") %>" width="50px" height="50px" alt="alt"/>
                            </td>
                            <td>
                                <!-- Call to action buttons -->
                                <ul class="list-inline m-0">
                                    <li class="list-inline-item">
                                        <a href="<%= request.getContextPath()%>/admin/manage/product/editcategory?id=<%= resultSet.getString("catagory_id")%>"><button class="btn btn-success btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="Edit"><i class="fa fa-edit"></i></button></a>
                                    </li>
                                    <li class="list-inline-item">
                                        <a href="<%= request.getContextPath()%>/admin/manage/product/deletecategory?id=<%= resultSet.getString("catagory_id")%>"><button class="btn btn-danger btn-sm rounded-0" type="button" data-toggle="tooltip" data-placement="top" title="Delete"><i class="fa fa-trash"></i></button></a>
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
                            <th>Category id</th>
                            <th>Category name</th>
                            <th>Category Image</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>
                </table>
            </div>


        </div>


        <!--/#page-content-wrapper--> 


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