<%@page import="com.models.Account"%>
<%@page import="com.DAO.AccountDAO"%>
<%@page import="com.models.User"%>
<%@page import="com.DAO.UserDAO"%>
<%@page import="com.models.GenerateID"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>DASHMIN - Bootstrap Admin Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <!-- Template Stylesheet -->
        <!-- <link href="css/style.css" rel="stylesheet"> -->
        <script type="text/javascript">
            var patt_email = /^[a-zA-Z]+\w*([.-_]\w+)*\@[a-zA-Z]+\w*([.-_]\w+)*(\.\w+)+$/;
            var patt_phone = /^0[1-9]\d{8,10}$/;

            var errorArray = [];

            function checkAllData() {
                var tk = document.getElementById("floatingText").value;
                var mk1 = document.getElementById("floatingPassword").value;
                var email = document.getElementById("floatingInput").value;
                var phone = document.getElementById("floatingPhone").value;
                var address = document.getElementById("floatingAddress").value;
                var errorArray = [];
                if (tk == "")
                    errorArray.push("Username can't be empty");
                if (mk1.length < 6 || mk1.length > 20)
                    errorArray.push("Password length must be from 6 to 20 characters");
                if (patt_email.test(email) == false)
                    errorArray.push("Email is valid");
                if (patt_phone.test(phone) == false)
                    errorArray.push("Phone number is invalid");
                if (address == "") {
                    errorArray.push("Address cannot be empty!");
                }
                var errorMessage = document.getElementById("txtError");
                if (errorArray.length != 0) {
                    var strMsg = "Please check invalid data:";
                    strMsg += "</ol>";
                    for (const index in errorArray) {
                        strMsg += "<li>" + errorArray[index] + "</li>";
                    }
                    strMsg += "</ol>";
                    errorMessage.innerHTML = strMsg;
                    errorMessage.style.color = "#f00";
                    return false;
                }
            }
        </script>
    </head>

    <body>
        <div class="container-xxl position-relative bg-white d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->
            <%
                if (session.getAttribute("admin") == null) {
                    response.sendRedirect(request.getContextPath() + "/account/login");
                } else {
            %>

            <!-- Sign Up Start -->
            <div class="container-fluid">
                <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                    <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                        <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <a href="#" class="">
                                    <h3 class="text-primary">Vegetable</h3>
                                </a>
                                <h3>Sign Up</h3>
                            </div>
                            <%
                                String id = request.getParameter("id");
                                UserDAO userDAO = new UserDAO();
                                User user = userDAO.getUserByID(id);
                                AccountDAO accountDAO = new AccountDAO();
                                Account acc = accountDAO.checkExitsAccount(user.getEmail());
                            %>
                            <p class="error" id="txtError"></p> 
                            <form action="AdminController" method="post"  onsubmit = "return checkAllData()">
                                <div class="form-floating mb-3">
                                    <input type="hidden" name="id" class="form-control" id="floatingText" readonly  value="<%= id%>" ">
                                </div>
                                <div class="form-floating mb-3">
                                    <label for="floatingText">Full name</label>
                                    <input type="text" name="full_name" class="form-control" id="floatingText" value="<%= user.getFull_name()%>"  placeholder="" />
                                </div>
                                <div class="form-floating mb-3">
                                    <label for="floatingInput">Email address</label>
                                    <input type="email" name="email" class="form-control" id="floatingInput" readonly value="<%= user.getEmail()%>" placeholder="name@example.com">
                                </div>
                                <div class="form-floating mb-4">
                                    <label for="floatingPassword">Password</label>
                                    <input type="password" name="password" class="form-control" id="floatingPassword" value="<%= acc.getPassword()%>"  placeholder="Password">
                                </div>
                                <div class="form-floating mb-3">
                                    <label for="floatingInput">Phone</label>
                                    <input type="text" name="phone" class="form-control" id="floatingPhone" value="<%= user.getPhone()%>" placeholder="0123456789">
                                </div>
                                <div class="form-floating mb-3">
                                    <label for="floatingInput">Address</label>
                                    <input type="text" name="address" class="form-control" value="<%= user.getAddress()%>" id="floatingAddress" >
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="hidden" name="role_id" class="form-control" id="floatingInput" readonly value="customer" >
                                </div>
                                <div class="d-flex align-items-center justify-content-between mb-4">
                                </div>
                                <button type="submit" name="btn_update_customer" value="Sign Up" class="btn btn-primary py-3 w-100 mb-4">Update</button>
                            </form>
                          

                        </div>

                    </div>
                </div>
            </div>
            <!-- Sign Up End -->
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template Javascript -->
        <!-- <script src="js/main.js"></script> -->
        <%
            }

        %>


    </body>

</html>