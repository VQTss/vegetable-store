
<%@page import="com.models.Product"%>
<%@page import="com.DAO.ProductDAO"%>
<%@page import="com.models.User"%>
<%@page import="com.DAO.UserDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.DAO.CartDAO"%>
<jsp:include page="header.jsp" />


<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section set-bg" data-setbg="/img/breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Shopping Cart</h2>
                    <div class="breadcrumb__option">
                        <a href="/">Home</a>
                        <span>Shopping Cart</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Breadcrumb Section End -->

<!-- Shoping Cart Section Begin -->
<section class="shoping-cart spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="shoping__cart__table">
                    <table>
                        <thead>
                            <tr>
                                <th class="shoping__product">Products</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        <form  action="/product"method="post" >
                            <%
                                CartDAO cartDAO = new CartDAO();
                                if (request.getParameter("id") != null) {
                                    String cart_id = request.getParameter("id");
                                    cartDAO.deleteCart(cart_id);
                                }
                                String email = session.getAttribute("name").toString();
                                UserDAO userDAO = new UserDAO();
                                User user = userDAO.getUserByEmail(email);
                                ResultSet resultSet = cartDAO.getAllCartByID(user.getUser_id());
                                float total = cartDAO.totalProduct(user.getUser_id());

                                while (resultSet.next()) {
                                    ProductDAO productDAO = new ProductDAO();
                                    Product product = productDAO.getProductById(resultSet.getString("product_id"));
                            %>
                            <tr>
                                <td class="shoping__cart__item">
                                    <img width="50px" height="50px" src="/img/product/<%= product.getImage()%>" alt="">
                                    <h5><%= product.getProduct_name()%></h5>
                                </td>
                            <input type="hidden" id="id" name="product_id" value="<%= resultSet.getString("product_id")  %>">
                                <td class="shoping__cart__price">
                                    $<%= product.getSelling_price()%>
                                </td>
                                <td class="shoping__cart__quantity">
                                    <div class="quantity">
                                        <div class="pro-qty">
                                            <input type="text" name="quantity" value="<%= resultSet.getInt("quantity")%>">
                                        </div>
                                    </div>
                                </td>
                                <td class="shoping__cart__total">
                                    $<%= product.getSelling_price() * resultSet.getInt("quantity")%>
                                </td>
                                <td class="shoping__cart__item__close">
                                    <a href="?id=<%= resultSet.getString("cart_id")%>"><span class="icon_close"></span></a>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="shoping__cart__btns">
                    <a href="<%= request.getContextPath() %>/product/all" class="primary-btn cart-btn">CONTINUE SHOPPING</a>
                        <input type="submit" value="Upadate Cart" class="primary-btn cart-btn cart-btn-right" name="update_cart">
                    </form>
                </div>
            </div>
            <div class="col-lg-6">
            </div>
            <div class="col-lg-6">
                <div class="shoping__checkout">
                    <h5>Cart Total</h5>
                    <ul>
                        <li>Subtotal <span>$<%= total%></span></li>
                        <li>Total <span>$<%= total%></span></li>
                    </ul>
                    <a href="<%= request.getContextPath() %>/product/payment?id=<%= user.getUser_id() %>" class="primary-btn">PROCEED TO CHECKOUT</a>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Shoping Cart Section End -->

<jsp:include page="footer.jsp" />