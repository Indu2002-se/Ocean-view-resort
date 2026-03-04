<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.*" %>
        <% // Check if user is logged in
            String username=(String) session.getAttribute("username"); String role=(String)
            session.getAttribute("role"); if (username==null) { response.sendRedirect(request.getContextPath()
            + "/Auth/Login.jsp" ); return; } %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Help & Support - Ocean View Resort</title>
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

                    /* Sidebar Navigation - Reused from Dashboard */
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

                    /* Help Content Styles */
                    .help-container {
                        padding: 40px;
                        max-width: 1200px;
                        margin: 0 auto;
                    }

                    .help-header {
                        text-align: center;
                        margin-bottom: 60px;
                    }

                    .help-header h2 {
                        font-size: 36px;
                        font-weight: 300;
                        margin-bottom: 15px;
                        background: linear-gradient(90deg, #fff, #c9a55c);
                        -webkit-background-clip: text;
                        background-clip: text;
                        -webkit-text-fill-color: transparent;
                    }

                    .help-header p {
                        color: rgba(255, 255, 255, 0.6);
                        font-size: 16px;
                        letter-spacing: 1px;
                    }

                    .help-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
                        gap: 30px;
                        margin-bottom: 60px;
                    }

                    .help-card {
                        background: rgba(255, 255, 255, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.05);
                        border-radius: 16px;
                        padding: 35px;
                        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                        position: relative;
                        overflow: hidden;
                    }

                    .help-card:hover {
                        transform: translateY(-10px);
                        background: rgba(255, 255, 255, 0.05);
                        border-color: rgba(201, 165, 92, 0.3);
                        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
                    }

                    .help-card::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 4px;
                        background: linear-gradient(90deg, #c9a55c, transparent);
                        opacity: 0;
                        transition: opacity 0.3s;
                    }

                    .help-card:hover::before {
                        opacity: 1;
                    }

                    .card-icon {
                        font-size: 40px;
                        margin-bottom: 25px;
                        display: inline-block;
                        background: rgba(201, 165, 92, 0.1);
                        width: 70px;
                        height: 70px;
                        line-height: 70px;
                        text-align: center;
                        border-radius: 14px;
                    }

                    .card-title {
                        font-size: 20px;
                        font-weight: 500;
                        margin-bottom: 15px;
                        color: #c9a55c;
                    }

                    .help-links {
                        list-style: none;
                    }

                    .help-links li {
                        margin-bottom: 12px;
                    }

                    .help-links a {
                        color: rgba(255, 255, 255, 0.7);
                        text-decoration: none;
                        font-size: 14px;
                        transition: all 0.3s;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                    }

                    .help-links li::before {
                        content: '→';
                        color: #c9a55c;
                        font-size: 12px;
                        opacity: 0.5;
                    }

                    .help-links a:hover {
                        color: #fff;
                        padding-left: 5px;
                    }

                    .faq-section {
                        background: rgba(13, 13, 13, 0.5);
                        border-radius: 20px;
                        padding: 50px;
                        border: 1px solid rgba(255, 255, 255, 0.03);
                    }

                    .faq-title {
                        font-size: 24px;
                        font-weight: 300;
                        margin-bottom: 30px;
                        text-align: center;
                        letter-spacing: 2px;
                    }

                    .faq-item {
                        margin-bottom: 20px;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                        padding-bottom: 20px;
                    }

                    .faq-question {
                        font-size: 16px;
                        font-weight: 500;
                        margin-bottom: 10px;
                        color: rgba(255, 255, 255, 0.9);
                        cursor: pointer;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .faq-question:hover {
                        color: #c9a55c;
                    }

                    .faq-answer {
                        font-size: 14px;
                        color: rgba(255, 255, 255, 0.5);
                        line-height: 1.6;
                        display: none;
                        padding-top: 10px;
                    }

                    .faq-item.active .faq-answer {
                        display: block;
                    }

                    .contact-support {
                        margin-top: 60px;
                        text-align: center;
                        padding: 40px;
                        background: linear-gradient(135deg, rgba(201, 165, 92, 0.1), rgba(13, 13, 13, 0));
                        border-radius: 16px;
                        border: 1px solid rgba(201, 165, 92, 0.1);
                    }

                    .support-btn {
                        display: inline-block;
                        padding: 15px 40px;
                        background: #c9a55c;
                        color: #1a1a1a;
                        text-decoration: none;
                        border-radius: 30px;
                        font-weight: 600;
                        font-size: 14px;
                        letter-spacing: 1px;
                        margin-top: 20px;
                        transition: all 0.3s;
                    }

                    .support-btn:hover {
                        background: #f4e5c3;
                        transform: scale(1.05);
                        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
                    }

                    @media (max-width: 768px) {
                        .main-content {
                            margin-left: 0;
                        }

                        .help-container {
                            padding: 20px;
                        }

                        .help-grid {
                            grid-template-columns: 1fr;
                        }
                    }

                    /* ── Topic Detail Drawer ── */
                    .drawer-overlay {
                        position: fixed;
                        inset: 0;
                        background: rgba(0, 0, 0, 0.6);
                        backdrop-filter: blur(4px);
                        z-index: 2000;
                        opacity: 0;
                        visibility: hidden;
                        transition: opacity 0.35s, visibility 0.35s;
                    }

                    .drawer-overlay.open {
                        opacity: 1;
                        visibility: visible;
                    }

                    .detail-drawer {
                        position: fixed;
                        top: 0;
                        right: -520px;
                        width: 100%;
                        max-width: 520px;
                        height: 100vh;
                        background: #0d0d0d;
                        border-left: 1px solid rgba(201, 165, 92, 0.15);
                        z-index: 2001;
                        display: flex;
                        flex-direction: column;
                        transition: right 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
                        overflow: hidden;
                    }

                    .detail-drawer.open {
                        right: 0;
                    }

                    .drawer-header {
                        padding: 28px 32px;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                        display: flex;
                        align-items: center;
                        gap: 16px;
                        background: rgba(201, 165, 92, 0.04);
                        flex-shrink: 0;
                    }

                    .drawer-icon {
                        font-size: 28px;
                        width: 54px;
                        height: 54px;
                        background: rgba(201, 165, 92, 0.1);
                        border-radius: 12px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        flex-shrink: 0;
                    }

                    .drawer-title {
                        flex: 1;
                    }

                    .drawer-title h3 {
                        font-size: 18px;
                        font-weight: 500;
                        color: #c9a55c;
                        margin-bottom: 4px;
                    }

                    .drawer-title span {
                        font-size: 11px;
                        letter-spacing: 1.5px;
                        text-transform: uppercase;
                        color: rgba(255, 255, 255, 0.35);
                    }

                    .drawer-close {
                        width: 36px;
                        height: 36px;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, 0.06);
                        border: 1px solid rgba(255, 255, 255, 0.1);
                        color: rgba(255, 255, 255, 0.6);
                        font-size: 18px;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        transition: all 0.2s;
                        flex-shrink: 0;
                    }

                    .drawer-close:hover {
                        background: rgba(220, 53, 69, 0.15);
                        border-color: rgba(220, 53, 69, 0.4);
                        color: #ff6b6b;
                    }

                    .drawer-body {
                        flex: 1;
                        overflow-y: auto;
                        padding: 32px;
                        scroll-behavior: smooth;
                    }

                    .drawer-body::-webkit-scrollbar {
                        width: 4px;
                    }

                    .drawer-body::-webkit-scrollbar-track {
                        background: transparent;
                    }

                    .drawer-body::-webkit-scrollbar-thumb {
                        background: rgba(201, 165, 92, 0.3);
                        border-radius: 2px;
                    }

                    .guide-intro {
                        font-size: 14px;
                        color: rgba(255, 255, 255, 0.55);
                        line-height: 1.75;
                        margin-bottom: 28px;
                        padding: 16px 20px;
                        background: rgba(201, 165, 92, 0.05);
                        border-left: 3px solid #c9a55c;
                        border-radius: 0 8px 8px 0;
                    }

                    .guide-steps {
                        list-style: none;
                        display: flex;
                        flex-direction: column;
                        gap: 20px;
                        margin-bottom: 28px;
                    }

                    .guide-step {
                        display: flex;
                        gap: 16px;
                        align-items: flex-start;
                        padding: 18px 20px;
                        background: rgba(255, 255, 255, 0.03);
                        border: 1px solid rgba(255, 255, 255, 0.05);
                        border-radius: 10px;
                        transition: border-color 0.2s;
                    }

                    .guide-step:hover {
                        border-color: rgba(201, 165, 92, 0.25);
                    }

                    .step-num {
                        width: 30px;
                        height: 30px;
                        border-radius: 50%;
                        background: linear-gradient(135deg, #c9a55c, #f4e5c3);
                        color: #1a1a1a;
                        font-weight: 700;
                        font-size: 13px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        flex-shrink: 0;
                    }

                    .step-content h4 {
                        font-size: 14px;
                        font-weight: 600;
                        margin-bottom: 5px;
                        color: #fff;
                    }

                    .step-content p {
                        font-size: 13px;
                        color: rgba(255, 255, 255, 0.5);
                        line-height: 1.6;
                    }

                    .guide-tip {
                        padding: 16px 20px;
                        background: rgba(81, 207, 102, 0.06);
                        border: 1px solid rgba(81, 207, 102, 0.2);
                        border-radius: 10px;
                        font-size: 13px;
                        color: rgba(255, 255, 255, 0.6);
                        line-height: 1.6;
                    }

                    .guide-tip strong {
                        color: #51cf66;
                    }

                    /* topic link button */
                    .topic-link {
                        background: none;
                        border: none;
                        color: rgba(255, 255, 255, 0.7);
                        font-size: 14px;
                        font-family: inherit;
                        cursor: pointer;
                        text-align: left;
                        padding: 0;
                        transition: all 0.25s;
                        line-height: 1.5;
                    }

                    .topic-link:hover {
                        color: #c9a55c;
                        padding-left: 4px;
                    }

                    @media (max-width: 600px) {
                        .detail-drawer {
                            max-width: 100%;
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
                            <a href="${pageContext.request.contextPath}/Dashboard/StaffDashboard.jsp" class="menu-item">
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
                            <a href="${pageContext.request.contextPath}/report-servlet" class="menu-item">
                                <span class="menu-icon">📈</span>
                                <span>Reports</span>
                            </a>
                        </div>



                                <div class="menu-section">
                                    <div class="menu-title">Support</div>
                                    <a href="${pageContext.request.contextPath}/help-servlet" class="menu-item active">
                                        <span class="menu-icon">❓</span>
                                        <span>Help & Guide</span>
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

                <main class="main-content">
                    <div class="top-bar">
                        <h1 class="page-title">Help & Support</h1>
                    </div>

                    <div class="help-container">
                        <div class="help-header">
                            <h2>How can we help you today?</h2>
                            <p>Explore guides and tutorials for Ocean View Resort Management System</p>
                        </div>

                        <div class="help-grid">
                            <!-- Reservations Help -->
                            <div class="help-card">
                                <div class="card-icon">📅</div>
                                <h3 class="card-title">Reservation Management</h3>
                                <ul class="help-links">
                                    <li><button class="topic-link" onclick="openDrawer('new-booking')">How to create a
                                            new booking</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('modify-reservation')">Modifying
                                            existing reservations</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('handle-cancellation')">Handling
                                            cancellations</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('group-booking')">Group booking
                                            procedures</button></li>
                                </ul>
                            </div>

                            <!-- Rooms Help -->
                            <div class="help-card">
                                <div class="card-icon">🛏️</div>
                                <h3 class="card-title">Room Operations</h3>
                                <ul class="help-links">
                                    <li><button class="topic-link" onclick="openDrawer('room-availability')">Updating
                                            room availability</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('housekeeping')">Housekeeping
                                            status management</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('room-categories')">Room category
                                            definitions</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('maintenance')">Maintenance
                                            reporting</button></li>
                                </ul>
                            </div>

                            <!-- Billing Help -->
                            <div class="help-card">
                                <div class="card-icon">💰</div>
                                <h3 class="card-title">Billing & Payments</h3>
                                <ul class="help-links">
                                    <li><button class="topic-link" onclick="openDrawer('generate-invoice')">Generating
                                            guest invoices</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('payment-types')">Processing
                                            different payment types</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('discounts')">Applying discounts
                                            and vouchers</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('checkout-billing')">Finalizing
                                            check-out billing</button></li>
                                </ul>
                            </div>

                            <!-- System Help -->
                            <div class="help-card">
                                <div class="card-icon">⚙️</div>
                                <h3 class="card-title">System & Account</h3>
                                <ul class="help-links">
                                    <li><button class="topic-link" onclick="openDrawer('change-password')">Changing your
                                            password</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('notifications')">Setting up
                                            notifications</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('reports')">Generating
                                            operational reports</button></li>
                                    <li><button class="topic-link" onclick="openDrawer('user-permissions')">User
                                            permission guide</button></li>
                                </ul>
                            </div>
                        </div>

                        <div class="faq-section">
                            <h3 class="faq-title">Frequently Asked Questions</h3>

                            <div class="faq-item">
                                <div class="faq-question">
                                    How do I check-in a guest with a pending reservation?
                                    <span>+</span>
                                </div>
                                <div class="faq-answer">
                                    Navigate to the Reservations list, find the guest's name or reservation ID, and
                                    click the 'Check-In' button. Ensure all guest details are verified before
                                    confirming.
                                </div>
                            </div>

                            <div class="faq-item">
                                <div class="faq-question">
                                    What should I do if a room is marked 'Dirty' but needs to be assigned?
                                    <span>+</span>
                                </div>
                                <div class="faq-answer">
                                    Contact the housekeeping department immediately. You cannot assign a room with
                                    'Dirty' status. Once cleaned, housekeeping will update the status to 'Available'.
                                </div>
                            </div>

                            <div class="faq-item">
                                <div class="faq-question">
                                    Can I undo a bill generation?
                                    <span>+</span>
                                </div>
                                <div class="faq-answer">
                                    Once a bill is finalized and payment is processed, it cannot be undone. You will
                                    need to issue a refund or a credit note through the Billing Administration panel.
                                </div>
                            </div>
                        </div>

                        <div class="contact-support">
                            <h3>Still need assistance?</h3>
                            <p>Our technical support team is available 24/7 for critical issues.</p>
                            <a href="mailto:support@oceanview.com" class="support-btn">Contact IT Support</a>
                        </div>
                    </div>
                </main>

                <!-- ═══ DETAIL DRAWER ═══ -->
                <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer()"></div>
                <aside class="detail-drawer" id="detailDrawer">
                    <div class="drawer-header">
                        <div class="drawer-icon" id="drawerIcon"></div>
                        <div class="drawer-title">
                            <h3 id="drawerTitle">Guide</h3>
                            <span id="drawerCategory">Help & Support</span>
                        </div>
                        <button class="drawer-close" onclick="closeDrawer()">✕</button>
                    </div>
                    <div class="drawer-body" id="drawerBody"></div>
                </aside>

                <script>
                    // ── Guide content database ──
                    const guides = {
                        'new-booking': {
                            icon: '📅', category: 'Reservation Management',
                            title: 'How to Create a New Booking',
                            intro: 'Creating a new reservation is the most common task for front-desk staff. Follow these steps to complete a booking quickly and accurately.',
                            steps: [
                                { title: 'Navigate to New Reservation', body: 'Click "New Reservation" in the sidebar or use the Quick Actions button on the Dashboard.' },
                                { title: 'Enter Guest Details', body: 'Search for an existing guest by name or email. If the guest is new, complete all required fields: full name, email, and phone number.' },
                                { title: 'Select Room & Dates', body: 'Choose the room type and preferred room number. Set the Check-In and Check-Out dates using the date pickers. The system will show available rooms only.' },
                                { title: 'Review Pricing', body: 'The system auto-calculates the total cost based on room rate × nights. Verify the amount matches the guest\'s expectations before proceeding.' },
                                { title: 'Confirm the Booking', body: 'Click "Create Reservation". The system assigns a Reservation ID (e.g. RES-2026-XXX) and sends a confirmation email to the guest.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> Double-check the check-out date — a common error is setting it to the same day as check-in.'
                        },
                        'modify-reservation': {
                            icon: '✏️', category: 'Reservation Management',
                            title: 'Modifying Existing Reservations',
                            intro: 'Guests often request date changes or room upgrades. Use the update flow to amend a booking without cancelling it.',
                            steps: [
                                { title: 'Open Reservations List', body: 'Go to the Reservations section from the sidebar. Use the search box to find the booking by guest name, ID, or date.' },
                                { title: 'Open the Reservation', body: 'Click the eye/view icon next to the reservation to open its detail page.' },
                                { title: 'Click Edit / Update', body: 'Select the "Update" button. You can change dates, room, or add special requests.' },
                                { title: 'Check Availability', body: 'The system will validate the new dates and alert you if the chosen room is unavailable.' },
                                { title: 'Save Changes', body: 'Click "Update Reservation". The guest\'s record is updated and a revised confirmation is logged.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> If the price changes due to the modification, discuss it with the guest before saving.'
                        },
                        'handle-cancellation': {
                            icon: '❌', category: 'Reservation Management',
                            title: 'Handling Cancellations',
                            intro: 'Cancellations must be processed promptly so rooms are re-listed as available for other guests.',
                            steps: [
                                { title: 'Locate the Reservation', body: 'Find the booking in the Reservations list using the guest\'s name or reservation ID.' },
                                { title: 'Verify Cancellation Policy', body: 'Check the booking\'s cancellation deadline. Bookings cancelled within 24 hours of check-in may incur a penalty fee.' },
                                { title: 'Process the Cancellation', body: 'Click the "Cancel" option from the reservation actions menu. Enter a cancellation reason in the text box provided.' },
                                { title: 'Handle Refunds', body: 'If a deposit was paid, navigate to Billing → Refund and process the applicable refund amount per policy.' },
                                { title: 'Confirm Room Release', body: 'The system automatically sets the room status back to Available. Verify in the Rooms section.' }
                            ],
                            tip: '<strong>⚠️ Warning:</strong> Cancellations cannot be easily reversed. Confirm with a supervisor if you are unsure.'
                        },
                        'group-booking': {
                            icon: '👨‍👩‍👧‍👦', category: 'Reservation Management',
                            title: 'Group Booking Procedures',
                            intro: 'Group bookings (3+ rooms) require a slightly different process and are often handled by a senior staff member.',
                            steps: [
                                { title: 'Contact the Manager', body: 'All group bookings of 5 or more rooms should first be approved by the Duty Manager.' },
                                { title: 'Create Individual Reservations', body: 'Create a separate reservation for each room required. Use the same group reference in the "Notes" field, e.g. "WEDDING-MARCH2026".' },
                                { title: 'Apply Group Rate', body: 'If a negotiated group rate applies, use the discount field on each reservation. The standard group discount is 10%.' },
                                { title: 'Assign a Lead Contact', body: 'Add the group organiser\'s details as the primary contact. All correspondence will be directed to them.' },
                                { title: 'Generate a Group Summary', body: 'Use the Reports section to generate a group booking summary PDF for the organiser.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> Use a shared keyword in the Notes field for all group rooms so you can easily filter them in reports.'
                        },
                        'room-availability': {
                            icon: '🛏️', category: 'Room Operations',
                            title: 'Updating Room Availability',
                            intro: 'Keeping room statuses accurate is critical so that front-desk staff always see real-time availability.',
                            steps: [
                                { title: 'Go to Rooms Section', body: 'Click "Rooms" in the sidebar navigation. You will see a list of all rooms with their current status.' },
                                { title: 'Find the Room', body: 'Use the search or filter by floor/type to locate the specific room. The status column shows: Available, Occupied, Under Maintenance, or Out of Order.' },
                                { title: 'Edit the Room', body: 'Click the Edit (pencil) icon next to the room. A form will appear with the current details.' },
                                { title: 'Update the Status', body: 'Change the Status dropdown to the correct value. Add a note explaining the reason if moving to Maintenance or Out of Order.' },
                                { title: 'Save Changes', body: 'Click "Update Room". The new status immediately applies across all booking screens.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> Never manually mark a room as Available if housekeeping has not cleared it. Always coordinate with the housekeeping team first.'
                        },
                        'housekeeping': {
                            icon: '🧹', category: 'Room Operations',
                            title: 'Housekeeping Status Management',
                            intro: 'The system tracks three housekeeping states: Clean, Dirty, and Inspected. Understanding them prevents assigning guests to unready rooms.',
                            steps: [
                                { title: 'Understanding the States', body: '<strong>Clean</strong> – Ready for a new guest. <strong>Dirty</strong> – Just vacated or flagged by guest. <strong>Inspected</strong> – Cleaned and verified by a supervisor.' },
                                { title: 'Receiving a Dirty Flag', body: 'After guest check-out or upon a guest complaint, the room is automatically flagged as Dirty. Housekeeping is notified.' },
                                { title: 'Clearing the Flag', body: 'Housekeeping staff update the room to Clean in the system after servicing. The room then appears as Available for booking.' },
                                { title: 'Supervisory Inspection', body: 'A supervisor can optionally mark the room as Inspected for VIP arrivals, adding a quality-assurance layer.' },
                                { title: 'Front-Desk Coordination', body: 'Never assign a Dirty or Inspected room to a new guest. Always wait for Clean or Inspected status before check-in.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> If a guest reports a dirty room after check-in, immediately flag it, offer a room change, and escalate to the duty manager.'
                        },
                        'room-categories': {
                            icon: '🏨', category: 'Room Operations',
                            title: 'Room Category Definitions',
                            intro: 'Understanding each room category helps you match the right accommodation to guest needs and accurately quote pricing.',
                            steps: [
                                { title: 'Standard Room', body: 'Garden-view or partial ocean-view rooms with standard amenities. Suitable for budget-conscious travellers and short stays.' },
                                { title: 'Deluxe Room', body: 'Larger rooms with full ocean views, upgraded furnishings, and a sitting area. Most popular category for couples.' },
                                { title: 'Suite', body: 'Separate living room, bedroom, premium toiletries, and butler service on request. Ideal for honeymooners and VIP guests.' },
                                { title: 'Family Room', body: 'Interconnected or extra-large rooms with twin/triple bed configurations. Designed for families with children.' },
                                { title: 'Penthouse', body: 'Top-floor exclusive units with private terraces and panoramic views. Booked by the General Manager\'s office only.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> When a Deluxe room is requested but unavailable, always offer a Suite upgrade with the price difference explained clearly.'
                        },
                        'maintenance': {
                            icon: '🔧', category: 'Room Operations',
                            title: 'Maintenance Reporting',
                            intro: 'Reporting maintenance issues promptly ensures guest safety and preserves the resort\'s facilities.',
                            steps: [
                                { title: 'Identify the Issue', body: 'Issues can be reported by guests, housekeeping, or front-desk staff during inspections. Common issues: plumbing, AC, electrical, or furnishings.' },
                                { title: 'Log the Room as Under Maintenance', body: 'In the Rooms section, update the room status to "Under Maintenance" to block new bookings.' },
                                { title: 'Notify the Maintenance Team', body: 'Contact the Maintenance department directly via the internal communication system or phone extension.' },
                                { title: 'Document the Issue', body: 'Add a detailed note in the room\'s status field (e.g., "AC not cooling — technician scheduled for 14:00"). This helps with shift handovers.' },
                                { title: 'Clear the Flag on Resolution', body: 'Once the maintenance team confirms completion, update the room status to Available or Dirty (for cleaning).' }
                            ],
                            tip: '<strong>⚠️ Safety:</strong> If a maintenance issue poses a safety risk (e.g., exposed wiring), escalate to the Duty Manager immediately and do not allow any guests near the room.'
                        },
                        'generate-invoice': {
                            icon: '🧾', category: 'Billing & Payments',
                            title: 'Generating Guest Invoices',
                            intro: 'Invoices are generated at check-out or on request. An accurate invoice builds guest trust and ensures clean financial records.',
                            steps: [
                                { title: 'Go to Billing Section', body: 'Click "Billing" from the sidebar or use the "Generate Bill" quick action on the dashboard.' },
                                { title: 'Find the Reservation', body: 'Enter the guest name or Reservation ID. The system will populate all room charges automatically.' },
                                { title: 'Review Line Items', body: 'Check that all nights, room rate, taxes, and any additional charges (room service, laundry, etc.) are correct.' },
                                { title: 'Apply Adjustments if Needed', body: 'If any charges need correcting, use the "Edit Charge" option before finalising. Discounts can also be applied here.' },
                                { title: 'Generate & Print / Email', body: 'Click "Generate Bill". You can then download the PDF invoice or email it directly to the guest.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> Always review the invoice with the guest before processing payment to avoid disputes.'
                        },
                        'payment-types': {
                            icon: '💳', category: 'Billing & Payments',
                            title: 'Processing Different Payment Types',
                            intro: 'The resort accepts multiple payment methods. Each has its own procedure.',
                            steps: [
                                { title: 'Cash Payments', body: 'Count the cash carefully, issue a receipt from the billing system, and place the cash in the secure drawer. Record the transaction immediately.' },
                                { title: 'Credit / Debit Card', body: 'Swipe or insert the card using the POS terminal. Confirm the amount matches the invoice. Attach the terminal receipt to the guest folio.' },
                                { title: 'Bank Transfer', body: 'Verify the transfer with the accounts team before releasing the guest. Never allow checkout based on an unconfirmed transfer.' },
                                { title: 'Corporate Account / Credit', body: 'For guests booking under a corporate account, log the charge to the relevant company account. Do not request payment at check-out.' },
                                { title: 'Online / Pre-paid', body: 'Check the reservation notes for "Pre-paid" status. Only collect any remaining balance if applicable.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> Always confirm the final amount with the guest verbally before processing any payment to prevent chargebacks.'
                        },
                        'discounts': {
                            icon: '🏷️', category: 'Billing & Payments',
                            title: 'Applying Discounts and Vouchers',
                            intro: 'Discounts and voucher codes can be applied at invoice generation time. Only authorised staff can apply certain discount levels.',
                            steps: [
                                { title: 'Access the Bill', body: 'Open the guest\'s invoice in the Billing section. Look for the "Discount" field in the invoice editor.' },
                                { title: 'Select Discount Type', body: 'Choose from: Percentage Discount, Fixed Amount Off, or Voucher Code. Enter the applicable value.' },
                                { title: 'Voucher Validation', body: 'For voucher codes, the system will automatically validate the code and apply the correct discount. Expired codes will be rejected.' },
                                { title: 'Manager Approval for Large Discounts', body: 'Discounts over 20% require manager sign-off. The system will prompt for a supervisor PIN.' },
                                { title: 'Save and Confirm', body: 'Click "Apply" and the invoice total will recalculate instantly. Verify the new amount with the guest before processing payment.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> Keep a log of all manual discounts applied during your shift for the end-of-day report.'
                        },
                        'checkout-billing': {
                            icon: '🚪', category: 'Billing & Payments',
                            title: 'Finalizing Check-Out Billing',
                            intro: 'The check-out process combines room release, final billing, and guest farewell. Speed and accuracy are both important.',
                            steps: [
                                { title: 'Open the Reservation', body: 'Find the guest\'s reservation in the Reservations list. Confirm the check-out date matches today.' },
                                { title: 'Run the Final Bill', body: 'Click "Generate Bill" — this compiles all room nights plus any additional charges posted during the stay.' },
                                { title: 'Settle Additional Charges', body: 'Review minibar, room service, spa, or parking charges. Add any missing items before presenting the invoice.' },
                                { title: 'Collect Payment', body: 'Process the payment using the guest\'s preferred method. Issue a receipt and mark the bill as "Paid" in the system.' },
                                { title: 'Release the Room', body: 'Update the room status to Dirty in the Rooms section to trigger the housekeeping workflow. Mark the reservation as Checked Out.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> Ask the guest for feedback before they leave — it\'s a great opportunity to address any concerns and improve reviews.'
                        },
                        'change-password': {
                            icon: '🔐', category: 'System & Account',
                            title: 'Changing Your Password',
                            intro: 'Regularly updating your password protects guest data and your staff account from unauthorized access.',
                            steps: [
                                { title: 'Contact Your Administrator', body: 'Currently, password changes are handled by the system administrator. Contact IT support or the manager to request a reset.' },
                                { title: 'Receive a Temporary Password', body: 'A temporary password will be issued to your registered email. Use it to log in.' },
                                { title: 'Log In with Temporary Password', body: 'Enter the temporary credentials on the Login page. The system may prompt you to change it on first login.' },
                                { title: 'Choose a Strong Password', body: 'Your new password should be at least 8 characters long and include a mix of letters, numbers, and symbols.' },
                                { title: 'Keep Your Password Secure', body: 'Never share your password. Do not write it on sticky notes near your workstation. Log out when leaving your desk.' }
                            ],
                            tip: '<strong>🔒 Security:</strong> If you suspect your account has been accessed by someone else, report it to IT immediately.'
                        },
                        'notifications': {
                            icon: '🔔', category: 'System & Account',
                            title: 'Setting Up Notifications',
                            intro: 'The dashboard displays real-time property activity. Understanding notification indicators helps you stay on top of urgent tasks.',
                            steps: [
                                { title: 'Notification Bell', body: 'The bell icon in the top bar shows a badge with the count of pending alerts. Click it to view details.' },
                                { title: 'Types of Notifications', body: 'Notifications cover: New Reservations, Guest Check-Ins Due Today, Pending Payments, Room Maintenance Alerts, and Cancellations.' },
                                { title: 'Upcoming Arrivals', body: 'The dashboard\'s Recent Activity panel lists today\'s arrivals at the top. Review it at the start of every shift.' },
                                { title: 'Clearing a Notification', body: 'Click on a notification to open the relevant record. Notifications auto-dismiss after the associated task is completed.' },
                                { title: 'Escalation Alerts', body: 'Red-badge notifications indicate urgent items (e.g. overdue check-outs). Address these immediately or escalate to a supervisor.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> Review the notification panel at the start of each shift to quickly catch any issues from the previous team.'
                        },
                        'reports': {
                            icon: '📈', category: 'System & Account',
                            title: 'Generating Operational Reports',
                            intro: 'Reports give management and staff key operational insights. Run them regularly to stay informed.',
                            steps: [
                                { title: 'Open Reports Section', body: 'Click "Reports" from the sidebar. You will see a range of report categories: Occupancy, Revenue, Reservations, and Guests.' },
                                { title: 'Select Report Type', body: 'Choose the report that matches your need. For example, select "Daily Occupancy" to see today\'s room usage.' },
                                { title: 'Set the Date Range', body: 'Use the date pickers to define the period. For shift reports, set the range to the current date.' },
                                { title: 'Apply Filters if Needed', body: 'Filter by room type, reservation status, or staff member depending on the report type.' },
                                { title: 'Export the Report', body: 'Click "Generate Report" to view it on screen. Use the Download PDF or Download CSV button to save it for records or sharing.' }
                            ],
                            tip: '<strong>💡 Tip:</strong> The end-of-day revenue report should be run at shift close and emailed to the Duty Manager automatically.'
                        },
                        'user-permissions': {
                            icon: '👔', category: 'System & Account',
                            title: 'User Permission Guide',
                            intro: 'Different roles in the system have different levels of access. Understanding permissions prevents confusion and maintains security.',
                            steps: [
                                { title: 'Staff Role', body: 'Can manage reservations, check guests in/out, view room status, and generate bills. Cannot access user management or financial settings.' },
                                { title: 'Manager Role', body: 'Has full access to all sections including reports, billing overrides, discount approvals, user management, and system settings.' },
                                { title: 'Adding or Removing Users', body: 'Only Managers can create or deactivate staff accounts. Go to Administration → User Management to manage accounts.' },
                                { title: 'Role Assignment', body: 'When creating a new user, assign the appropriate role. The role cannot be self-changed — it requires a Manager login.' },
                                { title: 'Audit Trail', body: 'All actions in the system are logged with the user\'s name and timestamp. This audit trail is reviewable by management for accountability.' }
                            ],
                            tip: '<strong>🔒 Security:</strong> If a staff member leaves, deactivate their account immediately to prevent unauthorized system access.'
                        }
                    };

                    function openDrawer(topicKey) {
                        const guide = guides[topicKey];
                        if (!guide) return;

                        document.getElementById('drawerIcon').textContent = guide.icon;
                        document.getElementById('drawerTitle').textContent = guide.title;
                        document.getElementById('drawerCategory').textContent = guide.category;

                        const stepsHtml = guide.steps.map((s, i) =>
                            `<li class="guide-step">
                            <div class="step-num">\${i + 1}</div>
                            <div class="step-content">
                                <h4>\${s.title}</h4>
                                <p>\${s.body}</p>
                            </div>
                        </li>`
                        ).join('');

                        document.getElementById('drawerBody').innerHTML =
                            `<p class="guide-intro">\${guide.intro}</p>
                        <ul class="guide-steps">\${stepsHtml}</ul>
                        <div class="guide-tip">\${guide.tip}</div>`;

                        document.getElementById('drawerBody').scrollTop = 0;
                        document.getElementById('detailDrawer').classList.add('open');
                        document.getElementById('drawerOverlay').classList.add('open');
                        document.body.style.overflow = 'hidden';
                    }

                    function closeDrawer() {
                        document.getElementById('detailDrawer').classList.remove('open');
                        document.getElementById('drawerOverlay').classList.remove('open');
                        document.body.style.overflow = '';
                    }

                    // Close on Escape key
                    document.addEventListener('keydown', e => { if (e.key === 'Escape') closeDrawer(); });

                    // FAQ Toggle Logic
                    document.querySelectorAll('.faq-question').forEach(question => {
                        question.addEventListener('click', () => {
                            const item = question.parentElement;
                            item.classList.toggle('active');
                            const span = question.querySelector('span');
                            span.textContent = item.classList.contains('active') ? '-' : '+';
                        });
                    });
                </script>
            </body>

            </html>