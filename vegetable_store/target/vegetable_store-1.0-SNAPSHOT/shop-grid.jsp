
<%@page import="com.models.Cart"%>
<%@page import="com.models.GenerateID"%>
<%@page import="com.DAO.CartDAO"%>
<%@page import="com.models.User"%>
<%@page import="com.DAO.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.models.Product"%>
<%@page import="com.DAO.ProductDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.DAO.CateogoryDAO"%>
<jsp:include page="header.jsp" />
<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="/img/breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Organi Shop</h2>
                    <div class="breadcrumb__option">
                        <a href="/">Home</a>
                        <span>Shop</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Product Section Begin -->
<section class="product spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-5">
                <div class="sidebar">
                    <div class="sidebar__item">
                        <h4>Department</h4>
                        <ul>
                            <%
                                CateogoryDAO cdao = new CateogoryDAO();
                                ResultSet set = cdao.getAllCategory();
                                while (set.next()) {
                            %>
                            <li><a href="?id=<%= set.getString("catagory_id")%>" ><%= set.getString("category_name")%></a></li>
                                <%
                                    }
                                %>
                        </ul>
                    </div>
                    <div class="sidebar__item">
                        <h4>Price</h4>
                        <div class="price-range-wrap">
                            <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                 data-min="0" data-max="540">
                                <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
                                <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                                <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                            </div>
                            <div class="range-slider">
                                <form action="#" method="post">
                                    <div class="price-input">
                                        <input type="text" id="minamount" name="minamount">
                                        <input type="text" id="maxamount" name="maxamount">
                                        <input type="submit" class="alert-info" name="btn_sort_price" value="Apply" />
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
            <div class="col-lg-9 col-md-7">



                <div class="filter__item">
                    <div class="row">
                        <div class="col-lg-4 col-md-5">
                            <div class="filter__sort">
                                <span>Sort By</span>
                                <select>
                                    <option value="0">Default</option>
                                    <option value="0">Default</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4">
                            <%
                                ProductDAO dAO = new ProductDAO();
                                int count_product = dAO.countProduct();
                            %>
                            <div class="filter__found">
                                <h6><span>
                                        <%= count_product%>
                                    </span> Products found</h6>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-3">
                            <div class="filter__option">
                                <span class="icon_grid-2x2"></span>
                                <span class="icon_ul"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">


                    <%
                        if (request.getParameter("order") != null) {
                            String email = session.getAttribute("name").toString();
                            UserDAO userDAO = new UserDAO();
                            User user = userDAO.getUserByEmail(email);
                            String product_id = request.getParameter("order");
                            CartDAO cartDAO = new CartDAO();
                            int check = 0;
                            if (cartDAO.checkIDCartInProduct(product_id)) {
                                GenerateID generateID = new GenerateID();
                                Cart cart = new Cart(generateID.generateCart(), 1, product_id, user.getUser_id());
                                ProductDAO productDAO = new ProductDAO();
                                check = productDAO.addToCardProduct(cart);
                            } else {
                                Cart cart = cartDAO.getCartByProduct(product_id);
                                ProductDAO productDAO = new ProductDAO();
                                check = productDAO.addToCardProduct(cart.getQuantity() + 1, product_id);
                            }

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

                    <%                        if (request.getParameter("minamount") != null && request.getParameter("maxamount") != null && request.getParameter("id") != null) {
                            String min = request.getParameter("minamount").substring(1);
                            String max = request.getParameter("maxamount").substring(1);
                            String category_id = request.getParameter("id");
                            ProductDAO productDAO = new ProductDAO();
                            ResultSet resultSet = productDAO.getProductByPriceByCategory(Float.valueOf(min), Float.valueOf(max), category_id);
                            while (resultSet.next()) {
                    %>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="/img/product/<%= resultSet.getString("image")%>">
                                <ul class="product__item__pic__hover">
                                    <%
                                        if (session.getAttribute("login_done") != null) {
                                    %>
                                    <li><a href="<%= request.getContextPath()%>?order=<%= resultSet.getString("product_id")%>"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                            } else {
                                            %>
                                    <li><a href="/account/login"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                                }
                                            %>
                                </ul>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#"><%= resultSet.getString("product_name")%></a></h6>
                                <h5>$<%= resultSet.getString("selling_price")%></h5>
                            </div>
                        </div>
                    </div>
                    <%
                        }

                    } else if (request.getParameter("minamount") != null && request.getParameter("maxamount") != null) {
                        String min = request.getParameter("minamount").substring(1);
                        String max = request.getParameter("maxamount").substring(1);
                        ProductDAO pdao = new ProductDAO();
                        ResultSet set1 = pdao.getProductByPrice(Float.valueOf(min), Float.valueOf(max));
                        while (set1.next()) {
                    %>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="/img/product/<%= set1.getString("image")%>">
                                <ul class="product__item__pic__hover">

                                    <%
                                        if (session.getAttribute("login_done") != null) {
                                    %>
                                    <li><a href="<%= request.getContextPath()%>?order=<%= set1.getString("product_id")%>"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                            } else {
                                            %>
                                    <li><a href="/account/login"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                                }
                                            %>


                                </ul>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#"><%= set1.getString("product_name")%></a></h6>
                                <h5>$<%= set1.getString("selling_price")%></h5>
                            </div>
                        </div>
                    </div>

                    <%
                            }
                        }
                    %>




                    <%
                        if (request.getParameter("id") != null) {
                            String category_id = request.getParameter("id");
                            ProductDAO pdao = new ProductDAO();
                            ResultSet rs = pdao.getAllProductByCategory(category_id);
                            while (rs.next()) {
                    %>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="/img/product/<%= rs.getString("image")%>">
                                <ul class="product__item__pic__hover">
                                    <%
                                        if (session.getAttribute("login_done") != null) {
                                    %>
                                    <li><a href="<%= request.getContextPath()%>?order=<%= rs.getString("product_id")%>"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                            } else {
                                            %>
                                    <li><a href="/account/login"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                                }
                                            %>
                                </ul>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#"><%= rs.getString("product_name")%></a></h6>
                                <h5>$<%= rs.getString("selling_price")%></h5>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                        ProductDAO pdao = new ProductDAO();
                        ResultSet rs = pdao.getAllProduct();
                        while (rs.next()) {
                    %>

                    <div class="col-lg-4 col-md-6 col-sm-6">
                        <div class="product__item">
                            <div class="product__item__pic set-bg" data-setbg="/img/product/<%= rs.getString("image")%>">
                                <ul class="product__item__pic__hover">
                                    <%
                                        if (session.getAttribute("login_done") != null) {
                                    %>
                                    <li><a href="<%= request.getContextPath()%>?order=<%= rs.getString("product_id")%>"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                            } else {
                                            %>
                                    <li><a href="/account/login"><i class="fa fa-shopping-cart"></i></a></li>
                                            <%
                                                }
                                            %>
                                </ul>
                            </div>
                            <div class="product__item__text">
                                <h6><a href="#"><%= rs.getString("product_name")%></a></h6>
                                <h5>$<%= rs.getString("selling_price")%></h5>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <%
                    }

                %>


            </div>

        </div>

    </div>
</section>
<!-- Product Section End -->
<jsp:include page="footer.jsp" />