<%@page import="com.DAO.CartDAO"%>
<%@page import="com.models.GenerateID"%>
<%@page import="com.models.Cart"%>
<%@page import="com.models.User"%>
<%@page import="com.DAO.UserDAO"%>
<%@page import="com.DAO.ProductDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.DAO.CateogoryDAO"%>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Ogani | Template</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
    </head>

    <body>
        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>


        <!-- Humberger Begin -->
        <div class="humberger__menu__overlay"></div>
        <div class="humberger__menu__wrapper">
            <div class="humberger__menu__logo">
                <a href="#"><img src="img/logo.png" alt=""></a>
            </div>
            <div class="humberger__menu__cart">
                <ul>
                    <li><a href="#"><i class="fa fa-heart"></i> <span>1</span></a></li>
                    <li><a href="#"><i class="fa fa-shopping-bag"></i> <span>3</span></a></li>
                </ul>
            </div>
            <div class="humberger__menu__widget">
                <div class="header__top__right__auth">
                    <a href="#"><i class="fa fa-user-plus nav-item active" aria-hidden="false"></i>Sign-in</a>
                </div>
                <div class="header__top__right__auth">
                    <a href="#"><i class="fa fa-user"></i> Login</a>
                </div>
            </div>
            <nav class="humberger__menu__nav mobile-menu">
                <ul>
                    <li class="active"><a href="/">Home</a></li>
                    <li><a href="./shop-grid.jsp">Shop</a></li>
                    <li><a href="#">Pages</a>
                        <ul class="header__menu__dropdown">
                            <li><a href="./shop-details.jsp">Shop Details</a></li>
                            <li><a href="./shoping-cart.jsp">Shoping Cart</a></li>
                            <li><a href="./checkout.jsp">Check Out</a></li>
                            <li><a href="./blog-details.jsp">Blog Details</a></li>
                        </ul>
                    </li>
                    <li><a href="./blog.jsp">Blog</a></li>
                    <li><a href="./contact.jsp">Contact</a></li>
                </ul>
            </nav>
            <div id="mobile-menu-wrap"></div>
            <div class="humberger__menu__contact">
                <ul>
                    <li><i class="fa fa-envelope"></i> hello@fpt.edu.vn</li>
                    <li>Free Shipping for all Order of $99</li>
                </ul>
            </div>
        </div>
        <!-- Humberger End -->

        <!-- Header Section Begin -->
        <header class="header">
            <div class="header__top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-6">
                            <div class="header__top__left">
                                <ul>
                                    <li><i class="fa fa-envelope"></i> hello@fpt.edu.vn</li>
                                    <li>Free Shipping for all Order of $99</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="header__top__right">

                                <%
                                    if (session.getAttribute("login_done") != null) {

                                        if (session.getAttribute("login_done").equals("customer")) {
                                %>
                                <div class="header__top__right__auth">
                                    <a href="/login/customer"><i class="fa fa-user"></i> Dashboard</a>
                                </div>

                                <%
                                    }
                                } else {
                                %>
                                <div class="header__top__right__auth">
                                    <a href="account/sign-up"><i class="fa fa-user-plus nav-item active" aria-hidden="false"></i>Sign-up</a>
                                </div>
                                <div class="header__top__right__auth">

                                </div>
                                <div class="header__top__right__auth">
                                    <a href="account/login"><i class="fa fa-user"></i> Login</a>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="header__logo">
                            <a href="./index.jsp"><img src="img/logo.png" alt=""></a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <nav class="header__menu">
                            <ul>
                                <li class="active"><a href="/">Home</a></li>
                                <li><a href="/product/all">Shop</a></li>
                                <li><a href="/product/blog">Blog</a></li>
                                <li><a href="/product/contact">Contact</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3">
                        <div class="header__cart">
                            <%
                                if (session.getAttribute("login_done") != null) {

                                    if (session.getAttribute("login_done").equals("customer")) {
                                        CartDAO cartDAO = new CartDAO();
                                        String email = session.getAttribute("name").toString();
                                        UserDAO userDAO = new UserDAO();
                                        User user = userDAO.getUserByEmail(email);
                                        int count = cartDAO.countCartProductByCustomer(user.getUser_id());
                                        float total = cartDAO.totalProduct(user.getUser_id());
                            %>
                             <ul>
                                <li><a href="/product/cart"><i class="fa fa-shopping-bag"></i><span><%= count %></span></a></li>
                            </ul>
                                <div class="header__cart__price">item: <span>$<%= total %></span></div>
                            <%                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
                <div class="humberger__open">
                    <i class="fa fa-bars"></i>
                </div>
            </div>
        </header>
        <!-- Header Section End -->

        <!-- Hero Section Begin -->
        <section class="hero">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="hero__categories">
                            <div class="hero__categories__all">
                                <i class="fa fa-bars"></i>
                                <span>All departments</span>
                            </div>
                            <ul>
                                <%
                                    CateogoryDAO cdao = new CateogoryDAO();
                                    ResultSet set = cdao.getAllCategory();
                                    while (set.next()) {
                                %>
                                <li><a href="<%= set.getString("catagory_id")%>"><%= set.getString("category_name")%></a></li>
                                    <%
                                        }
                                    %>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="hero__search">
                            <div class="hero__search__form">
                                <form action="#">
                                    <div class="hero__search__categories">
                                        All Categories
                                        <span class="arrow_carrot-down"></span>
                                    </div>
                                    <input type="text" placeholder="What do yo u need?">
                                    <button type="submit" class="site-btn">SEARCH</button>
                                </form>
                            </div>
                            <div class="hero__search__phone">
                                <div class="hero__search__phone__icon">
                                    <i class="fa fa-phone"></i>
                                </div>
                                <div class="hero__search__phone__text">
                                    <h5>+65 11.188.888</h5>
                                    <span>support 24/7 time</span>
                                </div>
                            </div>
                        </div>
                        <div class="hero__item set-bg" data-setbg="img/hero/banner.jpg">
                            <div class="hero__text">
                                <span>FRUIT FRESH</span>
                                <h2>Vegetable <br />100% Organic</h2>
                                <p>Free Pickup and Delivery Available</p>
                                <a href="#" class="primary-btn">SHOP NOW</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->

        <%
            if (request.getParameter("id") != null) {
                String email = session.getAttribute("name").toString();
                UserDAO userDAO = new UserDAO();
                User user = userDAO.getUserByEmail(email);
                String product_id = request.getParameter("id");
                GenerateID generateID = new GenerateID();
                Cart cart = new Cart(generateID.generateCart(), 1, product_id, user.getUser_id());
                ProductDAO productDAO = new ProductDAO();
                int check = productDAO.addToCardProduct(cart);
                if (check != 0) {
        %>
        <script>
            window.alert("Add to cart success");
        </script>
        <%
        } else {
        %>
        <script>
            window.alert("Add to cart fail");
        </script>
        <%
                }
            }

        %>


        <!-- Categories Section Begin -->
        <section class="categories">
            <div class="container">
                <div class="row">
                    <div class="categories__slider owl-carousel">

                        <%                            ResultSet rs = cdao.getAllCategory();
                            while (rs.next()) {
                        %>
                        <div class="col-lg-3">
                            <div class="categories__item set-bg" data-setbg="img/categories/<%= rs.getString("image")%>">
                                <h5><a href="<%= rs.getString("catagory_id")%>"><%= rs.getString("category_name")%></a></h5>
                            </div>
                        </div>

                        <%
                            }
                        %>


                    </div>
                </div>
            </div>
        </section>
        <!-- Categories Section End -->

        <!-- Featured Section Begin -->
        <section class="featured spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <h2>Featured Product</h2>
                        </div>
                        <div class="featured__controls">
                            <ul>
                                <li class="active" data-filter="*">All</li>
                                    <%
                                        ResultSet set1 = cdao.getAllCategory();
                                        while (set1.next()) {
                                    %>
                                <li data-filter=".<%= set1.getString("catagory_id")%>"><%= set1.getString("category_name")%></li>
                                    <%
                                        }
                                    %>

                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row featured__filter">
                    <%
                        ResultSet set2 = cdao.getAllCategory();
                        int count = 0;
                        while (set2.next()) {

                            ProductDAO pdao = new ProductDAO();
                            ResultSet set3 = pdao.getAllProductByCategory(set2.getString("catagory_id"));
                            while (set3.next()) {
                                if (count < 3) {
                                    count++;
                    %>
                    <div class="col-lg-3 col-md-4 col-sm-6 mix <%= set3.getString("catagory_id")%>">
                        <div class="featured__item">
                            <div class="featured__item__pic set-bg" data-setbg="img/product/<%= set3.getString("product.image")%>">
                                <ul class="featured__item__pic__hover">
                                    <%
                                        if (session.getAttribute("login_done") != null) {
                                    %>
                                    <li><a href="<%= request.getContextPath()%>?id=<%= set3.getString("product_id")%>"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                            } else {
                                            %>
                                    <li><a href="/account/login"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                                }
                                            %>
                                </ul>
                            </div>

                            <div class="featured__item__text">
                                <h6><a href="#"><%= set3.getString("product_name")%></a></h6>
                                <h5>$<%= set3.getString("selling_price")%></h5>
                            </div>
                        </div>
                    </div>
                    <%
                                } else {
                                    count = 0;
                                    break;
                                }
                            }
                        }
                    %>
                </div>
            </div>
        </section>
        <!-- Featured Section End -->

        <!-- Banner Begin -->
        <div class="banner">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="banner__pic">
                            <img src="img/banner/banner-1.jpg" alt="">
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 col-sm-6">
                        <div class="banner__pic">
                            <img src="img/banner/banner-2.jpg" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Banner End -->



        <!-- Blog Section Begin -->
        <section class="from-blog spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title from-blog__title">
                            <h2>From The Blog</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="img/blog/blog-1.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                    <li><i class="fa fa-comment-o"></i> 5</li>
                                </ul>
                                <h5><a href="#">Cooking tips make cooking simple</a></h5>
                                <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam quaerat </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="img/blog/blog-2.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                    <li><i class="fa fa-comment-o"></i> 5</li>
                                </ul>
                                <h5><a href="#">6 ways to prepare breakfast for 30</a></h5>
                                <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam quaerat </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-6">
                        <div class="blog__item">
                            <div class="blog__item__pic">
                                <img src="img/blog/blog-3.jpg" alt="">
                            </div>
                            <div class="blog__item__text">
                                <ul>
                                    <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                                    <li><i class="fa fa-comment-o"></i> 5</li>
                                </ul>
                                <h5><a href="#">Visit the clean farm in the US</a></h5>
                                <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam quaerat </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Blog Section End -->

        <jsp:include page="footer.jsp"/>