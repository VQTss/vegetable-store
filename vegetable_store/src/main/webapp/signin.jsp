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
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <script type="text/javascript">
            var patt_email = /^[a-zA-Z]+\w*([.-_]\w+)*\@[a-zA-Z]+\w*([.-_]\w+)*(\.\w+)+$/;
            var patt_phone = /^0[1-9]\d{8,10}$/;

            var errorArray = [];

            function checkAllData() {

                var mk1 = document.getElementById("floatingPassword").value;
                var email = document.getElementById("floatingInput").value;


                var errorArray = [];

                if (mk1.length < 6 || mk1.length > 20)
                    errorArray.push("Password length must be from 6 to 20 characters");

                if (patt_email.test(email) == false)
                    errorArray.push("Email is valid");

                var errorMessage = document.getElementById("txtError");
                if (errorArray.length != 0) //khong co loi xay ra
                {
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


            <!-- Sign In Start -->
            <div class="container-fluid">
                <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                    <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                        <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
                            <div class="d-flex align-items-center justify-content-between mb-3">
                                <a href="#" class="">
                                    <h3 class="text-primary">Vegetable</h3>
                                </a>
                                <h3>Sign In</h3>
                            </div>
                            <%
                                if (request.getParameter("success") != null) {
                            %>
                            <div class="alert alert-success alert-dismissible fade show">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                <strong>Success!</strong> You are sign-up success. You can sign-in
                            </div>
                            <%
                            } else if (request.getParameter("fail") != null) {
                                if (request.getParameter("fail").equals("1")) {
                            %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <strong>Danger!</strong> Account or password is wrong.
                            </div>
                            <%
                            } else if (request.getParameter("fail").equals("2")) {
                            %>
                            <div class="alert alert-danger alert-dismissible fade show">
                                <strong>Danger!</strong> Please sign-in or sign-up 
                            </div>
                            <%
                                    }
                                }
                            %>
                            <p class="error" id="txtError"></p> 
                            <form action="AccountController" method="POST"  onsubmit = "return checkAllData()">
                                <div class="form-floating mb-3">
                                    <label for="floatingInput">Email address</label>
                                    <input type="email" name="email" class="form-control" id="floatingInput" placeholder="name@example.com">
                                </div>
                                <div class="form-floating mb-4">
                                    <label for="floatingPassword">Password</label>
                                    <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password">

                                </div>
                                <div class="d-flex align-items-center justify-content-between mb-4">
                                    <div class="form-check">
                                        <input type="checkbox" name="remember_me" class="form-check-input" id="exampleCheck1">
                                        <label class="form-check-label" for="exampleCheck1">Remember me?</label>
                                    </div>
                                </div>
                                <button type="submit" name="btn_signin" value="Sign In" class="btn btn-primary py-3 w-100 mb-4">Sign In</button>
                            </form>
                            <p class="text-center mb-0">Don't have an Account? <a href="/account/sign-up">Sign Up</a></p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Sign In End -->
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
        <script src="js/main.js"></script>
    </body>

</html>