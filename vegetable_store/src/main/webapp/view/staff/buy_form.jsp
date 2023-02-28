

<%@page import="com.models.GenerateID"%>
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
        <style>
            .order-form .container {
                color: #4c4c4c;
                padding: 20px;
                box-shadow: 0 0 10px 0 rgba(0, 0, 0, .1);
                max-width: 650px;
            }

            .order-form-label {
                margin: 8px 0 0 0;
                font-size: 14px;
                font-weight: bold;
            }

            .order-form-input,
            .form-label,
            .form-check-label {
                font-family: 'Open Sans', sans-serif;
                font-size: 14px;

            }

            .btn-submit:hover {
                background-color: #0D47A1 !important;
            }
        </style>
    </head>

    <body>

        <div class="d-flex" id="wrapper">

            <jsp:include page="../staff/sliderandnav.jsp"/>

            <div class="container-fluid px-4">

                <%
                    String order_id = request.getParameter("id");
                    GenerateID generateID = new GenerateID();
                    String payment_id = generateID.generateOrder("payment");
                    OrderDAO odao = new OrderDAO();
                    Order order = odao.getOrderByID(order_id);
                %>

                <div class="row my-5">
                    
                    <section class="order-form m-4 ">
                        <div class="container pt-4 bg-white rounded shadow-sm  table-hover">
                            <form action="StaffControllers" method="post">
                                <div class="row ">
                                    <div class="col-12 px-4">
                                        <h1 class="text-center">Order Form</h1>
                                        <hr class="mt-1" />
                                    </div>
                                    <input type="hidden" name="order_id" value="<%= order_id%>" class="form-control order-form-input" />
                                    <input type="hidden" name="payment_id" value="<%= payment_id%>" class="form-control order-form-input" />
                                    <div class="col-12">
                                        <div class="row mx-4">
                                            <div class="col-12">
                                                <label class="order-form-label">Name</label>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-outline">
                                                    <input value="<%= order.getUser_id()%>" type="text" id="form1" class="form-control order-form-input" />
                                                    <label class="form-label" for="form1">Name order</label>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 mt-2 mt-sm-0">
                                                <div class="form-outline">
                                                    <input value="<%= order.getName()%>" type="text" id="form2" class="form-control order-form-input" />
                                                    <label class="form-label" for="form2">Customer order</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mt-3 mx-4">
                                            <div class="col-12">
                                                <label class="order-form-label">Note</label>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-outline">
                                                    <input value="<%= order.getOrder_desc()%>" type="text" id="form3" class="form-control order-form-input" />
                                                </div>
                                            </div>
                                        </div>



                                        <div class="row mt-3 mx-4">
                                            <div class="col-12">
                                                <label  class="order-form-label" for="date-picker-example">Date</label>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-outline datepicker" data-mdb-toggle-button="false">
                                                    <input value="<%= order.getOrder_date()%>"
                                                           type="text" class="form-control order-form-input" id="datepicker1" data-mdb-toggle="datepicker" />
                                                    <label for="datepicker1" class="form-label">Select a date</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row mt-3 mx-4">
                                            <div class="col-12">
                                                <label class="order-form-label">Address</label>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-outline">
                                                    <input value="<%= order.getAddress()%>" type="text" id="form5" class="form-control order-form-input" />
                                                    <label class="form-label" for="form5">Street Address</label>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label class="order-form-label">Phone</label>
                                            </div>
                                            <div class="col-12 mt-2">
                                                <div class="form-outline">
                                                    <input value="<%= order.getPhone()%>" type="text" id="form6" class="form-control order-form-input" />

                                                </div>
                                            </div>

                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-12">
                                                <button type="submit" name="btn_checkout" id="btnSubmit" class="btn btn-primary d-block mx-auto btn-submit">Checkout</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </section>
                </div>
            </div>

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