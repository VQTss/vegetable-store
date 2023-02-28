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
                <div class="header__cart__price">item: <span>$150.00</span></div>
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
                    <li class="active"><a href="./index.jsp">Home</a></li>
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
                        <div class="col-lg-6">
                            <div class="header__top__left">
                                <ul>
                                    <li><i class="fa fa-envelope"></i> hello@fpt.edu.vn</li>
                                    <li>Free Shipping for all Order of $99</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="header__top__right">

                                <div class="header__top__right__auth">
                                    <a href="account/sign-up"><i class="fa fa-user-plus nav-item active" aria-hidden="false"></i>Sign-up</a>
                                </div>
                                <div class="header__top__right__auth">

                                </div>
                                <div class="header__top__right__auth">
                                    <a href="account/login"><i class="fa fa-user"></i> Login</a>
                                </div>
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
                                <li><a href="./index.jsp">Home</a></li>
                                <li><a href="./shop-grid.jsp">Shop</a></li>
                                <li><a href="#">Pages</a>
                                    <ul class="header__menu__dropdown">
                                        <li><a href="./shop-details.jsp">Shop Details</a></li>
                                        <li><a href="./shoping-cart.jsp">Shoping Cart</a></li>
                                        <li><a href="./checkout.jsp">Check Out</a></li>
                                        <li><a href="./blog-details.jsp">Blog Details</a></li>
                                    </ul>
                                </li>
                                <li class="active"><a href="./blog.jsp">Blog</a></li>
                                <li><a href="./contact.jsp">Contact</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3">
                        <div class="header__cart">
                            <ul>
                                <li><a href="#"><i class="fa fa-shopping-bag"></i> <span>0</span></a></li>
                            </ul>
                            <div class="header__cart__price">item: <span>$150.00</span></div>
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
        <section class="hero hero-normal">
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
                    </div>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->