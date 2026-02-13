<%-- Created by IntelliJ IDEA. User: vitha Date: 1/16/2026 Time: 1:40 PM To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="java.util.*" %>
            <% // Check if user is logged in
          String username=(String) session.getAttribute("username");
          String
                role=(String) session.getAttribute("role"); if (username==null) { response.sendRedirect("login.jsp");
                return; } %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Dashboard - Ocean View Resort Management</title>
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

                        .top-bar {
                            background: rgba(13, 13, 13, 0.95);
                            backdrop-filter: blur(10px);
                            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                            padding: 20px 40px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            position: sticky;
                            top: 0;
                            z-index: 999;
                        }

                        .page-title {
                            font-size: 24px;
                            font-weight: 300;
                            letter-spacing: 2px;
                        }

                        .top-actions {
                            display: flex;
                            gap: 15px;
                            align-items: center;
                        }

                        .search-box {
                            position: relative;
                        }

                        .search-box input {
                            background: rgba(255, 255, 255, 0.05);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            border-radius: 20px;
                            padding: 10px 20px 10px 40px;
                            color: #fff;
                            font-size: 12px;
                            width: 250px;
                            transition: all 0.3s;
                        }

                        .search-box input:focus {
                            outline: none;
                            border-color: #c9a55c;
                            width: 300px;
                        }

                        .search-icon {
                            position: absolute;
                            left: 15px;
                            top: 50%;
                            transform: translateY(-50%);
                            color: rgba(255, 255, 255, 0.4);
                        }

                        .notification-btn {
                            position: relative;
                            width: 40px;
                            height: 40px;
                            background: rgba(255, 255, 255, 0.05);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            cursor: pointer;
                            transition: all 0.3s;
                        }

                        .notification-btn:hover {
                            background: rgba(255, 255, 255, 0.1);
                            border-color: #c9a55c;
                        }

                        .notification-badge {
                            position: absolute;
                            top: -3px;
                            right: -3px;
                            background: #ff6b6b;
                            color: #fff;
                            font-size: 10px;
                            padding: 2px 6px;
                            border-radius: 10px;
                            font-weight: 600;
                        }

                        /* Dashboard Content */
                        .dashboard-content {
                            padding: 40px;
                        }

                        /* Stats Cards */
                        .stats-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                            gap: 25px;
                            margin-bottom: 40px;
                        }

                        .stat-card {
                            background: rgba(13, 13, 13, 0.95);
                            border: 1px solid rgba(255, 255, 255, 0.05);
                            border-radius: 12px;
                            padding: 25px;
                            transition: all 0.3s;
                            position: relative;
                            overflow: hidden;
                        }

                        .stat-card::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            right: 0;
                            height: 3px;
                            background: linear-gradient(90deg, #c9a55c, #f4e5c3);
                            opacity: 0;
                            transition: opacity 0.3s;
                        }

                        .stat-card:hover {
                            border-color: rgba(201, 165, 92, 0.3);
                            transform: translateY(-5px);
                        }

                        .stat-card:hover::before {
                            opacity: 1;
                        }

                        .stat-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: flex-start;
                            margin-bottom: 15px;
                        }

                        .stat-icon {
                            width: 50px;
                            height: 50px;
                            background: rgba(201, 165, 92, 0.1);
                            border-radius: 10px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 24px;
                        }

                        .stat-label {
                            font-size: 11px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            color: rgba(255, 255, 255, 0.5);
                            margin-bottom: 8px;
                        }

                        .stat-value {
                            font-size: 32px;
                            font-weight: 600;
                            color: #c9a55c;
                            margin-bottom: 5px;
                        }

                        .stat-change {
                            font-size: 11px;
                            color: #51cf66;
                        }

                        .stat-change.negative {
                            color: #ff6b6b;
                        }

                        /* Quick Actions */
                        .quick-actions {
                            background: rgba(13, 13, 13, 0.95);
                            border: 1px solid rgba(255, 255, 255, 0.05);
                            border-radius: 12px;
                            padding: 30px;
                            margin-bottom: 40px;
                        }

                        .section-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 25px;
                        }

                        .section-title {
                            font-size: 18px;
                            font-weight: 400;
                            letter-spacing: 1px;
                        }

                        .action-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                            gap: 20px;
                        }

                        .action-btn {
                            background: rgba(255, 255, 255, 0.05);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            border-radius: 10px;
                            padding: 20px;
                            text-align: center;
                            cursor: pointer;
                            transition: all 0.3s;
                            text-decoration: none;
                            color: #fff;
                            display: block;
                        }

                        .action-btn:hover {
                            background: rgba(201, 165, 92, 0.1);
                            border-color: #c9a55c;
                            transform: translateY(-3px);
                        }

                        .action-btn-icon {
                            font-size: 32px;
                            margin-bottom: 10px;
                        }

                        .action-btn-text {
                            font-size: 13px;
                            font-weight: 500;
                            letter-spacing: 1px;
                        }

                        /* Recent Activity */
                        .recent-activity {
                            background: rgba(13, 13, 13, 0.95);
                            border: 1px solid rgba(255, 255, 255, 0.05);
                            border-radius: 12px;
                            padding: 30px;
                        }

                        .activity-list {
                            display: flex;
                            flex-direction: column;
                            gap: 15px;
                        }

                        .activity-item {
                            display: flex;
                            align-items: center;
                            gap: 15px;
                            padding: 15px;
                            background: rgba(255, 255, 255, 0.02);
                            border-radius: 8px;
                            border-left: 3px solid #c9a55c;
                        }

                        .activity-icon {
                            width: 40px;
                            height: 40px;
                            background: rgba(201, 165, 92, 0.1);
                            border-radius: 8px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 18px;
                        }

                        .activity-details {
                            flex: 1;
                        }

                        .activity-title {
                            font-size: 13px;
                            font-weight: 500;
                            margin-bottom: 3px;
                        }

                        .activity-time {
                            font-size: 11px;
                            color: rgba(255, 255, 255, 0.4);
                        }

                        .activity-status {
                            font-size: 10px;
                            letter-spacing: 1px;
                            text-transform: uppercase;
                            padding: 4px 10px;
                            border-radius: 12px;
                            background: rgba(81, 207, 102, 0.1);
                            color: #51cf66;
                        }

                        .activity-status.pending {
                            background: rgba(255, 211, 61, 0.1);
                            color: #ffd93d;
                        }

                        .activity-status.cancelled {
                            background: rgba(255, 107, 107, 0.1);
                            color: #ff6b6b;
                        }

                        /* Responsive */
                        @media (max-width: 1024px) {
                            .sidebar {
                                width: 80px;
                            }

                            .sidebar-header,
                            .menu-title,
                            .user-details,
                            .logout-btn {
                                display: none;
                            }

                            .menu-item {
                                justify-content: center;
                                padding: 14px;
                            }

                            .menu-item span {
                                display: none;
                            }

                            .main-content {
                                margin-left: 80px;
                            }

                            .user-info {
                                justify-content: center;
                            }
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

                            .dashboard-content {
                                padding: 20px;
                            }

                            .stats-grid {
                                grid-template-columns: 1fr;
                            }

                            .search-box input {
                                width: 150px;
                            }

                            .search-box input:focus {
                                width: 200px;
                            }
                        }

                        /* Loading Animation */
                        .loading {
                            display: inline-block;
                            width: 20px;
                            height: 20px;
                            border: 2px solid rgba(201, 165, 92, 0.3);
                            border-radius: 50%;
                            border-top-color: #c9a55c;
                            animation: spin 0.8s linear infinite;
                        }

                        @keyframes spin {
                            to {
                                transform: rotate(360deg);
                            }
                        }

                        .welcome-banner {
                            background: linear-gradient(135deg, rgba(201, 165, 92, 0.1), rgba(201, 165, 92, 0.05));
                            border: 1px solid rgba(201, 165, 92, 0.2);
                            border-radius: 12px;
                            padding: 30px;
                            margin-bottom: 30px;
                        }

                        .welcome-text {
                            font-size: 28px;
                            font-weight: 300;
                            margin-bottom: 10px;
                        }

                        .welcome-subtext {
                            font-size: 13px;
                            color: rgba(255, 255, 255, 0.6);
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
                                <a href="dashboard.jsp" class="menu-item active">
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
                                <a href="${pageContext.request.contextPath}/user-servlet?action=list" class="menu-item">
                                    <span class="menu-icon">👥</span>
                                    <span>Guests</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/room-servlet?action=list" class="menu-item">
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

                                    <div class="menu-section">
                                        <div class="menu-title">Support</div>
                                        <a href="${pageContext.request.contextPath}/help-servlet" class="menu-item">
                                            <span class="menu-icon">❓</span>
                                            <span>Help & Guide</span>
                                        </a>
                                    </div>
                        </nav>

                        <div class="sidebar-footer">
                            <div class="user-info">
                                <div class="user-avatar">
                                    <%= username.substring(0, 1).toUpperCase() %>
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
                            <form action="LogoutServlet" method="post" style="margin: 0;">
                                <button type="submit" class="logout-btn">🚪 Logout</button>
                            </form>
                        </div>
                    </aside>

                    <!-- Main Content -->
                    <main class="main-content">
                        <!-- Top Bar -->
                        <div class="top-bar">
                            <h1 class="page-title">Dashboard</h1>
                            <div class="top-actions">
                                <div class="search-box">
                                    <span class="search-icon">🔍</span>
                                    <input type="text" placeholder="Search reservations...">
                                </div>
                                <div class="notification-btn">
                                    🔔
                                    <span class="notification-badge">3</span>
                                </div>
                            </div>
                        </div>

                        <!-- Dashboard Content -->
                        <div class="dashboard-content">
                            <!-- Welcome Banner -->
                            <div class="welcome-banner">
                                <div class="welcome-text">Welcome back, <%= username %>! 👋</div>
                                <div class="welcome-subtext">Here's what's happening at Ocean View Resort today</div>
                            </div>

                            <!-- Stats Cards -->
                            <div class="stats-grid">
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div>
                                            <div class="stat-label">Total Reservations</div>
                                            <div class="stat-value">127</div>
                                            <div class="stat-change">↗ +12% from last month</div>
                                        </div>
                                        <div class="stat-icon">📋</div>
                                    </div>
                                </div>

                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div>
                                            <div class="stat-label">Active Guests</div>
                                            <div class="stat-value">45</div>
                                            <div class="stat-change">↗ +8% from yesterday</div>
                                        </div>
                                        <div class="stat-icon">👤</div>
                                    </div>
                                </div>

                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div>
                                            <div class="stat-label">Available Rooms</div>
                                            <div class="stat-value">23</div>
                                            <div class="stat-change negative">↘ -3 from yesterday</div>
                                        </div>
                                        <div class="stat-icon">🏨</div>
                                    </div>
                                </div>

                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div>
                                            <div class="stat-label">Monthly Revenue</div>
                                            <div class="stat-value">$48K</div>
                                            <div class="stat-change">↗ +15% from last month</div>
                                        </div>
                                        <div class="stat-icon">💵</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Actions -->
                            <div class="quick-actions">
                                <div class="section-header">
                                    <h2 class="section-title">Quick Actions</h2>
                                </div>
                                <div class="action-grid">
                                    <a href="${pageContext.request.contextPath}/Reservation/CreateReservation.jsp"
                                        class="action-btn">
                                        <div class="action-btn-icon">➕</div>
                                        <div class="action-btn-text">New Reservation</div>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/reservation-servlet" class="action-btn">
                                        <div class="action-btn-icon">🔍</div>
                                        <div class="action-btn-text">Search Booking</div>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/Bill/GenerateBill.jsp"
                                        class="action-btn">
                                        <div class="action-btn-icon">💰</div>
                                        <div class="action-btn-text">Generate Bill</div>
                                    </a>
                                    <a href="check-in.jsp" class="action-btn">
                                        <div class="action-btn-icon">✅</div>
                                        <div class="action-btn-text">Check-In Guest</div>
                                    </a>
                                    <a href="check-out.jsp" class="action-btn">
                                        <div class="action-btn-icon">🚪</div>
                                        <div class="action-btn-text">Check-Out Guest</div>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/help-servlet" class="action-btn">
                                        <div class="action-btn-icon">❓</div>
                                        <div class="action-btn-text">Help & Guide</div>
                                    </a>
                                </div>
                            </div>

                            <!-- Recent Activity -->
                            <div class="recent-activity">
                                <div class="section-header">
                                    <h2 class="section-title">Recent Activity</h2>
                                    <a href="reservations.jsp"
                                        style="color: #c9a55c; font-size: 12px; text-decoration: none;">View All →</a>
                                </div>
                                <div class="activity-list">
                                    <div class="activity-item">
                                        <div class="activity-icon">📅</div>
                                        <div class="activity-details">
                                            <div class="activity-title">New reservation created - RES-2026-001</div>
                                            <div class="activity-time">2 minutes ago</div>
                                        </div>
                                        <div class="activity-status">Confirmed</div>
                                    </div>

                                    <div class="activity-item">
                                        <div class="activity-icon">✅</div>
                                        <div class="activity-details">
                                            <div class="activity-title">Guest checked in - John Smith (Deluxe Suite)
                                            </div>
                                            <div class="activity-time">15 minutes ago</div>
                                        </div>
                                        <div class="activity-status">Active</div>
                                    </div>

                                    <div class="activity-item">
                                        <div class="activity-icon">💰</div>
                                        <div class="activity-details">
                                            <div class="activity-title">Payment received - RES-2026-045 ($450.00)</div>
                                            <div class="activity-time">1 hour ago</div>
                                        </div>
                                        <div class="activity-status">Completed</div>
                                    </div>

                                    <div class="activity-item">
                                        <div class="activity-icon">🚪</div>
                                        <div class="activity-details">
                                            <div class="activity-title">Guest checked out - Sarah Johnson</div>
                                            <div class="activity-time">2 hours ago</div>
                                        </div>
                                        <div class="activity-status">Completed</div>
                                    </div>

                                    <div class="activity-item">
                                        <div class="activity-icon">⏰</div>
                                        <div class="activity-details">
                                            <div class="activity-title">Reservation pending confirmation - RES-2026-002
                                            </div>
                                            <div class="activity-time">3 hours ago</div>
                                        </div>
                                        <div class="activity-status pending">Pending</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                    <script>
                        // Mobile menu toggle
                        const menuToggle = document.querySelector('.menu-toggle');
                        const sidebar = document.getElementById('sidebar');

                        if (menuToggle && sidebar) {
                            menuToggle.addEventListener('click', () => {
                                sidebar.classList.toggle('mobile-open');
                            });
                        }

                        // Search functionality
                        const searchInput = document.querySelector('.search-box input');
                        if (searchInput) {
                            searchInput.addEventListener('keypress', (e) => {
                                if (e.key === 'Enter') {
                                    const searchTerm = searchInput.value.trim();
                                    if (searchTerm) {
                                        // Redirect to reservation search
                                        window.location.href = '${pageContext.request.contextPath}/reservation-servlet?search=' + encodeURIComponent(searchTerm);
                                    }
                                }
                            });
                        }

                        // Notification badge animation
                        const notificationBadge = document.querySelector('.notification-badge');
                        if (notificationBadge) {
                            setInterval(() => {
                                notificationBadge.style.transition = 'transform 0.3s';
                                notificationBadge.style.transform = 'scale(1.2)';
                                setTimeout(() => {
                                    notificationBadge.style.transform = 'scale(1)';
                                }, 300);
                            }, 5000);
                        }
                    </script>
                </body>

                </html>