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
                        <title>View Reservations - Ocean View Resort</title>
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
                                left: 260px;
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

                            .actions-bar {
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                margin-bottom: 40px;
                            }

                            .search-box {
                                position: relative;
                                flex: 1;
                                max-width: 400px;
                            }

                            .search-box input {
                                width: 100%;
                                background: rgba(255, 255, 255, 0.05);
                                border: 1px solid rgba(255, 255, 255, 0.1);
                                border-radius: 25px;
                                padding: 15px 25px 15px 50px;
                                color: #fff;
                                font-size: 13px;
                                transition: all 0.3s;
                            }

                            .search-box input:focus {
                                outline: none;
                                border-color: #c9a55c;
                                background: rgba(201, 165, 92, 0.05);
                            }

                            .search-icon {
                                position: absolute;
                                left: 20px;
                                top: 50%;
                                transform: translateY(-50%);
                                font-size: 16px;
                                color: rgba(255, 255, 255, 0.4);
                            }

                            .btn {
                                padding: 15px 40px;
                                font-size: 11px;
                                letter-spacing: 2px;
                                text-transform: uppercase;
                                border: none;
                                border-radius: 30px;
                                cursor: pointer;
                                transition: all 0.3s;
                                font-weight: 600;
                                text-decoration: none;
                                display: inline-block;
                            }

                            .btn-primary {
                                background: #c9a55c;
                                color: #1a1a1a;
                                box-shadow: 0 10px 30px rgba(201, 165, 92, 0.3);
                            }

                            .btn-primary:hover {
                                transform: translateY(-3px);
                                box-shadow: 0 15px 40px rgba(201, 165, 92, 0.5);
                            }

                            .table-container {
                                background: rgba(255, 255, 255, 0.02);
                                border: 1px solid rgba(255, 255, 255, 0.05);
                                border-radius: 8px;
                                overflow: hidden;
                            }

                            .reservations-table {
                                width: 100%;
                                border-collapse: collapse;
                            }

                            .reservations-table thead {
                                background: rgba(201, 165, 92, 0.1);
                            }

                            .reservations-table th {
                                padding: 20px 15px;
                                text-align: left;
                                font-size: 11px;
                                letter-spacing: 2px;
                                text-transform: uppercase;
                                color: #c9a55c;
                                font-weight: 600;
                                border-bottom: 2px solid rgba(201, 165, 92, 0.3);
                            }

                            .reservations-table td {
                                padding: 20px 15px;
                                font-size: 13px;
                                color: rgba(255, 255, 255, 0.8);
                                border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                            }

                            .reservations-table tbody tr {
                                transition: all 0.3s;
                            }

                            .reservations-table tbody tr:hover {
                                background: rgba(201, 165, 92, 0.05);
                            }

                            .reservation-no {
                                color: #c9a55c;
                                font-weight: 600;
                            }

                            .status-badge {
                                display: inline-block;
                                padding: 5px 12px;
                                border-radius: 12px;
                                font-size: 10px;
                                letter-spacing: 1px;
                                text-transform: uppercase;
                                font-weight: 600;
                            }

                            .status-upcoming {
                                background: rgba(81, 207, 102, 0.1);
                                color: #51cf66;
                                border: 1px solid rgba(81, 207, 102, 0.3);
                            }

                            .status-active {
                                background: rgba(255, 211, 61, 0.1);
                                color: #ffd93d;
                                border: 1px solid rgba(255, 211, 61, 0.3);
                            }

                            .status-completed {
                                background: rgba(150, 150, 150, 0.1);
                                color: #999;
                                border: 1px solid rgba(150, 150, 150, 0.3);
                            }

                            .btn-action {
                                padding: 8px 16px;
                                font-size: 10px;
                                letter-spacing: 1.5px;
                                text-transform: uppercase;
                                border: none;
                                border-radius: 20px;
                                cursor: pointer;
                                transition: all 0.3s;
                                font-weight: 600;
                                text-decoration: none;
                                display: inline-block;
                                margin-right: 8px;
                            }

                            .btn-edit {
                                background: rgba(52, 152, 219, 0.1);
                                color: #3498db;
                                border: 1px solid rgba(52, 152, 219, 0.3);
                            }

                            .btn-edit:hover {
                                background: rgba(52, 152, 219, 0.2);
                                border-color: #3498db;
                                transform: translateY(-2px);
                            }

                            .btn-delete {
                                background: rgba(231, 76, 60, 0.1);
                                color: #e74c3c;
                                border: 1px solid rgba(231, 76, 60, 0.3);
                            }

                            .btn-delete:hover {
                                background: rgba(231, 76, 60, 0.2);
                                border-color: #e74c3c;
                                transform: translateY(-2px);
                            }

                            .action-buttons {
                                display: flex;
                                gap: 8px;
                                align-items: center;
                            }

                            .alert {
                                padding: 18px 25px;
                                border-radius: 6px;
                                margin-bottom: 30px;
                                font-size: 13px;
                                letter-spacing: 1px;
                                display: flex;
                                align-items: center;
                                gap: 15px;
                            }

                            .alert-success {
                                background: rgba(40, 167, 69, 0.1);
                                border: 1px solid rgba(40, 167, 69, 0.3);
                                color: #28a745;
                            }

                            .alert-error {
                                background: rgba(220, 53, 69, 0.1);
                                border: 1px solid rgba(220, 53, 69, 0.3);
                                color: #dc3545;
                            }

                            .empty-state {
                                text-align: center;
                                padding: 80px 40px;
                            }

                            .empty-icon {
                                font-size: 64px;
                                margin-bottom: 20px;
                                opacity: 0.3;
                            }

                            .empty-text {
                                font-size: 18px;
                                color: rgba(255, 255, 255, 0.5);
                                margin-bottom: 30px;
                            }

                            @media (max-width: 768px) {
                                .sidebar {
                                    width: 80px;
                                    padding: 30px 15px;
                                }

                                .main-content {
                                    margin-left: 80px;
                                }

                                .top-nav {
                                    left: 80px;
                                    padding: 20px 30px;
                                }

                                .nav-menu {
                                    display: none;
                                }

                                .reservation-container {
                                    padding: 120px 30px 60px;
                                }

                                .page-title {
                                    font-size: 42px;
                                }

                                .actions-bar {
                                    flex-direction: column;
                                    gap: 20px;
                                }

                                .search-box {
                                    max-width: 100%;
                                }

                                .table-container {
                                    overflow-x: auto;
                                }

                                .reservations-table {
                                    min-width: 800px;
                                }
                            }

                            /* Modal Styles */
                            .modal-overlay {
                                display: none;
                                position: fixed;
                                top: 0;
                                left: 0;
                                width: 100%;
                                height: 100%;
                                background: rgba(0, 0, 0, 0.8);
                                backdrop-filter: blur(5px);
                                z-index: 2000;
                                justify-content: center;
                                align-items: center;
                            }

                            .modal-card {
                                background: #1a1a1a;
                                border: 1px solid #c9a55c;
                                padding: 40px;
                                border-radius: 15px;
                                text-align: center;
                                max-width: 400px;
                                width: 90%;
                                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
                                animation: slideIn 0.3s ease-out;
                            }

                            @keyframes slideIn {
                                from {
                                    transform: translateY(50px);
                                    opacity: 0;
                                }

                                to {
                                    transform: translateY(0);
                                    opacity: 1;
                                }
                            }

                            .modal-icon {
                                font-size: 48px;
                                color: #c9a55c;
                                margin-bottom: 20px;
                            }

                            .modal-title {
                                font-size: 24px;
                                color: #fff;
                                margin-bottom: 10px;
                                text-transform: uppercase;
                                letter-spacing: 2px;
                            }

                            .modal-message {
                                color: rgba(255, 255, 255, 0.7);
                                margin-bottom: 30px;
                                line-height: 1.6;
                            }

                            .modal-actions {
                                display: flex;
                                gap: 15px;
                                justify-content: center;
                            }

                            .btn-close-modal {
                                background: transparent;
                                border: 1px solid rgba(255, 255, 255, 0.2);
                                color: #fff;
                            }

                            .btn-confirm {
                                background: rgba(255, 211, 61, 0.1);
                                color: #ffd93d;
                                border: 1px solid rgba(255, 211, 61, 0.3);
                            }

                            .btn-confirm:hover {
                                background: rgba(255, 211, 61, 0.2);
                                border-color: #ffd93d;
                                transform: translateY(-2px);
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
                                    <a href="${pageContext.request.contextPath}/reservation-servlet"
                                        class="menu-item active">
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
                                    <a href="${pageContext.request.contextPath}/bill-servlet" class="menu-item">
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
                                    <div class="page-label">Reservation Management</div>
                                    <h1 class="page-title">All<br>Reservations</h1>
                                    <p class="page-description">
                                        View and manage all guest reservations at Ocean View Resort.
                                        Track check-ins, check-outs, and guest information.
                                    </p>
                                </div>

                                <div class="actions-bar">
                                    <div class="search-box">
                                        <span class="search-icon">🔍</span>
                                        <input type="text" id="searchInput"
                                            placeholder="Search by name, email, or reservation number...">
                                    </div>
                                    <a href="${pageContext.request.contextPath}/Reservation/CreateReservation.jsp"
                                        class="btn btn-primary">
                                        + New Reservation
                                    </a>
                                </div>

                                <%-- Display Status Messages --%>
                                    <% String deleteStatus=(String) request.getAttribute("deleteStatus"); String
                                        deleteMessage=(String) request.getAttribute("deleteMessage"); String
                                        updateStatus=(String) request.getAttribute("updateStatus"); String
                                        updateMessage=(String) request.getAttribute("updateMessage"); if
                                        ("success".equals(deleteStatus)) { %>
                                        <div class="alert alert-success">
                                            ✓ <%= deleteMessage !=null ? deleteMessage : "Operation successful" %>
                                        </div>
                                        <% } else if ("error".equals(deleteStatus)) { %>
                                            <div class="alert alert-error">
                                                ⚠️ <%= deleteMessage !=null ? deleteMessage : "An error occurred" %>
                                            </div>
                                            <% } %>

                                                <% if ("success".equals(updateStatus)) { %>
                                                    <div class="alert alert-success">
                                                        ✓ <%= updateMessage !=null ? updateMessage
                                                            : "Reservation updated successfully" %>
                                                    </div>
                                                    <% } else if ("error".equals(updateStatus)) { %>
                                                        <div class="alert alert-error">
                                                            ⚠️ <%= updateMessage !=null ? updateMessage
                                                                : "Failed to update reservation" %>
                                                        </div>
                                                        <% } %>

                                                            <div class="table-container">
                                                                <% List<Reservation> reservations = (List<Reservation>)
                                                                        request.getAttribute("reservations");
                                                                        DateTimeFormatter formatter =
                                                                        DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");

                                                                        if (reservations != null &&
                                                                        !reservations.isEmpty())
                                                                        {
                                                                        %>
                                                                        <table class="reservations-table"
                                                                            id="reservationsTable">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th>Reservation No.</th>
                                                                                    <th>Guest Name</th>
                                                                                    <th>Email</th>
                                                                                    <th>Phone</th>
                                                                                    <th>Check-In</th>
                                                                                    <th>Check-Out</th>
                                                                                    <th>Guests</th>
                                                                                    <th>Status</th>
                                                                                    <th>Actions</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <% for (Reservation reservation :
                                                                                    reservations) { String
                                                                                    status="upcoming" ; String
                                                                                    statusClass="status-upcoming" ;
                                                                                    java.time.LocalDateTime
                                                                                    now=java.time.LocalDateTime.now();
                                                                                    if
                                                                                    (now.isAfter(reservation.getCheckInDate())
                                                                                    &&
                                                                                    now.isBefore(reservation.getCheckOutDate()))
                                                                                    { status="active" ;
                                                                                    statusClass="status-active" ; } else
                                                                                    if
                                                                                    (now.isAfter(reservation.getCheckOutDate()))
                                                                                    { status="completed" ;
                                                                                    statusClass="status-completed" ; }
                                                                                    %>
                                                                                    <tr class="reservation-row">
                                                                                        <td><span
                                                                                                class="reservation-no">
                                                                                                <%= reservation.getReservationNo()
                                                                                                    %>
                                                                                            </span></td>
                                                                                        <td>
                                                                                            <%= reservation.getGuestName()
                                                                                                %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= reservation.getGuestEmail()
                                                                                                %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= reservation.getPhoneNo()
                                                                                                %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= reservation.getCheckInDate().format(formatter)
                                                                                                %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= reservation.getCheckOutDate().format(formatter)
                                                                                                %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= reservation.getNumGuests()
                                                                                                %>
                                                                                        </td>
                                                                                        <td><span
                                                                                                class="status-badge <%= statusClass %>">
                                                                                                <%= status %>
                                                                                            </span></td>
                                                                                        <td>
                                                                                            <div class="action-buttons">
                                                                                                <% if
                                                                                                    (!"CONFIRMED".equals(reservation.getStatus()))
                                                                                                    { %>
                                                                                                    <form method="POST"
                                                                                                        action="${pageContext.request.contextPath}/reservation-servlet"
                                                                                                        style="display: inline;">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="action"
                                                                                                            value="confirm">
                                                                                                        <input
                                                                                                            type="hidden"
                                                                                                            name="reservationNo"
                                                                                                            value="<%= reservation.getReservationNo() %>">
                                                                                                        <button
                                                                                                            type="submit"
                                                                                                            class="btn-action btn-confirm">Confirm</button>
                                                                                                    </form>
                                                                                                    <% } %>

                                                                                                        <a href="${pageContext.request.contextPath}/reservation-servlet?edit=<%= reservation.getReservationNo() %>"
                                                                                                            class="btn-action btn-edit">Edit</a>
                                                                                                        <form
                                                                                                            method="POST"
                                                                                                            action="${pageContext.request.contextPath}/reservation-servlet"
                                                                                                            style="display: inline;"
                                                                                                            onsubmit="return confirm('Are you sure you want to delete this reservation?');">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="action"
                                                                                                                value="delete">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="reservationNo"
                                                                                                                value="<%= reservation.getReservationNo() %>">
                                                                                                            <button
                                                                                                                type="submit"
                                                                                                                class="btn-action btn-delete">Delete</button>
                                                                                                        </form>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <% } %>
                                                                            </tbody>
                                                                        </table>
                                                                        <% } else { %>
                                                                            <div class="empty-state">
                                                                                <div class="empty-icon">📋</div>
                                                                                <div class="empty-text">No reservations
                                                                                    found</div>
                                                                                <a href="${pageContext.request.contextPath}/Reservation/CreateReservation.jsp"
                                                                                    class="btn btn-primary">
                                                                                    Create First Reservation
                                                                                </a>
                                                                            </div>
                                                                            <% } %>
                                                            </div>
                            </div>
                        </main>

                        <script>
                            // Check for confirm status
                            const urlParams = new URLSearchParams(window.location.search);
                            if (urlParams.get('confirmStatus') === 'success') {
                                document.getElementById('successModal').style.display = 'flex';

                                // Check if a specific reservation number was confirmed
                                const reservationNo = urlParams.get('confirmedReservationNo');
                                if (reservationNo) {
                                    // If we want to pre-select or highlight, we could use this ID. 
                                    // For now, the button goes to bill-servlet which loads the generation page.
                                    // We could append the ID to focus on it in the next page if logic allows.
                                }
                            }

                            function closeModal() {
                                document.getElementById('successModal').style.display = 'none';
                                // Clean URL
                                const url = new URL(window.location);
                                url.searchParams.delete('confirmStatus');
                                url.searchParams.delete('confirmedReservationNo');
                                window.history.replaceState({}, document.title, url);
                            }

                            // Search functionality
                            const searchInput = document.getElementById('searchInput');
                            if (searchInput) {
                                searchInput.addEventListener('input', function () {
                                    const searchTerm = this.value.toLowerCase();
                                    const rows = document.querySelectorAll('.reservation-row');

                                    rows.forEach(row => {
                                        const text = row.textContent.toLowerCase();
                                        if (text.includes(searchTerm)) {
                                            row.style.display = '';
                                        } else {
                                            row.style.display = 'none';
                                        }
                                    });
                                });
                            }
                        </script>
                        </div>
                    </body>

                    </html>