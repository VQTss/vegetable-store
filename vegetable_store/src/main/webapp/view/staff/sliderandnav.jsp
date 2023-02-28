<%@page import="com.models.User"%>
<%@page import="com.DAO.UserDAO"%>
<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect(request.getContextPath() + "/account/login");
    } else {
        String email = session.getAttribute("name").toString();
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);


%>

<!-- Sidebar -->
<div class="bg-white" id="sidebar-wrapper">
    <div class="sidebar-heading text-center py-4 primary-text fs-4 fw-bold text-uppercase border-bottom">
        <img src="/view/admin/logo.png" alt="alt"/></div>
    <div class="list-group list-group-flush my-3">
        <a href="<%= request.getContextPath() %>/login/staff" class="list-group-item list-group-item-action bg-transparent second-text active"><i
                class="fas fa-tachometer-alt me-2"></i>Dashboard</a>
        <a href="/account/logout" class="list-group-item list-group-item-action bg-transparent text-danger fw-bold"><i
                class="fas fa-power-off me-2"></i>Logout</a>
    </div>
</div>
<!-- /#sidebar-wrapper -->

<!-- Page Content -->
<div id="page-content-wrapper">
    <nav class="navbar navbar-expand-lg navbar-light bg-transparent py-4 px-4">
        <div class="d-flex align-items-center">
            <i class="fas fa-align-left primary-text fs-4 me-3" id="menu-toggle"></i>
            
        </div>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle second-text fw-bold" href="#" id="navbarDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user me-2"></i><%= user.getFull_name()%>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="/account/logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>

    <%
        }
    %>

