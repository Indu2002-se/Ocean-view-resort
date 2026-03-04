<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                    <title>Update Reservation - Ocean View Resort</title>
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

                        .top-nav {
                            display: none;
                        }

                        .reservation-container {
                            padding: 40px;
                            max-width: 1400px;
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

                        .reservation-grid {
                            display: grid;
                            grid-template-columns: 1fr 400px;
                            gap: 60px;
                            align-items: start;
                        }

                        .form-panel {
                            background: rgba(255, 255, 255, 0.02);
                            border: 1px solid rgba(255, 255, 255, 0.05);
                            border-radius: 8px;
                            padding: 50px;
                        }

                        .section-title {
                            font-size: 24px;
                            font-weight: 400;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            margin-bottom: 40px;
                            color: #c9a55c;
                            position: relative;
                            padding-bottom: 15px;
                        }

                        .section-title::after {
                            content: '';
                            position: absolute;
                            bottom: 0;
                            left: 0;
                            width: 60px;
                            height: 2px;
                            background: #c9a55c;
                        }

                        .form-grid {
                            display: grid;
                            gap: 30px;
                        }

                        .form-row {
                            display: grid;
                            grid-template-columns: repeat(2, 1fr);
                            gap: 30px;
                        }

                        .form-group {
                            display: flex;
                            flex-direction: column;
                        }

                        .form-group.full-width {
                            grid-column: 1 / -1;
                        }

                        .form-label {
                            font-size: 11px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            color: rgba(255, 255, 255, 0.5);
                            margin-bottom: 12px;
                            font-weight: 500;
                        }

                        .form-label span {
                            color: #c9a55c;
                        }

                        .form-input,
                        .form-select,
                        .form-textarea {
                            background: rgba(255, 255, 255, 0.03);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            padding: 18px 20px;
                            color: #fff;
                            font-size: 14px;
                            border-radius: 4px;
                            transition: all 0.3s;
                            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        }

                        .form-input:focus,
                        .form-select:focus,
                        .form-textarea:focus {
                            outline: none;
                            border-color: #c9a55c;
                            background: rgba(201, 165, 92, 0.05);
                            box-shadow: 0 0 0 3px rgba(201, 165, 92, 0.1);
                        }

                        .form-input::placeholder {
                            color: rgba(255, 255, 255, 0.3);
                        }

                        .form-textarea {
                            resize: vertical;
                            min-height: 120px;
                        }

                        .form-select {
                            cursor: pointer;
                            appearance: none;
                            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23c9a55c' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
                            background-repeat: no-repeat;
                            background-position: right 15px center;
                            padding-right: 40px;
                        }

                        .form-actions {
                            display: flex;
                            gap: 20px;
                            margin-top: 40px;
                        }

                        .btn {
                            padding: 18px 50px;
                            font-size: 12px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            border: none;
                            border-radius: 30px;
                            cursor: pointer;
                            transition: all 0.3s;
                            font-weight: 600;
                            flex: 1;
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

                        .btn-secondary {
                            background: transparent;
                            border: 1px solid rgba(255, 255, 255, 0.2);
                            color: rgba(255, 255, 255, 0.7);
                        }

                        .btn-secondary:hover {
                            background: rgba(255, 255, 255, 0.05);
                            color: #fff;
                            border-color: rgba(255, 255, 255, 0.4);
                        }

                        .summary-panel {
                            position: sticky;
                            top: 120px;
                            background: rgba(255, 255, 255, 0.02);
                            border: 1px solid rgba(255, 255, 255, 0.05);
                            border-radius: 8px;
                            padding: 40px;
                        }

                        .summary-title {
                            font-size: 20px;
                            font-weight: 400;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            margin-bottom: 30px;
                            color: #c9a55c;
                        }

                        .summary-item {
                            display: flex;
                            justify-content: space-between;
                            padding: 18px 0;
                            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                        }

                        .summary-item:last-child {
                            border-bottom: none;
                        }

                        .summary-label {
                            font-size: 12px;
                            letter-spacing: 1px;
                            text-transform: uppercase;
                            color: rgba(255, 255, 255, 0.6);
                        }

                        .summary-value {
                            font-size: 14px;
                            color: #fff;
                            font-weight: 500;
                        }

                        .summary-total {
                            margin-top: 30px;
                            padding: 25px;
                            background: rgba(201, 165, 92, 0.1);
                            border-radius: 6px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .total-label {
                            font-size: 14px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            color: #c9a55c;
                        }

                        .total-amount {
                            font-size: 36px;
                            font-weight: 600;
                            color: #c9a55c;
                        }

                        .info-box {
                            margin-top: 30px;
                            padding: 20px;
                            background: rgba(201, 165, 92, 0.05);
                            border-left: 3px solid #c9a55c;
                            border-radius: 4px;
                        }

                        .info-box p {
                            font-size: 12px;
                            line-height: 1.8;
                            color: rgba(255, 255, 255, 0.7);
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

                        .room-preview {
                            margin-top: 30px;
                            border-radius: 8px;
                            overflow: hidden;
                        }

                        .room-image {
                            width: 100%;
                            height: 200px;
                            background-size: cover;
                            background-position: center;
                            position: relative;
                        }

                        .room-badge {
                            position: absolute;
                            top: 15px;
                            right: 15px;
                            padding: 8px 20px;
                            background: rgba(201, 165, 92, 0.95);
                            color: #1a1a1a;
                            font-size: 10px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            font-weight: 600;
                            border-radius: 20px;
                        }

                        .room-details {
                            padding: 20px;
                            background: rgba(255, 255, 255, 0.03);
                        }

                        .room-name {
                            font-size: 16px;
                            font-weight: 500;
                            margin-bottom: 10px;
                            color: #c9a55c;
                        }

                        .room-features {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 8px;
                        }

                        .feature-tag {
                            padding: 4px 10px;
                            background: rgba(255, 255, 255, 0.05);
                            border: 1px solid rgba(255, 255, 255, 0.1);
                            border-radius: 12px;
                            font-size: 9px;
                            letter-spacing: 1px;
                            text-transform: uppercase;
                        }

                        .hidden {
                            display: none;
                        }

                        @media (max-width: 1200px) {
                            .reservation-grid {
                                grid-template-columns: 1fr;
                            }

                            .summary-panel {
                                position: relative;
                                top: 0;
                            }
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

                            .form-panel,
                            .summary-panel {
                                padding: 30px 20px;
                            }

                            .form-row {
                                grid-template-columns: 1fr;
                            }

                            .form-actions {
                                flex-direction: column;
                            }
                        }

                        /* Loading Spinner */
                        .spinner {
                            border: 3px solid rgba(255, 255, 255, 0.1);
                            border-top: 3px solid #c9a55c;
                            border-radius: 50%;
                            width: 40px;
                            height: 40px;
                            animation: spin 1s linear infinite;
                            margin: 0 auto;
                        }

                        @keyframes spin {
                            0% {
                                transform: rotate(0deg);
                            }

                            100% {
                                transform: rotate(360deg);
                            }
                        }

                        .loading-overlay {
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.8);
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            z-index: 9999;
                        }

                        .loading-content {
                            text-align: center;
                        }

                        .loading-text {
                            margin-top: 20px;
                            font-size: 14px;
                            letter-spacing: 2px;
                            text-transform: uppercase;
                            color: #c9a55c;
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
                    <main class="main-content">
                        <div class="reservation-container">
                            <% Reservation reservation=(Reservation) request.getAttribute("reservation");
                                DateTimeFormatter dateFormatter=DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"); %>
                                <div class="page-header">
                                    <div class="page-label">Edit Reservation</div>
                                    <h1 class="page-title">Update<br>Reservation</h1>
                                    <p class="page-description">
                                        Modify reservation details for <%= reservation !=null ?
                                            reservation.getReservationNo() : "" %>.
                                            Update guest information, dates, or room preferences.
                                    </p>
                                </div>

                                <!-- Display Error Messages -->
                                <% String error=request.getParameter("error"); String
                                    message=request.getParameter("message"); if ("validation".equals(error) && message
                                    !=null) { %>
                                    <div class="alert alert-error">
                                        ⚠️ Validation Error: <%= message %>
                                    </div>
                                    <% } else if ("true".equals(error)) { %>
                                        <div class="alert alert-error">
                                            ⚠️ Failed to create reservation. Please try again.
                                        </div>
                                        <% } else if ("exception".equals(error)) { %>
                                            <div class="alert alert-error">
                                                ⚠️ An unexpected error occurred. Please check your input and try again.
                                            </div>
                                            <% } %>

                                                <div class="reservation-grid">
                                                    <div class="form-panel">
                                                        <h2 class="section-title">Guest Information</h2>

                                                        <form
                                                            action="${pageContext.request.contextPath}/reservation-servlet"
                                                            method="POST" id="reservationForm"
                                                            onsubmit="return validateForm()">
                                                            <input type="hidden" name="action" value="update">
                                                            <div class="form-grid">
                                                                <!-- Reservation Number (Read-only) -->
                                                                <div class="form-group">
                                                                    <label class="form-label">Reservation Number</label>
                                                                    <input type="text" name="reservationNo"
                                                                        class="form-input"
                                                                        value="<%= reservation != null ? reservation.getReservationNo() : "" %>"
                                                                        readonly
                                                                        style="background: rgba(201,165,92,0.1); color: #c9a55c; font-weight: 600;">
                                                                </div>

                                                                <!-- Guest Name -->
                                                                <div class="form-group">
                                                                    <label class="form-label">Guest Name
                                                                        <span>*</span></label>
                                                                    <input type="text" name="guestName"
                                                                        class="form-input"
                                                                        value="<%= reservation != null ? reservation.getGuestName() : "" %>"
                                                                        placeholder="Enter your full name" required>
                                                                </div>

                                                                <!-- Guest Email -->
                                                                <div class="form-row">
                                                                    <div class="form-group">
                                                                        <label class="form-label">Email Address
                                                                            <span>*</span></label>
                                                                        <input type="email" name="guestEmail"
                                                                            class="form-input"
                                                                            value="<%= reservation != null  ? reservation.getGuestEmail() : "" %>"
                                                                            placeholder="your.email@example.com"
                                                                            required>
                                                                    </div>

                                                                    <!-- Phone Number -->
                                                                    <div class="form-group">
                                                                        <label class="form-label">Phone Number
                                                                            <span>*</span></label>
                                                                        <input type="tel" name="phoneNo"
                                                                            class="form-input"
                                                                            value="<%= reservation != null ? reservation.getPhoneNo() : "" %>"
                                                                            placeholder="+94 XX XXX XXXX" required>
                                                                    </div>
                                                                </div>

                                                                <!-- Address -->
                                                                <div class="form-group full-width">
                                                                    <label class="form-label">Address</label>
                                                                    <textarea name="address" class="form-textarea"
                                                                        placeholder="Enter your complete address"><%= reservation != null && reservation.getAddress() != null ? reservation.getAddress() : "" %></textarea>
                                                                </div>

                                                                <!-- Room Type -->
                                                                <div class="form-row">
                                                                    <div class="form-group">
                                                                        <label class="form-label">Room Type
                                                                            <span>*</span></label>
                                                                        <select name="room_type_id" class="form-select"
                                                                            id="roomType" required>
                                                                            <option value="">Select Room Category
                                                                            </option>
                                                                            <option value="1" data-price="80"
                                                                                data-name="Standard Room"
                                                                                <%=(reservation !=null &&
                                                                                reservation.getRoomTypeId()==1)
                                                                                ? "selected" : "" %>>Standard Room -
                                                                                $80/night</option>
                                                                            <option value="2" data-price="120"
                                                                                data-name="Deluxe Room" <%=(reservation
                                                                                !=null &&
                                                                                reservation.getRoomTypeId()==2)
                                                                                ? "selected" : "" %>>Deluxe Room -
                                                                                $120/night</option>
                                                                            <option value="3" data-price="200"
                                                                                data-name="Suite" <%=(reservation !=null
                                                                                && reservation.getRoomTypeId()==3)
                                                                                ? "selected" : "" %>>Suite - $200/night
                                                                            </option>
                                                                            <option value="4" data-price="250"
                                                                                data-name="Ocean View Suite"
                                                                                <%=(reservation !=null &&
                                                                                reservation.getRoomTypeId()==4)
                                                                                ? "selected" : "" %>>Ocean View
                                                                                Suite - $250/night</option>
                                                                        </select>
                                                                    </div>

                                                                    <!-- Number of Guests -->
                                                                    <div class="form-group">
                                                                        <label class="form-label">Number of Guests
                                                                            <span>*</span></label>
                                                                        <input type="number" name="num_guests"
                                                                            class="form-input" placeholder="1" min="1"
                                                                            max="4"
                                                                            value="<%= reservation != null ? reservation.getNumGuests() : 1 %>"
                                                                            required>
                                                                    </div>
                                                                </div>

                                                                <!-- Check-in Date -->
                                                                <div class="form-row">
                                                                    <div class="form-group">
                                                                        <label class="form-label">Check-in Date
                                                                            <span>*</span></label>
                                                                        <input type="datetime-local" name="checkInDate"
                                                                            class="form-input" id="checkIn"
                                                                            value="<%= reservation != null ? reservation.getCheckInDate().format(dateFormatter) : "" %>"
                                                                            required>
                                                                    </div>

                                                                    <!-- Check-out Date -->
                                                                    <div class="form-group">
                                                                        <label class="form-label">Check-out Date
                                                                            <span>*</span></label>
                                                                        <input type="datetime-local" name="checkOutDate"
                                                                            class="form-input" id="checkOut"
                                                                            value="<%= reservation != null ? reservation.getCheckOutDate().format(dateFormatter) : "" %>"
                                                                            required>
                                                                    </div>
                                                                </div>

                                                                <!-- Special Requests -->
                                                                <div class="form-group full-width">
                                                                    <label class="form-label">Special Requests
                                                                        (Optional)</label>
                                                                    <textarea name="special_requests"
                                                                        class="form-textarea"
                                                                        placeholder="Any special requirements or preferences (e.g., dietary needs, room preferences)"><%= reservation != null && reservation.getSpecialRequests() != null ? reservation.getSpecialRequests() : "" %></textarea>
                                                                </div>
                                                            </div>

                                                            <div class="form-actions">
                                                                <a href="${pageContext.request.contextPath}/reservation-servlet"
                                                                    class="btn btn-secondary">Cancel</a>
                                                                <button type="submit" class="btn btn-primary">Update
                                                                    Reservation</button>
                                                            </div>
                                                        </form>
                                                    </div>

                                                    <div class="summary-panel">
                                                        <h3 class="summary-title">Booking Summary</h3>

                                                        <div class="room-preview hidden" id="roomPreview">
                                                            <div class="room-image" id="roomImage">
                                                                <div class="room-badge">Selected</div>
                                                            </div>
                                                            <div class="room-details">
                                                                <div class="room-name" id="roomName">Select a room</div>
                                                                <div class="room-features">
                                                                    <span class="feature-tag">Free WiFi</span>
                                                                    <span class="feature-tag">AC</span>
                                                                    <span class="feature-tag">TV</span>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="summary-item">
                                                            <span class="summary-label">Reservation No.</span>
                                                            <span class="summary-value"
                                                                id="summaryResNo">Auto-generated</span>
                                                        </div>

                                                        <div class="summary-item">
                                                            <span class="summary-label">Guest Name</span>
                                                            <span class="summary-value" id="summaryName">-</span>
                                                        </div>

                                                        <div class="summary-item">
                                                            <span class="summary-label">Room Type</span>
                                                            <span class="summary-value" id="summaryRoom">Not
                                                                selected</span>
                                                        </div>

                                                        <div class="summary-item">
                                                            <span class="summary-label">Check-in</span>
                                                            <span class="summary-value" id="summaryCheckIn">-</span>
                                                        </div>

                                                        <div class="summary-item">
                                                            <span class="summary-label">Check-out</span>
                                                            <span class="summary-value" id="summaryCheckOut">-</span>
                                                        </div>

                                                        <div class="summary-item">
                                                            <span class="summary-label">Number of Nights</span>
                                                            <span class="summary-value" id="summaryNights">0</span>
                                                        </div>

                                                        <div class="summary-item">
                                                            <span class="summary-label">Rate per Night</span>
                                                            <span class="summary-value" id="summaryRate">$0</span>
                                                        </div>

                                                        <div class="summary-total">
                                                            <span class="total-label">Total Amount</span>
                                                            <span class="total-amount" id="totalAmount">$0</span>
                                                        </div>

                                                        <div class="info-box">
                                                            <p>
                                                                <strong>Important:</strong><br>
                                                                • Check-in time: 2:00 PM (14:00)<br>
                                                                • Check-out time: 12:00 PM (12:00)<br>
                                                                • Cancellation policy applies<br>
                                                                • Valid ID required at check-in
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                        </div>
                    </main>

                    <script>
                        // Generate random reservation number on page load
                        function generateReservationNumber() {
                            const resNo = 'RES' + Date.now().toString().slice(-8);
                            document.querySelector('input[name="reservationNo"]').value = resNo;
                            document.getElementById('summaryResNo').textContent = resNo;
                        }

                        window.addEventListener('load', generateReservationNumber);

                        // Room images mapping
                        const roomImages = {
                            '1': 'https://images.unsplash.com/photo-1590490360182-c33d57733427?w=600',
                            '2': 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=600',
                            '3': 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?w=600',
                            '4': 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=600'
                        };

                        // Update room preview
                        document.getElementById('roomType').addEventListener('change', function () {
                            const selectedOption = this.options[this.selectedIndex];
                            const roomName = selectedOption.getAttribute('data-name');
                            const roomPrice = selectedOption.getAttribute('data-price');
                            const roomId = selectedOption.value;

                            if (roomId) {
                                document.getElementById('roomPreview').classList.remove('hidden');
                                document.getElementById('roomName').textContent = roomName;
                                document.getElementById('roomImage').style.backgroundImage = `linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.5)), url('${roomImages[roomId]}')`;
                                document.getElementById('summaryRoom').textContent = roomName;
                                document.getElementById('summaryRate').textContent = '$' + roomPrice;
                                calculateTotal();
                            } else {
                                document.getElementById('roomPreview').classList.add('hidden');
                                document.getElementById('summaryRoom').textContent = 'Not selected';
                                document.getElementById('summaryRate').textContent = '$0';
                                document.getElementById('totalAmount').textContent = '$0';
                            }
                        });

                        // Update guest name in summary
                        document.querySelector('input[name="guestName"]').addEventListener('input', function () {
                            document.getElementById('summaryName').textContent = this.value || '-';
                        });

                        // Update check-in date in summary
                        document.getElementById('checkIn').addEventListener('change', function () {
                            const date = new Date(this.value);
                            document.getElementById('summaryCheckIn').textContent = date.toLocaleDateString('en-US', {
                                month: 'short', day: 'numeric', year: 'numeric', hour: '2-digit', minute: '2-digit'
                            });
                            calculateTotal();
                        });

                        // Update check-out date in summary
                        document.getElementById('checkOut').addEventListener('change', function () {
                            const date = new Date(this.value);
                            document.getElementById('summaryCheckOut').textContent = date.toLocaleDateString('en-US', {
                                month: 'short', day: 'numeric', year: 'numeric', hour: '2-digit', minute: '2-digit'
                            });
                            calculateTotal();
                        });

                    </script>
                </body>

                </html>