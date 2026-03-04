<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.buddhi.oceanviewresort.model.entity.Room" %>
            <% String username=(String) session.getAttribute("username"); String role=(String)
                session.getAttribute("role"); if (username==null) { response.sendRedirect(request.getContextPath()
                + "/Auth/Login.jsp" ); return; } %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Room Management - Ocean View Resort</title>
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

                        .room-container {
                            padding: 40px;
                            max-width: 1600px;
                            margin: 0 auto;
                        }

                        .page-header {
                            text-align: center;
                            margin-bottom: 60px;
                        }

                        .page-label {
                            font-size: 11px;
                            letter-spacing: 4px;
                            text-transform: uppercase;
                            color: #c9a55c;
                            margin-bottom: 15px;
                            font-weight: 500;
                        }

                        .page-title {
                            font-size: 48px;
                            font-weight: 300;
                            letter-spacing: 4px;
                            text-transform: uppercase;
                            margin-bottom: 20px;
                            line-height: 1.2;
                        }

                        .page-description {
                            font-size: 14px;
                            line-height: 1.8;
                            color: rgba(255, 255, 255, 0.7);
                            max-width: 600px;
                            margin: 0 auto;
                            font-weight: 300;
                        }

                        .actions-bar {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 40px;
                            gap: 20px;
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

                        .filter-group {
                            display: flex;
                            gap: 15px;
                            align-items: center;
                        }

                        .filter-select {
                            background: rgba(255, 255, 255, 0.05);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            border-radius: 25px;
                            padding: 15px 25px;
                            color: #fff;
                            font-size: 13px;
                            cursor: pointer;
                            transition: all 0.3s;
                        }

                        .filter-select:focus {
                            outline: none;
                            border-color: #c9a55c;
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

                        .rooms-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                            gap: 30px;
                            margin-bottom: 40px;
                        }

                        .room-card {
                            background: rgba(255, 255, 255, 0.02);
                            border: 1px solid rgba(255, 255, 255, 0.05);
                            border-radius: 12px;
                            overflow: hidden;
                            transition: all 0.3s;
                            position: relative;
                        }

                        .room-card:hover {
                            transform: translateY(-5px);
                            border-color: rgba(201, 165, 92, 0.3);
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                        }

                        .room-header {
                            padding: 25px;
                            background: rgba(201, 165, 92, 0.05);
                            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                        }

                        .room-number {
                            font-size: 24px;
                            font-weight: 600;
                            color: #c9a55c;
                            margin-bottom: 8px;
                            letter-spacing: 2px;
                        }

                        .room-type {
                            font-size: 12px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            color: rgba(255, 255, 255, 0.6);
                        }

                        .room-body {
                            padding: 25px;
                        }

                        .room-info {
                            display: flex;
                            flex-direction: column;
                            gap: 15px;
                            margin-bottom: 25px;
                        }

                        .info-row {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding: 12px 0;
                            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                        }

                        .info-label {
                            font-size: 11px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            color: rgba(255, 255, 255, 0.5);
                        }

                        .info-value {
                            font-size: 13px;
                            color: rgba(255, 255, 255, 0.9);
                            font-weight: 500;
                        }

                        .status-badge {
                            display: inline-block;
                            padding: 6px 14px;
                            border-radius: 12px;
                            font-size: 10px;
                            letter-spacing: 1px;
                            text-transform: uppercase;
                            font-weight: 600;
                        }

                        .status-available {
                            background: rgba(81, 207, 102, 0.1);
                            color: #51cf66;
                            border: 1px solid rgba(81, 207, 102, 0.3);
                        }

                        .status-occupied {
                            background: rgba(255, 211, 61, 0.1);
                            color: #ffd93d;
                            border: 1px solid rgba(255, 211, 61, 0.3);
                        }

                        .status-maintenance {
                            background: rgba(231, 76, 60, 0.1);
                            color: #e74c3c;
                            border: 1px solid rgba(231, 76, 60, 0.3);
                        }

                        .status-reserved {
                            background: rgba(52, 152, 219, 0.1);
                            color: #3498db;
                            border: 1px solid rgba(52, 152, 219, 0.3);
                        }

                        .room-actions {
                            display: flex;
                            gap: 10px;
                        }

                        .btn-action {
                            flex: 1;
                            padding: 12px 20px;
                            font-size: 10px;
                            letter-spacing: 1.5px;
                            text-transform: uppercase;
                            border: none;
                            border-radius: 20px;
                            cursor: pointer;
                            transition: all 0.3s;
                            font-weight: 600;
                            text-decoration: none;
                            text-align: center;
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
                            background: rgba(255, 255, 255, 0.02);
                            border: 1px solid rgba(255, 255, 255, 0.05);
                            border-radius: 12px;
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
                            padding: 50px;
                            border-radius: 15px;
                            max-width: 600px;
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

                        .modal-header {
                            text-align: center;
                            margin-bottom: 30px;
                        }

                        .modal-title {
                            font-size: 24px;
                            color: #c9a55c;
                            margin-bottom: 10px;
                            text-transform: uppercase;
                            letter-spacing: 2px;
                        }

                        .modal-form {
                            display: flex;
                            flex-direction: column;
                            gap: 25px;
                        }

                        .form-group {
                            display: flex;
                            flex-direction: column;
                            gap: 10px;
                        }

                        .form-group label {
                            font-size: 11px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            color: rgba(255, 255, 255, 0.6);
                            font-weight: 500;
                        }

                        .form-group input,
                        .form-group select {
                            background: rgba(255, 255, 255, 0.05);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            border-radius: 8px;
                            padding: 15px 20px;
                            color: #fff;
                            font-size: 14px;
                            transition: all 0.3s;
                        }

                        .form-group input:focus,
                        .form-group select:focus {
                            outline: none;
                            border-color: #c9a55c;
                            background: rgba(255, 255, 255, 0.08);
                        }

                        .modal-actions {
                            display: flex;
                            gap: 15px;
                            justify-content: center;
                            margin-top: 20px;
                        }

                        .btn-cancel {
                            background: transparent;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                            color: #fff;
                        }

                        .btn-cancel:hover {
                            background: rgba(255, 255, 255, 0.05);
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

                            .room-container {
                                padding: 120px 30px 60px;
                            }

                            .page-title {
                                font-size: 42px;
                            }

                            .actions-bar {
                                flex-direction: column;
                                align-items: stretch;
                            }

                            .search-box {
                                max-width: 100%;
                            }

                            .rooms-grid {
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
                                <a href="${pageContext.request.contextPath}/user-servlet?action=list" class="menu-item">
                                    <span class="menu-icon">👥</span>
                                    <span>Guests</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/room-servlet?action=list"
                                    class="menu-item active">
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
                                <a href="${pageContext.request.contextPath}/report-servlet" class="menu-item">
                                    <span class="menu-icon">📈</span>
                                    <span>Reports</span>
                                </a>
                            </div>


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
                    <div class="main-content">
                        <div class="room-container">
                            <div class="page-header">
                                <div class="page-label">Room Management</div>
                                <h1 class="page-title">All<br>Rooms</h1>
                                <p class="page-description">
                                    Manage all rooms at Ocean View Resort. View room status, update information, and
                                    maintain room inventory.
                                </p>
                            </div>

                            <div class="actions-bar">
                                <div class="search-box">
                                    <span class="search-icon">🔍</span>
                                    <input type="text" id="searchInput" placeholder="Search by room number...">
                                </div>
                                <div class="filter-group">
                                    <select class="filter-select" id="statusFilter">
                                        <option value="">All Status</option>
                                        <option value="Available">Available</option>
                                        <option value="Occupied">Occupied</option>
                                        <option value="Maintenance">Maintenance</option>
                                        <option value="Reserved">Reserved</option>
                                    </select>
                                    <button class="btn btn-primary" onclick="openAddModal()">+ Add Room</button>
                                </div>
                            </div>

                            <%-- Display Status Messages --%>
                                <% String success=request.getParameter("success"); String
                                    error=request.getParameter("error"); if ("RoomAdded".equals(success)) { %>
                                    <div class="alert alert-success">
                                        ✓ Room added successfully!
                                    </div>
                                    <% } else if ("RoomUpdated".equals(success)) { %>
                                        <div class="alert alert-success">
                                            ✓ Room updated successfully!
                                        </div>
                                        <% } else if ("RoomDeleted".equals(success)) { %>
                                            <div class="alert alert-success">
                                                ✓ Room deleted successfully!
                                            </div>
                                            <% } else if (error !=null) { %>
                                                <div class="alert alert-error">
                                                    ⚠️ <%= error.equals("AddFailed") ? "Failed to add room" :
                                                        error.equals("UpdateFailed") ? "Failed to update room" :
                                                        error.equals("DeleteFailed") ? "Failed to delete room" :
                                                        error.equals("InvalidInput") ? "Invalid input data"
                                                        : "An error occurred" %>
                                                </div>
                                                <% } %>

                                                    <div class="rooms-grid" id="roomsGrid">
                                                        <% List<Room> rooms = (List<Room>)
                                                                request.getAttribute("rooms");
                                                                if (rooms != null && !rooms.isEmpty()) {
                                                                for (Room room : rooms) {
                                                                String statusClass = "";
                                                                String statusText = room.getStatus();

                                                                switch(statusText.toLowerCase()) {
                                                                case "available":
                                                                statusClass = "status-available";
                                                                break;
                                                                case "occupied":
                                                                statusClass = "status-occupied";
                                                                break;
                                                                case "maintenance":
                                                                statusClass = "status-maintenance";
                                                                break;
                                                                case "reserved":
                                                                statusClass = "status-reserved";
                                                                break;
                                                                default:
                                                                statusClass = "status-available";
                                                                }

                                                                String roomTypeName = "";
                                                                switch(room.getRoomTypeId()) {
                                                                case 1:
                                                                roomTypeName = "Deluxe Suite";
                                                                break;
                                                                case 2:
                                                                roomTypeName = "Standard Room";
                                                                break;
                                                                case 3:
                                                                roomTypeName = "Ocean View";
                                                                break;
                                                                default:
                                                                roomTypeName = "Room Type " + room.getRoomTypeId();
                                                                }
                                                                %>
                                                                <div class="room-card"
                                                                    data-room-number="<%= room.getRoomNumber() %>"
                                                                    data-status="<%= room.getStatus() %>">
                                                                    <div class="room-header">
                                                                        <div class="room-number">Room <%=
                                                                                room.getRoomNumber() %>
                                                                        </div>
                                                                        <div class="room-type">
                                                                            <%= roomTypeName %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="room-body">
                                                                        <div class="room-info">
                                                                            <div class="info-row">
                                                                                <span class="info-label">Room ID</span>
                                                                                <span class="info-value">#<%=
                                                                                        room.getRoomId() %></span>
                                                                            </div>
                                                                            <div class="info-row">
                                                                                <span class="info-label">Type ID</span>
                                                                                <span class="info-value">
                                                                                    <%= room.getRoomTypeId() %>
                                                                                </span>
                                                                            </div>
                                                                            <div class="info-row">
                                                                                <span class="info-label">Status</span>
                                                                                <span
                                                                                    class="status-badge <%= statusClass %>">
                                                                                    <%= statusText %>
                                                                                </span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="room-actions">
                                                                            <button class="btn-action btn-edit"
                                                                                onclick="openEditModal(<%= room.getRoomId() %>, '<%= room.getRoomNumber() %>', <%= room.getRoomTypeId() %>, '<%= room.getStatus() %>')">
                                                                                ✏️ Edit
                                                                            </button>
                                                                            <button class="btn-action btn-delete"
                                                                                onclick="confirmDelete(<%= room.getRoomId() %>, '<%= room.getRoomNumber() %>')">
                                                                                🗑️ Delete
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <% } } else { %>
                                                                    <div class="empty-state"
                                                                        style="grid-column: 1 / -1;">
                                                                        <div class="empty-icon">🛏️</div>
                                                                        <div class="empty-text">No rooms found</div>
                                                                        <button class="btn btn-primary"
                                                                            onclick="openAddModal()">Add Your First
                                                                            Room</button>
                                                                    </div>
                                                                    <% } %>
                                                    </div>
                        </div>
                    </div>

                    <!-- Add/Edit Room Modal -->
                    <div class="modal-overlay" id="roomModal">
                        <div class="modal-card">
                            <div class="modal-header">
                                <h2 class="modal-title" id="modalTitle">Add New Room</h2>
                            </div>
                            <form class="modal-form" id="roomForm" method="post"
                                action="${pageContext.request.contextPath}/room-servlet">
                                <input type="hidden" name="action" id="formAction" value="add">
                                <input type="hidden" name="id" id="roomId">

                                <div class="form-group">
                                    <label for="roomNumber">Room Number *</label>
                                    <input type="text" id="roomNumber" name="roomNumber" required
                                        placeholder="e.g., 101, 202">
                                </div>

                                <div class="form-group">
                                    <label for="roomTypeId">Room Type *</label>
                                    <select id="roomTypeId" name="roomTypeId" required>
                                        <option value="">Select Room Type</option>
                                        <option value="1">Deluxe Suite</option>
                                        <option value="2">Standard Room</option>
                                        <option value="3">Ocean View</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="status">Status *</label>
                                    <select id="status" name="status" required>
                                        <option value="">Select Status</option>
                                        <option value="Available">Available</option>
                                        <option value="Occupied">Occupied</option>
                                        <option value="Maintenance">Maintenance</option>
                                        <option value="Reserved">Reserved</option>
                                    </select>
                                </div>

                                <div class="modal-actions">
                                    <button type="button" class="btn btn-cancel" onclick="closeModal()">Cancel</button>
                                    <button type="submit" class="btn btn-primary" id="submitBtn">Add Room</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Delete Confirmation Modal -->
                    <div class="modal-overlay" id="deleteModal">
                        <div class="modal-card" style="text-align: center; max-width: 400px;">
                            <div class="modal-header">
                                <div style="font-size: 48px; color: #e74c3c; margin-bottom: 20px;">⚠️</div>
                                <h2 class="modal-title">Confirm Delete</h2>
                                <p style="color: rgba(255, 255, 255, 0.7); margin-top: 15px;">
                                    Are you sure you want to delete <span id="deleteRoomNumber"
                                        style="color: #c9a55c;"></span>?
                                    This action cannot be undone.
                                </p>
                            </div>
                            <form method="post" action="${pageContext.request.contextPath}/room-servlet">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" id="deleteRoomId">
                                <div class="modal-actions">
                                    <button type="button" class="btn btn-cancel"
                                        onclick="closeDeleteModal()">Cancel</button>
                                    <button type="submit" class="btn btn-delete">Delete Room</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script>
                        // Search functionality
                        document.getElementById('searchInput').addEventListener('input', function (e) {
                            const searchTerm = e.target.value.toLowerCase();
                            filterRooms();
                        });

                        // Status filter
                        document.getElementById('statusFilter').addEventListener('change', function () {
                            filterRooms();
                        });

                        function filterRooms() {
                            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
                            const statusFilter = document.getElementById('statusFilter').value.toLowerCase();
                            const roomCards = document.querySelectorAll('.room-card');

                            roomCards.forEach(card => {
                                const roomNumber = card.getAttribute('data-room-number').toLowerCase();
                                const status = card.getAttribute('data-status').toLowerCase();

                                const matchesSearch = roomNumber.includes(searchTerm);
                                const matchesStatus = !statusFilter || status === statusFilter;

                                if (matchesSearch && matchesStatus) {
                                    card.style.display = 'block';
                                } else {
                                    card.style.display = 'none';
                                }
                            });
                        }

                        // Modal functions
                        function openAddModal() {
                            document.getElementById('modalTitle').textContent = 'Add New Room';
                            document.getElementById('formAction').value = 'add';
                            document.getElementById('submitBtn').textContent = 'Add Room';
                            document.getElementById('roomForm').reset();
                            document.getElementById('roomId').value = '';
                            document.getElementById('roomModal').style.display = 'flex';
                        }

                        function openEditModal(id, roomNumber, roomTypeId, status) {
                            document.getElementById('modalTitle').textContent = 'Edit Room';
                            document.getElementById('formAction').value = 'update';
                            document.getElementById('submitBtn').textContent = 'Update Room';
                            document.getElementById('roomId').value = id;
                            document.getElementById('roomNumber').value = roomNumber;
                            document.getElementById('roomTypeId').value = roomTypeId;
                            document.getElementById('status').value = status;
                            document.getElementById('roomModal').style.display = 'flex';
                        }

                        function closeModal() {
                            document.getElementById('roomModal').style.display = 'none';
                        }

                        function confirmDelete(id, roomNumber) {
                            document.getElementById('deleteRoomId').value = id;
                            document.getElementById('deleteRoomNumber').textContent = 'Room ' + roomNumber;
                            document.getElementById('deleteModal').style.display = 'flex';
                        }

                        function closeDeleteModal() {
                            document.getElementById('deleteModal').style.display = 'none';
                        }

                        // Close modal when clicking outside
                        window.onclick = function (event) {
                            const roomModal = document.getElementById('roomModal');
                            const deleteModal = document.getElementById('deleteModal');
                            if (event.target === roomModal) {
                                closeModal();
                            }
                            if (event.target === deleteModal) {
                                closeDeleteModal();
                            }
                        }

                        // Auto-hide alerts after 5 seconds
                        window.addEventListener('DOMContentLoaded', function () {
                            const alerts = document.querySelectorAll('.alert');
                            alerts.forEach(alert => {
                                setTimeout(() => {
                                    alert.style.opacity = '0';
                                    setTimeout(() => alert.remove(), 300);
                                }, 5000);
                            });
                        });
                    </script>
                </body>

                </html>