<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.buddhi.oceanviewresort.model.entity.Reservation" %>
            <%@ page import="java.time.format.DateTimeFormatter" %>
                <% String username=(String) session.getAttribute("username"); String role=(String)
                    session.getAttribute("role"); if (username==null) { response.sendRedirect(request.getContextPath()
                    + "/Auth/Login.jsp" ); return; } %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Generate Bill - Ocean View Resort</title>
                        <style>
                            * {
                                margin: 0;
                                padding: 0;
                                box-sizing: border-box;
                            }

                            body {
                                font-family: 'Poppins', 'Segoe UI', sans-serif;
                                background: #1a1a1a;
                                color: #fff;
                                overflow-x: hidden;
                            }

                            /* Sidebar Navigation */
                            .sidebar {
                                position: fixed;
                                left: 0;
                                top: 0;
                                width: 260px;
                                height: 100vh;
                                background: #0d0d0d;
                                border-right: 1px solid rgba(255, 255, 255, 0.05);
                                z-index: 1000;
                                display: flex;
                                flex-direction: column;
                            }

                            .sidebar-header {
                                padding: 30px 25px;
                                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                            }

                            .logo {
                                font-size: 24px;
                                font-weight: 700;
                                color: #fff;
                                letter-spacing: 1px;
                                text-transform: lowercase;
                                margin-bottom: 5px;
                            }

                            .logo span {
                                color: #c9a55c;
                            }

                            .logo-subtitle {
                                font-size: 10px;
                                letter-spacing: 2px;
                                text-transform: uppercase;
                                color: rgba(255, 255, 255, 0.4);
                            }

                            .sidebar-menu {
                                flex: 1;
                                padding: 20px 0;
                                overflow-y: auto;
                            }

                            .menu-section {
                                margin-bottom: 30px;
                            }

                            .menu-title {
                                font-size: 10px;
                                letter-spacing: 2px;
                                text-transform: uppercase;
                                color: rgba(255, 255, 255, 0.4);
                                padding: 0 25px;
                                margin-bottom: 10px;
                            }

                            .menu-item {
                                display: flex;
                                align-items: center;
                                gap: 15px;
                                padding: 14px 25px;
                                color: rgba(255, 255, 255, 0.7);
                                text-decoration: none;
                                transition: all 0.3s;
                                font-size: 13px;
                                border-left: 3px solid transparent;
                            }

                            .menu-item:hover {
                                background: rgba(255, 255, 255, 0.05);
                                color: #c9a55c;
                                border-left-color: #c9a55c;
                            }

                            .menu-item.active {
                                background: rgba(201, 165, 92, 0.1);
                                color: #c9a55c;
                                border-left-color: #c9a55c;
                            }

                            .menu-icon {
                                font-size: 18px;
                                width: 20px;
                                text-align: center;
                            }

                            .sidebar-footer {
                                padding: 20px 25px;
                                border-top: 1px solid rgba(255, 255, 255, 0.05);
                            }

                            .user-info {
                                display: flex;
                                align-items: center;
                                gap: 12px;
                                margin-bottom: 15px;
                            }

                            .user-avatar {
                                width: 40px;
                                height: 40px;
                                border-radius: 50%;
                                background: linear-gradient(135deg, #c9a55c, #f4e5c3);
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                font-weight: 600;
                                color: #1a1a1a;
                            }

                            .user-details {
                                flex: 1;
                            }

                            .user-name {
                                font-size: 13px;
                                font-weight: 600;
                                margin-bottom: 2px;
                            }

                            .user-role {
                                font-size: 10px;
                                letter-spacing: 1px;
                                text-transform: uppercase;
                                color: rgba(255, 255, 255, 0.4);
                            }

                            .logout-btn {
                                width: 100%;
                                padding: 10px;
                                background: rgba(255, 255, 255, 0.05);
                                border: 1px solid rgba(255, 255, 255, 0.1);
                                border-radius: 6px;
                                color: rgba(255, 255, 255, 0.7);
                                font-size: 11px;
                                letter-spacing: 1px;
                                text-transform: uppercase;
                                cursor: pointer;
                                transition: all 0.3s;
                            }

                            .logout-btn:hover {
                                background: rgba(220, 53, 69, 0.1);
                                border-color: rgba(220, 53, 69, 0.3);
                                color: #ff6b6b;
                            }

                            /* Main Content */
                            .main-content {
                                margin-left: 260px;
                                min-height: 100vh;
                            }




                            .section-number {
                                font-size: 64px;
                                font-weight: 300;
                                color: rgba(255, 255, 255, 0.1);
                                line-height: 1;
                                margin-top: 30px;
                            }

                            .nav-dots {
                                display: flex;
                                flex-direction: column;
                                gap: 15px;
                                margin-top: 50px;
                            }

                            .dot {
                                width: 8px;
                                height: 8px;
                                border-radius: 50%;
                                background: rgba(255, 255, 255, 0.3);
                                cursor: pointer;
                                transition: all 0.3s;
                            }

                            .dot.active {
                                background: #c9a55c;
                                transform: scale(1.4);
                            }

                            .social-links {
                                display: flex;
                                flex-direction: column;
                                gap: 20px;
                                margin-bottom: 30px;
                            }

                            .social-links a {
                                color: rgba(255, 255, 255, 0.5);
                                font-size: 18px;
                                transition: all 0.3s;
                                text-decoration: none;
                            }

                            .social-links a:hover {
                                color: #c9a55c;
                            }



                            .top-nav {
                                position: fixed;
                                top: 0;
                                right: 0;
                                left: 140px;
                                background: rgba(13, 13, 13, 0.95);
                                backdrop-filter: blur(10px);
                                padding: 30px 80px;
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                z-index: 999;
                                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                            }

                            .location {
                                color: rgba(255, 255, 255, 0.6);
                                font-size: 12px;
                                letter-spacing: 2px;
                                text-transform: uppercase;
                            }

                            .nav-menu {
                                display: flex;
                                gap: 50px;
                                list-style: none;
                            }

                            .nav-menu a {
                                color: rgba(255, 255, 255, 0.7);
                                text-decoration: none;
                                font-size: 13px;
                                letter-spacing: 2px;
                                text-transform: uppercase;
                                transition: all 0.3s;
                                position: relative;
                            }

                            .nav-menu a:hover,
                            .nav-menu a.active {
                                color: #c9a55c;
                            }

                            .nav-menu a::after {
                                content: '';
                                position: absolute;
                                bottom: -5px;
                                left: 0;
                                width: 0;
                                height: 1px;
                                background: #c9a55c;
                                transition: width 0.3s;
                            }

                            .nav-menu a:hover::after {
                                width: 100%;
                            }

                            /* Specific Styles for Bill Generation */
                            .reservation-container {
                                padding: 150px 80px 80px;
                                max-width: 1600px;
                                margin: 0 auto;
                            }

                            .page-header {
                                text-align: center;
                                margin-bottom: 80px;
                            }

                            .page-label {
                                font-size: 11px;
                                letter-spacing: 4px;
                                text-transform: uppercase;
                                color: #c9a55c;
                                margin-bottom: 20px;
                                font-weight: 500;
                            }

                            .page-title {
                                font-size: 72px;
                                font-weight: 300;
                                letter-spacing: 8px;
                                text-transform: uppercase;
                                margin-bottom: 30px;
                                line-height: 1.2;
                            }

                            .page-description {
                                font-size: 15px;
                                line-height: 1.8;
                                color: rgba(255, 255, 255, 0.7);
                                max-width: 700px;
                                margin: 0 auto;
                                font-weight: 300;
                            }

                            .bill-grid {
                                display: grid;
                                grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
                                gap: 25px;
                                margin-bottom: 40px;
                            }

                            .bill-card {
                                background: rgba(255, 255, 255, 0.02);
                                border: 1px solid rgba(255, 255, 255, 0.05);
                                border-radius: 12px;
                                overflow: hidden;
                                transition: all 0.3s;
                                display: flex;
                                flex-direction: column;
                                height: 100%;
                            }

                            .bill-card:hover {
                                transform: translateY(-5px);
                                border-color: rgba(201, 165, 92, 0.3);
                                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                            }

                            .card-header {
                                padding: 20px;
                                background: rgba(255, 255, 255, 0.02);
                                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                flex-shrink: 0;
                            }

                            .res-no {
                                font-size: 12px;
                                letter-spacing: 1px;
                                color: #c9a55c;
                                font-weight: 600;
                            }

                            .status {
                                font-size: 10px;
                                text-transform: uppercase;
                                letter-spacing: 1px;
                                padding: 4px 10px;
                                border-radius: 10px;
                                background: rgba(255, 255, 255, 0.1);
                            }

                            .status.confirmed {
                                color: #51cf66;
                                background: rgba(81, 207, 102, 0.1);
                                border: 1px solid rgba(81, 207, 102, 0.2);
                            }

                            .card-body {
                                padding: 25px 20px;
                                flex: 1;
                                display: flex;
                                flex-direction: column;
                            }

                            .guest-name {
                                font-size: 18px;
                                margin-bottom: 5px;
                                color: #fff;
                                font-weight: 500;
                            }

                            .guest-detail {
                                font-size: 13px;
                                color: rgba(255, 255, 255, 0.5);
                                margin-bottom: 20px;
                            }

                            .stay-details {
                                display: flex;
                                justify-content: space-between;
                                margin-bottom: auto;
                                padding: 15px;
                                background: rgba(0, 0, 0, 0.2);
                                border-radius: 8px;
                            }

                            .stay-item {
                                text-align: center;
                                flex: 1;
                            }

                            .stay-label {
                                display: block;
                                font-size: 10px;
                                text-transform: uppercase;
                                color: rgba(255, 255, 255, 0.4);
                                margin-bottom: 5px;
                                letter-spacing: 1px;
                            }

                            .stay-value {
                                font-size: 14px;
                                color: #fff;
                                font-weight: 500;
                            }

                            .card-footer {
                                padding: 20px;
                                border-top: 1px solid rgba(255, 255, 255, 0.05);
                                text-align: center;
                                flex-shrink: 0;
                            }

                            .btn-generate {
                                background: #c9a55c;
                                color: #1a1a1a;
                                border: none;
                                padding: 12px 25px;
                                border-radius: 25px;
                                font-size: 11px;
                                letter-spacing: 1px;
                                text-transform: uppercase;
                                font-weight: 600;
                                cursor: pointer;
                                transition: all 0.3s;
                                width: 100%;
                            }

                            .btn-generate:hover {
                                background: #dcb363;
                                transform: translateY(-2px);
                                box-shadow: 0 5px 15px rgba(201, 165, 92, 0.2);
                            }

                            .alert {
                                padding: 15px;
                                margin-bottom: 30px;
                                border-radius: 8px;
                                border: 1px solid transparent;
                            }

                            .alert-success {
                                background: rgba(81, 207, 102, 0.1);
                                border-color: rgba(81, 207, 102, 0.2);
                                color: #51cf66;
                            }

                            .alert-error {
                                background: rgba(220, 53, 69, 0.1);
                                border-color: rgba(220, 53, 69, 0.2);
                                color: #dc3545;
                            }

                            @media (max-width: 768px) {
                                .sidebar {
                                    transform: translateX(-100%);
                                }

                                .sidebar.mobile-open {
                                    transform: translateX(0);
                                }

                                .main-content {
                                    margin-left: 0;
                                }

                                .reservation-container {
                                    padding: 20px;
                                }

                                .page-title {
                                    font-size: 32px;
                                }

                                .bill-grid {
                                    grid-template-columns: 1fr;
                                }
                            }
                        </style>
                    </head>

                    <body>
                        <!-- Sidebar -->
                        <aside class="sidebar" id="sidebar">
                            <div class="sidebar-header">
                                <div class="logo">ocean<span>.view</span></div>
                                <div class="logo-subtitle">Resort Management</div>
                            </div>

                            <nav class="sidebar-menu">
                                <div class="menu-section">
                                    <div class="menu-title">Main Menu</div>
                                    <a href="${pageContext.request.contextPath}/Dashboard/StaffDashboard.jsp"
                                        class="menu-item">
                                        <span class="menu-icon">📊</span>
                                        <span>Dashboard</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/reservation-servlet" class="menu-item">
                                        <span class="menu-icon">📅</span>
                                        <span>Reservations</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/Reservation/CreateReservation.jsp"
                                        class="menu-item">
                                        <span class="menu-icon">➕</span>
                                        <span>New Reservation</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/user-servlet?action=list"
                                        class="menu-item">
                                        <span class="menu-icon">👥</span>
                                        <span>Guests</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/room-servlet?action=list"
                                        class="menu-item">
                                        <span class="menu-icon">🛏️</span>
                                        <span>Rooms</span>
                                    </a>
                                </div>

                                <div class="menu-section">
                                    <div class="menu-title">Reports & Billing</div>
                                    <a href="${pageContext.request.contextPath}/bill-servlet" class="menu-item active">
                                        <span class="menu-icon">💰</span>
                                        <span>Billing</span>
                                    </a>
                                    <a href="reports.jsp" class="menu-item">
                                        <span class="menu-icon">📈</span>
                                        <span>Reports</span>
                                    </a>
                                </div>

                                <% if ("STAFF".equals(role)) { %>
                                    <div class="menu-section">
                                        <div class="menu-title">Administration</div>
                                        <a href="users.jsp" class="menu-item">
                                            <span class="menu-icon">👔</span>
                                            <span>User Management</span>
                                        </a>
                                        <a href="settings.jsp" class="menu-item">
                                            <span class="menu-icon">⚙️</span>
                                            <span>Settings</span>
                                        </a>
                                    </div>
                                    <% } %>
                            </nav>

                            <div class="sidebar-footer">
                                <div class="user-info">
                                    <div class="user-avatar">
                                        <%= username !=null ? username.substring(0, 1).toUpperCase() : "U" %>
                                    </div>
                                    <div class="user-details">
                                        <div class="user-name">
                                            <%= username %>
                                        </div>
                                        <div class="user-role">
                                            <%= role %>
                                        </div>
                                    </div>
                                </div>
                                <form action="${pageContext.request.contextPath}/LogoutServlet" method="post"
                                    style="margin: 0;">
                                    <button type="submit" class="logout-btn">🚪 Logout</button>
                                </form>
                            </div>
                        </aside>

                        <!-- Main Content -->
                        <main class="main-content">
                            <div class="reservation-container">
                                <div class="page-header">
                                    <div class="page-label">Billing Management</div>
                                    <h1 class="page-title">Generate<br>Bills</h1>
                                    <p class="page-description">
                                        Manage guest billing and invoicing. Generate bills for confirmed reservations
                                        based
                                        on stay duration and room type.
                                    </p>
                                </div>

                                <% String msg=(String) session.getAttribute("message"); String msgType=(String)
                                    session.getAttribute("messageType"); if (msg !=null) { %>
                                    <div class="alert alert-<%= msgType %>">
                                        <%= msg %>
                                    </div>
                                    <% session.removeAttribute("message"); session.removeAttribute("messageType"); } %>

                                        <div class="bill-grid">
                                            <% List<Reservation> reservations = (List<Reservation>)
                                                    request.getAttribute("reservations");
                                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd");

                                                    if (reservations != null) {
                                                    for (Reservation r : reservations) {
                                                    // Only show valid reservations for billing (e.g., Confirmed)
                                                    // User requirement: "must have before created all reservations"
                                                    // We can show all, but disable button if not confirmed maybe?
                                                    // Let's show all for now as requested.
                                                    boolean isConfirmed = "CONFIRMED".equalsIgnoreCase(r.getStatus());
                                                    %>
                                                    <div class="bill-card">
                                                        <div class="card-header">
                                                            <span class="res-no">
                                                                <%= r.getReservationNo() %>
                                                            </span>
                                                            <span class="status <%= isConfirmed ? " confirmed" : "" %>">
                                                                <%= r.getStatus() !=null ? r.getStatus() : "Pending" %>
                                                            </span>
                                                        </div>
                                                        <div class="card-body">
                                                            <h3 class="guest-name">
                                                                <%= r.getGuestName() %>
                                                            </h3>
                                                            <p class="guest-detail">
                                                                <%= r.getGuestEmail() %>
                                                            </p>
                                                            <div class="stay-details">
                                                                <div class="stay-item">
                                                                    <span class="stay-label">Check-In</span>
                                                                    <span class="stay-value">
                                                                        <%= r.getCheckInDate().format(formatter) %>
                                                                    </span>
                                                                </div>
                                                                <div class="stay-item">
                                                                    <span class="stay-label">Guests</span>
                                                                    <span class="stay-value">
                                                                        <%= r.getNumGuests() %>
                                                                    </span>
                                                                </div>
                                                                <div class="stay-item">
                                                                    <span class="stay-label">Check-Out</span>
                                                                    <span class="stay-value">
                                                                        <%= r.getCheckOutDate().format(formatter) %>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="card-footer">
                                                            <form
                                                                action="${pageContext.request.contextPath}/bill-servlet"
                                                                method="GET">
                                                                <input type="hidden" name="action" value="generate">
                                                                <input type="hidden" name="reservationNo"
                                                                    value="<%= r.getReservationNo() %>">
                                                                <button type="submit" class="btn-generate"
                                                                    <%=!isConfirmed
                                                                    ? "disabled style='opacity:0.5; cursor:not-allowed'"
                                                                    : "" %>>
                                                                    <%= isConfirmed ? "Generate Bill"
                                                                        : "Confirm Reservation First" %>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                    <% } } else { %>
                                                        <div
                                                            style="grid-column: 1/-1; text-align: center; opacity: 0.5; padding: 50px;">
                                                            No reservations found to generate bills.
                                                        </div>
                                                        <% } %>
                                        </div>
                            </div>
                        </main>
                    </body>

                    </html>