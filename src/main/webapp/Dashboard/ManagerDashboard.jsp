<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.*" %>
        <%@ page import="java.time.*" %>
            <%@ page import="com.buddhi.oceanviewresort.service.*" %>
                <%@ page import="com.buddhi.oceanviewresort.model.entity.*" %>
                    <% // Check if user is logged in as MANAGER
                         String username=(String)
                        session.getAttribute("username"); String role=(String) session.getAttribute("role"); if
                        (username==null || !"MANAGER".equals(role)) { response.sendRedirect(request.getContextPath()
                        + "/Auth/Login.jsp?role=MANAGER" ); return; } // Fetch data
                        List<Reservation> reservations = new
                        ArrayList<>();
                            List<Room> rooms = new ArrayList<>();
                                    List<Staff> staffList = new ArrayList<>();
                                            List<User> guests = new ArrayList<>();
                                                    long totalReservations = 0;
                                                    long availableRooms = 0;
                                                    long totalStaff = 0;
                                                    double monthlyRevenue = 0.0;

                                                    try {
                                                    reservations =
                                                    ReservationService.getInstance().getAllReservations();
                                                    totalReservations = reservations.size();
                                                    } catch (Exception e) { System.out.println("Error fetching reservations: " + e.getMessage()); }

                                                    try {
                                                    rooms = new RoomService().getAllRooms();
                                                    availableRooms = rooms.stream().filter(r ->
                                                    "AVAILABLE".equalsIgnoreCase(r.getStatus())).count();
                                                    } catch (Exception e) { System.out.println("Error fetching rooms: "
                                                    + e.getMessage()); }

                                                    try {
                                                    staffList = StaffService.getInstance().getAllStaff();
                                                    totalStaff = staffList.size();
                                                    } catch (Exception e) { System.out.println("Error fetching staff: "
                                                    + e.getMessage()); }

                                                    try {
                                                    guests = UserService.getInstance().getAllUsers();
                                                    } catch (Exception e) { System.out.println("Error fetching guests: "
                                                    + e.getMessage()); }

                                                    try {
                                                    List<Bill> bills = BillService.getInstance().getAllBills();
                                                        LocalDateTime startOfMonth =
                                                        LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0);
                                                        for (Bill b : bills) {
                                                        if (b.getIssueDate() != null &&
                                                        !b.getIssueDate().isBefore(startOfMonth)) {
                                                        monthlyRevenue += b.getAmount();
                                                        }
                                                        }
                                                        } catch (Exception e) { System.out.println("Error fetching revenue: " + e.getMessage()); }

                                                        String monthlyRevenueFormatted = String.format("$%.2f",
                                                        monthlyRevenue);

                                                        // Flash messages
                                                        String msg = (String) session.getAttribute("message");
                                                        String msgType = (String) session.getAttribute("messageType");
                                                        if (msg != null) {
                                                        session.removeAttribute("message");
                                                        session.removeAttribute("messageType");
                                                        }
                                                        %>
                                                        <!DOCTYPE html>
                                                        <html lang="en">

                                                        <head>
                                                            <meta charset="UTF-8">
                                                            <meta name="viewport"
                                                                content="width=device-width, initial-scale=1.0">
                                                            <title>Manager Dashboard - Ocean View Resort</title>
                                                            <link rel="preconnect" href="https://fonts.googleapis.com">
                                                            <link
                                                                href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                                                                rel="stylesheet">
                                                            <style>
                                                                *,
                                                                *::before,
                                                                *::after {
                                                                    margin: 0;
                                                                    padding: 0;
                                                                    box-sizing: border-box;
                                                                }

                                                                :root {
                                                                    --bg: #0b0b0f;
                                                                    --bg-card: #12121a;
                                                                    --bg-panel: #0e0e14;
                                                                    --gold: #c9a55c;
                                                                    --gold-light: #e8c98a;
                                                                    --gold-pale: rgba(201, 165, 92, 0.08);
                                                                    --accent-mgr: #c97a5c;
                                                                    --accent-mgr-glow: rgba(201, 122, 92, 0.12);
                                                                    --text: #f0f0f0;
                                                                    --text-muted: rgba(255, 255, 255, 0.55);
                                                                    --text-faint: rgba(255, 255, 255, 0.25);
                                                                    --border: rgba(255, 255, 255, 0.06);
                                                                    --success: #51cf66;
                                                                    --danger: #ff6b6b;
                                                                    --warning: #ffd93d;
                                                                    --info: #74c0fc;
                                                                    --radius: 12px;
                                                                }

                                                                html,
                                                                body {
                                                                    height: 100%;
                                                                }

                                                                body {
                                                                    font-family: 'Inter', 'Segoe UI', sans-serif;
                                                                    background: var(--bg);
                                                                    color: var(--text);
                                                                    overflow-x: hidden;
                                                                }

                                                                /* ─── SIDEBAR ─── */
                                                                .sidebar {
                                                                    position: fixed;
                                                                    left: 0;
                                                                    top: 0;
                                                                    width: 260px;
                                                                    height: 100vh;
                                                                    background: var(--bg-panel);
                                                                    border-right: 1px solid var(--border);
                                                                    z-index: 1000;
                                                                    display: flex;
                                                                    flex-direction: column;
                                                                }

                                                                .sidebar-header {
                                                                    padding: 28px 24px;
                                                                    border-bottom: 1px solid var(--border);
                                                                }

                                                                .logo {
                                                                    font-size: 22px;
                                                                    font-weight: 700;
                                                                    letter-spacing: 1px;
                                                                    text-transform: lowercase;
                                                                    margin-bottom: 4px;
                                                                }

                                                                .logo span {
                                                                    color: var(--gold);
                                                                }

                                                                .logo-subtitle {
                                                                    font-size: 9px;
                                                                    letter-spacing: 2.5px;
                                                                    text-transform: uppercase;
                                                                    color: var(--accent-mgr);
                                                                    font-weight: 600;
                                                                }

                                                                .sidebar-menu {
                                                                    flex: 1;
                                                                    padding: 16px 0;
                                                                    overflow-y: auto;
                                                                }

                                                                .menu-section {
                                                                    margin-bottom: 24px;
                                                                }

                                                                .menu-title {
                                                                    font-size: 9px;
                                                                    letter-spacing: 2.5px;
                                                                    text-transform: uppercase;
                                                                    color: var(--text-faint);
                                                                    padding: 0 24px;
                                                                    margin-bottom: 8px;
                                                                    font-weight: 600;
                                                                }

                                                                .menu-item {
                                                                    display: flex;
                                                                    align-items: center;
                                                                    gap: 14px;
                                                                    padding: 12px 24px;
                                                                    color: var(--text-muted);
                                                                    text-decoration: none;
                                                                    font-size: 13px;
                                                                    font-weight: 400;
                                                                    border-left: 3px solid transparent;
                                                                    transition: all 0.25s ease;
                                                                    cursor: pointer;
                                                                }

                                                                .menu-item:hover {
                                                                    background: rgba(255, 255, 255, 0.03);
                                                                    color: var(--gold);
                                                                    border-left-color: var(--gold);
                                                                }

                                                                .menu-item.active {
                                                                    background: var(--gold-pale);
                                                                    color: var(--gold);
                                                                    border-left-color: var(--gold);
                                                                    font-weight: 500;
                                                                }

                                                                .menu-icon {
                                                                    font-size: 17px;
                                                                    width: 22px;
                                                                    text-align: center;
                                                                }

                                                                .sidebar-footer {
                                                                    padding: 18px 24px;
                                                                    border-top: 1px solid var(--border);
                                                                }

                                                                .user-info {
                                                                    display: flex;
                                                                    align-items: center;
                                                                    gap: 12px;
                                                                    margin-bottom: 14px;
                                                                }

                                                                .user-avatar {
                                                                    width: 38px;
                                                                    height: 38px;
                                                                    border-radius: 50%;
                                                                    background: linear-gradient(135deg, var(--accent-mgr), var(--gold));
                                                                    display: grid;
                                                                    place-items: center;
                                                                    font-weight: 700;
                                                                    color: #0b0b0f;
                                                                    font-size: 14px;
                                                                }

                                                                .user-details {
                                                                    flex: 1;
                                                                }

                                                                .user-name {
                                                                    font-size: 13px;
                                                                    font-weight: 600;
                                                                }

                                                                .user-role {
                                                                    font-size: 9px;
                                                                    letter-spacing: 1.5px;
                                                                    text-transform: uppercase;
                                                                    color: var(--accent-mgr);
                                                                }

                                                                .logout-btn {
                                                                    width: 100%;
                                                                    padding: 10px;
                                                                    background: rgba(255, 255, 255, 0.04);
                                                                    border: 1px solid var(--border);
                                                                    border-radius: 8px;
                                                                    color: var(--text-muted);
                                                                    font-size: 11px;
                                                                    letter-spacing: 1px;
                                                                    text-transform: uppercase;
                                                                    cursor: pointer;
                                                                    transition: all 0.25s;
                                                                    font-family: inherit;
                                                                }

                                                                .logout-btn:hover {
                                                                    background: rgba(255, 107, 107, 0.08);
                                                                    border-color: rgba(255, 107, 107, 0.25);
                                                                    color: var(--danger);
                                                                }

                                                                /* ─── MAIN ─── */
                                                                .main-content {
                                                                    margin-left: 260px;
                                                                    min-height: 100vh;
                                                                }

                                                                .top-bar {
                                                                    background: rgba(14, 14, 20, 0.92);
                                                                    backdrop-filter: blur(12px);
                                                                    border-bottom: 1px solid var(--border);
                                                                    padding: 18px 36px;
                                                                    display: flex;
                                                                    justify-content: space-between;
                                                                    align-items: center;
                                                                    position: sticky;
                                                                    top: 0;
                                                                    z-index: 999;
                                                                }

                                                                .page-title {
                                                                    font-size: 22px;
                                                                    font-weight: 400;
                                                                    letter-spacing: 1px;
                                                                }

                                                                .page-title em {
                                                                    font-style: normal;
                                                                    color: var(--accent-mgr);
                                                                    font-weight: 600;
                                                                }

                                                                .top-actions {
                                                                    display: flex;
                                                                    gap: 12px;
                                                                    align-items: center;
                                                                }

                                                                .search-box {
                                                                    position: relative;
                                                                }

                                                                .search-box input {
                                                                    background: rgba(255, 255, 255, 0.04);
                                                                    border: 1px solid var(--border);
                                                                    border-radius: 20px;
                                                                    padding: 10px 18px 10px 38px;
                                                                    color: #fff;
                                                                    font-size: 12px;
                                                                    width: 240px;
                                                                    transition: all 0.3s;
                                                                    font-family: inherit;
                                                                }

                                                                .search-box input:focus {
                                                                    outline: none;
                                                                    border-color: var(--gold);
                                                                    width: 300px;
                                                                }

                                                                .search-icon {
                                                                    position: absolute;
                                                                    left: 14px;
                                                                    top: 50%;
                                                                    transform: translateY(-50%);
                                                                    color: var(--text-faint);
                                                                }

                                                                /* ─── DASHBOARD ─── */
                                                                .dashboard-content {
                                                                    padding: 32px 36px;
                                                                }

                                                                /* Toast */
                                                                .toast {
                                                                    position: fixed;
                                                                    top: 80px;
                                                                    right: 36px;
                                                                    padding: 16px 24px;
                                                                    border-radius: 10px;
                                                                    font-size: 13px;
                                                                    font-weight: 500;
                                                                    z-index: 10000;
                                                                    animation: slideInRight 0.4s ease, fadeOut 0.4s ease 3.6s forwards;
                                                                    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
                                                                }

                                                                .toast.success {
                                                                    background: rgba(81, 207, 102, 0.12);
                                                                    border: 1px solid rgba(81, 207, 102, 0.3);
                                                                    color: var(--success);
                                                                }

                                                                .toast.error {
                                                                    background: rgba(255, 107, 107, 0.12);
                                                                    border: 1px solid rgba(255, 107, 107, 0.3);
                                                                    color: var(--danger);
                                                                }

                                                                @keyframes slideInRight {
                                                                    from {
                                                                        transform: translateX(100px);
                                                                        opacity: 0;
                                                                    }

                                                                    to {
                                                                        transform: translateX(0);
                                                                        opacity: 1;
                                                                    }
                                                                }

                                                                @keyframes fadeOut {
                                                                    to {
                                                                        opacity: 0;
                                                                        transform: translateY(-10px);
                                                                    }
                                                                }

                                                                /* Stats */
                                                                .stats-grid {
                                                                    display: grid;
                                                                    grid-template-columns: repeat(4, 1fr);
                                                                    gap: 20px;
                                                                    margin-bottom: 32px;
                                                                }

                                                                .stat-card {
                                                                    background: var(--bg-card);
                                                                    border: 1px solid var(--border);
                                                                    border-radius: var(--radius);
                                                                    padding: 22px;
                                                                    position: relative;
                                                                    overflow: hidden;
                                                                    transition: all 0.3s;
                                                                }

                                                                .stat-card::before {
                                                                    content: '';
                                                                    position: absolute;
                                                                    top: 0;
                                                                    left: 0;
                                                                    right: 0;
                                                                    height: 2px;
                                                                    opacity: 0;
                                                                    transition: opacity 0.3s;
                                                                }

                                                                .stat-card:nth-child(1)::before {
                                                                    background: linear-gradient(90deg, var(--gold), var(--gold-light));
                                                                }

                                                                .stat-card:nth-child(2)::before {
                                                                    background: linear-gradient(90deg, var(--info), #a5d8ff);
                                                                }

                                                                .stat-card:nth-child(3)::before {
                                                                    background: linear-gradient(90deg, var(--success), #b2f2bb);
                                                                }

                                                                .stat-card:nth-child(4)::before {
                                                                    background: linear-gradient(90deg, var(--accent-mgr), #f4a582);
                                                                }

                                                                .stat-card:hover {
                                                                    border-color: rgba(201, 165, 92, 0.2);
                                                                    transform: translateY(-3px);
                                                                }

                                                                .stat-card:hover::before {
                                                                    opacity: 1;
                                                                }

                                                                .stat-header {
                                                                    display: flex;
                                                                    justify-content: space-between;
                                                                    align-items: flex-start;
                                                                    margin-bottom: 12px;
                                                                }

                                                                .stat-icon {
                                                                    width: 44px;
                                                                    height: 44px;
                                                                    background: var(--gold-pale);
                                                                    border-radius: 10px;
                                                                    display: grid;
                                                                    place-items: center;
                                                                    font-size: 20px;
                                                                }

                                                                .stat-label {
                                                                    font-size: 10px;
                                                                    letter-spacing: 2px;
                                                                    text-transform: uppercase;
                                                                    color: var(--text-faint);
                                                                    margin-bottom: 6px;
                                                                }

                                                                .stat-value {
                                                                    font-size: 28px;
                                                                    font-weight: 700;
                                                                    color: var(--gold);
                                                                }

                                                                .stat-change {
                                                                    font-size: 10px;
                                                                    color: var(--text-muted);
                                                                    margin-top: 4px;
                                                                }

                                                                /* TAB NAVIGATION */
                                                                .tab-nav {
                                                                    display: flex;
                                                                    gap: 4px;
                                                                    background: var(--bg-card);
                                                                    border: 1px solid var(--border);
                                                                    border-radius: 10px;
                                                                    padding: 4px;
                                                                    margin-bottom: 28px;
                                                                    width: fit-content;
                                                                }

                                                                .tab-btn {
                                                                    padding: 10px 22px;
                                                                    border: none;
                                                                    border-radius: 8px;
                                                                    background: transparent;
                                                                    color: var(--text-muted);
                                                                    font-size: 12px;
                                                                    font-weight: 500;
                                                                    letter-spacing: 0.5px;
                                                                    cursor: pointer;
                                                                    transition: all 0.25s;
                                                                    font-family: inherit;
                                                                }

                                                                .tab-btn:hover {
                                                                    color: var(--text);
                                                                    background: rgba(255, 255, 255, 0.04);
                                                                }

                                                                .tab-btn.active {
                                                                    background: var(--gold);
                                                                    color: #0b0b0f;
                                                                    font-weight: 600;
                                                                    box-shadow: 0 4px 16px rgba(201, 165, 92, 0.25);
                                                                }

                                                                .tab-content {
                                                                    display: none;
                                                                    animation: tabFade 0.4s ease;
                                                                }

                                                                .tab-content.active {
                                                                    display: block;
                                                                }

                                                                @keyframes tabFade {
                                                                    from {
                                                                        opacity: 0;
                                                                        transform: translateY(10px);
                                                                    }

                                                                    to {
                                                                        opacity: 1;
                                                                        transform: translateY(0);
                                                                    }
                                                                }

                                                                /* TABLE */
                                                                .data-panel {
                                                                    background: var(--bg-card);
                                                                    border: 1px solid var(--border);
                                                                    border-radius: var(--radius);
                                                                    overflow: hidden;
                                                                }

                                                                .panel-header {
                                                                    padding: 20px 24px;
                                                                    border-bottom: 1px solid var(--border);
                                                                    display: flex;
                                                                    justify-content: space-between;
                                                                    align-items: center;
                                                                }

                                                                .panel-title {
                                                                    font-size: 16px;
                                                                    font-weight: 500;
                                                                    letter-spacing: 0.5px;
                                                                }

                                                                .panel-count {
                                                                    font-size: 11px;
                                                                    background: var(--gold-pale);
                                                                    color: var(--gold);
                                                                    padding: 4px 12px;
                                                                    border-radius: 20px;
                                                                    font-weight: 600;
                                                                }

                                                                .data-table {
                                                                    width: 100%;
                                                                    border-collapse: collapse;
                                                                }

                                                                .data-table thead th {
                                                                    font-size: 10px;
                                                                    font-weight: 600;
                                                                    letter-spacing: 2px;
                                                                    text-transform: uppercase;
                                                                    color: var(--text-faint);
                                                                    padding: 14px 20px;
                                                                    text-align: left;
                                                                    background: rgba(255, 255, 255, 0.02);
                                                                    border-bottom: 1px solid var(--border);
                                                                }

                                                                .data-table tbody td {
                                                                    padding: 14px 20px;
                                                                    font-size: 13px;
                                                                    border-bottom: 1px solid var(--border);
                                                                    color: var(--text-muted);
                                                                }

                                                                .data-table tbody tr {
                                                                    transition: background 0.2s;
                                                                }

                                                                .data-table tbody tr:hover {
                                                                    background: rgba(255, 255, 255, 0.02);
                                                                }

                                                                .data-table tbody tr:last-child td {
                                                                    border-bottom: none;
                                                                }

                                                                .status-badge {
                                                                    display: inline-block;
                                                                    padding: 4px 10px;
                                                                    border-radius: 20px;
                                                                    font-size: 10px;
                                                                    font-weight: 600;
                                                                    letter-spacing: 0.5px;
                                                                    text-transform: uppercase;
                                                                }

                                                                .status-badge.available,
                                                                .status-badge.confirmed {
                                                                    background: rgba(81, 207, 102, 0.1);
                                                                    color: var(--success);
                                                                }

                                                                .status-badge.occupied,
                                                                .status-badge.pending {
                                                                    background: rgba(255, 211, 61, 0.1);
                                                                    color: var(--warning);
                                                                }

                                                                .status-badge.maintenance,
                                                                .status-badge.cancelled {
                                                                    background: rgba(255, 107, 107, 0.1);
                                                                    color: var(--danger);
                                                                }

                                                                /* FORMS */
                                                                .add-staff-panel {
                                                                    background: var(--bg-card);
                                                                    border: 1px solid var(--border);
                                                                    border-radius: var(--radius);
                                                                    padding: 28px;
                                                                    margin-bottom: 24px;
                                                                }

                                                                .form-title {
                                                                    font-size: 16px;
                                                                    font-weight: 500;
                                                                    margin-bottom: 20px;
                                                                    display: flex;
                                                                    align-items: center;
                                                                    gap: 10px;
                                                                }

                                                                .form-grid {
                                                                    display: grid;
                                                                    grid-template-columns: repeat(3, 1fr);
                                                                    gap: 16px;
                                                                }

                                                                .form-group {
                                                                    display: flex;
                                                                    flex-direction: column;
                                                                    gap: 6px;
                                                                }

                                                                .form-group label {
                                                                    font-size: 10px;
                                                                    letter-spacing: 1.5px;
                                                                    text-transform: uppercase;
                                                                    color: var(--text-faint);
                                                                    font-weight: 600;
                                                                }

                                                                .form-group input,
                                                                .form-group select {
                                                                    background: rgba(255, 255, 255, 0.04);
                                                                    border: 1px solid var(--border);
                                                                    border-radius: 8px;
                                                                    padding: 12px 16px;
                                                                    color: #fff;
                                                                    font-size: 13px;
                                                                    transition: all 0.25s;
                                                                    font-family: inherit;
                                                                }

                                                                .form-group input:focus,
                                                                .form-group select:focus {
                                                                    outline: none;
                                                                    border-color: var(--gold);
                                                                    background: rgba(255, 255, 255, 0.06);
                                                                    box-shadow: 0 0 0 3px rgba(201, 165, 92, 0.08);
                                                                }

                                                                .form-group input::placeholder {
                                                                    color: var(--text-faint);
                                                                }

                                                                .form-group select option {
                                                                    background: #1a1a24;
                                                                    color: #fff;
                                                                }

                                                                .form-actions {
                                                                    margin-top: 20px;
                                                                    display: flex;
                                                                    gap: 12px;
                                                                    justify-content: flex-end;
                                                                }

                                                                .btn {
                                                                    padding: 12px 28px;
                                                                    border: none;
                                                                    border-radius: 8px;
                                                                    font-size: 12px;
                                                                    font-weight: 600;
                                                                    letter-spacing: 1px;
                                                                    text-transform: uppercase;
                                                                    cursor: pointer;
                                                                    transition: all 0.25s;
                                                                    font-family: inherit;
                                                                }

                                                                .btn-primary {
                                                                    background: var(--gold);
                                                                    color: #0b0b0f;
                                                                    box-shadow: 0 4px 16px rgba(201, 165, 92, 0.2);
                                                                }

                                                                .btn-primary:hover {
                                                                    transform: translateY(-2px);
                                                                    box-shadow: 0 8px 24px rgba(201, 165, 92, 0.3);
                                                                }

                                                                .btn-ghost {
                                                                    background: transparent;
                                                                    border: 1px solid var(--border);
                                                                    color: var(--text-muted);
                                                                }

                                                                .btn-ghost:hover {
                                                                    background: rgba(255, 255, 255, 0.04);
                                                                    color: var(--text);
                                                                }

                                                                .btn-danger-sm {
                                                                    padding: 6px 14px;
                                                                    background: rgba(255, 107, 107, 0.08);
                                                                    border: 1px solid rgba(255, 107, 107, 0.2);
                                                                    border-radius: 6px;
                                                                    color: var(--danger);
                                                                    font-size: 11px;
                                                                    font-weight: 500;
                                                                    cursor: pointer;
                                                                    transition: all 0.25s;
                                                                    font-family: inherit;
                                                                }

                                                                .btn-danger-sm:hover {
                                                                    background: rgba(255, 107, 107, 0.15);
                                                                    border-color: rgba(255, 107, 107, 0.4);
                                                                }

                                                                /* EMPTY STATE */
                                                                .empty-state {
                                                                    text-align: center;
                                                                    padding: 60px 24px;
                                                                    color: var(--text-faint);
                                                                }

                                                                .empty-state-icon {
                                                                    font-size: 48px;
                                                                    margin-bottom: 16px;
                                                                }

                                                                .empty-state-text {
                                                                    font-size: 14px;
                                                                }

                                                                /* RESPONSIVE */
                                                                @media (max-width: 1200px) {
                                                                    .stats-grid {
                                                                        grid-template-columns: repeat(2, 1fr);
                                                                    }

                                                                    .form-grid {
                                                                        grid-template-columns: repeat(2, 1fr);
                                                                    }
                                                                }

                                                                @media (max-width: 1024px) {
                                                                    .sidebar {
                                                                        width: 72px;
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

                                                                    .menu-item span:not(.menu-icon) {
                                                                        display: none;
                                                                    }

                                                                    .main-content {
                                                                        margin-left: 72px;
                                                                    }
                                                                }

                                                                @media (max-width: 768px) {
                                                                    .sidebar {
                                                                        transform: translateX(-100%);
                                                                    }

                                                                    .sidebar.mobile-open {
                                                                        transform: translateX(0);
                                                                        width: 260px;
                                                                    }

                                                                    .main-content {
                                                                        margin-left: 0;
                                                                    }

                                                                    .dashboard-content {
                                                                        padding: 20px 16px;
                                                                    }

                                                                    .stats-grid {
                                                                        grid-template-columns: 1fr;
                                                                    }

                                                                    .form-grid {
                                                                        grid-template-columns: 1fr;
                                                                    }

                                                                    .tab-nav {
                                                                        flex-wrap: wrap;
                                                                    }

                                                                    .data-table {
                                                                        font-size: 11px;
                                                                    }
                                                                }

                                                                /* Scrollbar */
                                                                ::-webkit-scrollbar {
                                                                    width: 6px;
                                                                }

                                                                ::-webkit-scrollbar-track {
                                                                    background: transparent;
                                                                }

                                                                ::-webkit-scrollbar-thumb {
                                                                    background: rgba(255, 255, 255, 0.1);
                                                                    border-radius: 3px;
                                                                }

                                                                ::-webkit-scrollbar-thumb:hover {
                                                                    background: rgba(255, 255, 255, 0.2);
                                                                }
                                                            </style>
                                                        </head>

                                                        <body>

                                                            <!-- Toast Notification -->
                                                            <% if (msg !=null) { %>
                                                                <div class="toast <%= " success".equals(msgType)
                                                                    ? "success" : "error" %>" id="toast">
                                                                    <%= "success" .equals(msgType) ? "✓" : "✕" %>&nbsp;
                                                                        <%= msg %>
                                                                </div>
                                                                <% } %>

                                                                    <!-- ═══════ SIDEBAR ═══════ -->
                                                                    <aside class="sidebar" id="sidebar">
                                                                        <div class="sidebar-header">
                                                                            <div class="logo">ocean<span>.view</span>
                                                                            </div>
                                                                            <div class="logo-subtitle">Manager Portal
                                                                            </div>
                                                                        </div>

                                                                        <nav class="sidebar-menu">
                                                                            <div class="menu-section">
                                                                                <div class="menu-title">Dashboard</div>
                                                                                <a href="#" class="menu-item active"
                                                                                    onclick="switchTab('overview'); return false;">
                                                                                    <span class="menu-icon">📊</span>
                                                                                    <span>Overview</span>
                                                                                </a>
                                                                            </div>

                                                                            <div class="menu-section">
                                                                                <div class="menu-title">Management</div>
                                                                                <a href="#" class="menu-item"
                                                                                    onclick="switchTab('reservations'); return false;">
                                                                                    <span class="menu-icon">📅</span>
                                                                                    <span>Reservations</span>
                                                                                </a>
                                                                                <a href="#" class="menu-item"
                                                                                    onclick="switchTab('rooms'); return false;">
                                                                                    <span class="menu-icon">🛏️</span>
                                                                                    <span>Rooms</span>
                                                                                </a>
                                                                                <a href="#" class="menu-item"
                                                                                    onclick="switchTab('staff'); return false;">
                                                                                    <span class="menu-icon">👥</span>
                                                                                    <span>Staff</span>
                                                                                </a>
                                                                            </div>


                                                                        </nav>

                                                                        <div class="sidebar-footer">
                                                                            <div class="user-info">
                                                                                <div class="user-avatar">
                                                                                    <%= username.substring(0,
                                                                                        1).toUpperCase() %>
                                                                                </div>
                                                                                <div class="user-details">
                                                                                    <div class="user-name">
                                                                                        <%= username %>
                                                                                    </div>
                                                                                    <div class="user-role">Manager</div>
                                                                                </div>
                                                                            </div>
                                                                            <form
                                                                                action="${pageContext.request.contextPath}/LogoutServlet"
                                                                                method="post" style="margin:0;">
                                                                                <button type="submit"
                                                                                    class="logout-btn">🚪
                                                                                    Logout</button>
                                                                            </form>
                                                                        </div>
                                                                    </aside>

                                                                    <!-- ═══════ MAIN CONTENT ═══════ -->
                                                                    <main class="main-content">
                                                                        <div class="top-bar">
                                                                            <h1 class="page-title"><em>Manager</em>
                                                                                Dashboard</h1>
                                                                            <div class="top-actions">
                                                                                <div class="search-box">
                                                                                    <span class="search-icon">🔍</span>
                                                                                    <input type="text"
                                                                                        placeholder="Search..."
                                                                                        id="globalSearch"
                                                                                        onkeyup="handleSearch(this.value)">
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="dashboard-content">

                                                                            <!-- Tab Navigation -->
                                                                            <div class="tab-nav">
                                                                                <button class="tab-btn active"
                                                                                    onclick="switchTab('overview')"
                                                                                    data-tab="overview">📊
                                                                                    Overview</button>
                                                                                <button class="tab-btn"
                                                                                    onclick="switchTab('reservations')"
                                                                                    data-tab="reservations">📅
                                                                                    Reservations</button>
                                                                                <button class="tab-btn"
                                                                                    onclick="switchTab('rooms')"
                                                                                    data-tab="rooms">🛏️ Rooms</button>
                                                                                <button class="tab-btn"
                                                                                    onclick="switchTab('staff')"
                                                                                    data-tab="staff">👥 Staff</button>
                                                                            </div>

                                                                            <!-- ═══════ TAB: OVERVIEW ═══════ -->
                                                                            <div class="tab-content active"
                                                                                id="tab-overview">
                                                                                <div class="stats-grid">
                                                                                    <div class="stat-card">
                                                                                        <div class="stat-header">
                                                                                            <div>
                                                                                                <div class="stat-label">
                                                                                                    Total Reservations
                                                                                                </div>
                                                                                                <div class="stat-value">
                                                                                                    <%= totalReservations
                                                                                                        %>
                                                                                                </div>
                                                                                                <div
                                                                                                    class="stat-change">
                                                                                                    All Time</div>
                                                                                            </div>
                                                                                            <div class="stat-icon">📋
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="stat-card">
                                                                                        <div class="stat-header">
                                                                                            <div>
                                                                                                <div class="stat-label">
                                                                                                    Available Rooms
                                                                                                </div>
                                                                                                <div class="stat-value">
                                                                                                    <%= availableRooms
                                                                                                        %>
                                                                                                </div>
                                                                                                <div
                                                                                                    class="stat-change">
                                                                                                    Live Availability
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="stat-icon">🏨
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="stat-card">
                                                                                        <div class="stat-header">
                                                                                            <div>
                                                                                                <div class="stat-label">
                                                                                                    Total Staff</div>
                                                                                                <div class="stat-value">
                                                                                                    <%= totalStaff %>
                                                                                                </div>
                                                                                                <div
                                                                                                    class="stat-change">
                                                                                                    Active Members</div>
                                                                                            </div>
                                                                                            <div class="stat-icon">👥
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="stat-card">
                                                                                        <div class="stat-header">
                                                                                            <div>
                                                                                                <div class="stat-label">
                                                                                                    Monthly Revenue
                                                                                                </div>
                                                                                                <div class="stat-value">
                                                                                                    <%= monthlyRevenueFormatted
                                                                                                        %>
                                                                                                </div>
                                                                                                <div
                                                                                                    class="stat-change">
                                                                                                    <%= java.time.LocalDate.now().getMonth().name()
                                                                                                        %>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="stat-icon">💵
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- Quick Overview Tables -->
                                                                                <div
                                                                                    style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px;">
                                                                                    <!-- Recent Reservations -->
                                                                                    <div class="data-panel">
                                                                                        <div class="panel-header">
                                                                                            <div class="panel-title">
                                                                                                Recent Reservations
                                                                                            </div>
                                                                                            <span class="panel-count">
                                                                                                <%= Math.min(reservations.size(),
                                                                                                    5) %> shown
                                                                                            </span>
                                                                                        </div>
                                                                                        <table class="data-table">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th>Reservation</th>
                                                                                                    <th>Guest</th>
                                                                                                    <th>Status</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <% int rCount=0; for
                                                                                                    (Reservation r :
                                                                                                    reservations) { if
                                                                                                    (rCount>= 5) break;
                                                                                                    rCount++; %>
                                                                                                    <tr>
                                                                                                        <td
                                                                                                            style="color: var(--gold); font-weight: 500;">
                                                                                                            <%= r.getReservationNo()
                                                                                                                %>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <%= r.getGuestName()
                                                                                                                %>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <span
                                                                                                                class="status-badge <%= r.getStatus() != null ? r.getStatus().toLowerCase() : "pending"
                                                                                                                %>">
                                                                                                                <%= r.getStatus()
                                                                                                                    !=null
                                                                                                                    ?
                                                                                                                    r.getStatus()
                                                                                                                    : "PENDING"
                                                                                                                    %>
                                                                                                            </span>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <% } %>
                                                                                                        <% if
                                                                                                            (reservations.isEmpty())
                                                                                                            { %>
                                                                                                            <tr>
                                                                                                                <td colspan="3"
                                                                                                                    style="text-align:center; color: var(--text-faint);">
                                                                                                                    No
                                                                                                                    reservations
                                                                                                                    found
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <% } %>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>

                                                                                    <!-- Staff Overview -->
                                                                                    <div class="data-panel">
                                                                                        <div class="panel-header">
                                                                                            <div class="panel-title">
                                                                                                Staff Members</div>
                                                                                            <span class="panel-count">
                                                                                                <%= Math.min(staffList.size(),
                                                                                                    5) %> shown
                                                                                            </span>
                                                                                        </div>
                                                                                        <table class="data-table">
                                                                                            <thead>
                                                                                                <tr>
                                                                                                    <th>Name</th>
                                                                                                    <th>Position</th>
                                                                                                    <th>Department</th>
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <% int sCount=0; for
                                                                                                    (Staff s :
                                                                                                    staffList) { if
                                                                                                    (sCount>= 5) break;
                                                                                                    sCount++; %>
                                                                                                    <tr>
                                                                                                        <td
                                                                                                            style="font-weight: 500;">
                                                                                                            <%= s.getFullName()
                                                                                                                %>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <%= s.getPosition()
                                                                                                                %>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <%= s.getDepartment()
                                                                                                                %>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <% } %>
                                                                                                        <% if
                                                                                                            (staffList.isEmpty())
                                                                                                            { %>
                                                                                                            <tr>
                                                                                                                <td colspan="3"
                                                                                                                    style="text-align:center; color: var(--text-faint);">
                                                                                                                    No
                                                                                                                    staff
                                                                                                                    members
                                                                                                                    yet
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <% } %>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                            </div>

                                                                            <!-- ═══════ TAB: RESERVATIONS ═══════ -->
                                                                            <div class="tab-content"
                                                                                id="tab-reservations">
                                                                                <div class="data-panel">
                                                                                    <div class="panel-header">
                                                                                        <div class="panel-title">All
                                                                                            Reservations</div>
                                                                                        <span class="panel-count">
                                                                                            <%= reservations.size() %>
                                                                                                total
                                                                                        </span>
                                                                                    </div>
                                                                                    <table class="data-table"
                                                                                        id="reservationsTable">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th>Reservation No</th>
                                                                                                <th>Guest Name</th>
                                                                                                <th>Email</th>
                                                                                                <th>Phone</th>
                                                                                                <th>Check-In</th>
                                                                                                <th>Check-Out</th>
                                                                                                <th>Guests</th>
                                                                                                <th>Status</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                            <% for (Reservation r :
                                                                                                reservations) { %>
                                                                                                <tr>
                                                                                                    <td
                                                                                                        style="color: var(--gold); font-weight: 500;">
                                                                                                        <%= r.getReservationNo()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        style="font-weight: 500;">
                                                                                                        <%= r.getGuestName()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= r.getGuestEmail()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= r.getPhoneNo()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= r.getCheckInDate()
                                                                                                            !=null ?
                                                                                                            r.getCheckInDate().toLocalDate()
                                                                                                            : "—" %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= r.getCheckOutDate()
                                                                                                            !=null ?
                                                                                                            r.getCheckOutDate().toLocalDate()
                                                                                                            : "—" %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        style="text-align: center;">
                                                                                                        <%= r.getNumGuests()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <span
                                                                                                            class="status-badge <%= r.getStatus() != null ? r.getStatus().toLowerCase() : "pending"

                                                                                                            %>">
                                                                                                            <%= r.getStatus()
                                                                                                                !=null ?
                                                                                                                r.getStatus()
                                                                                                                : "PENDING"
                                                                                                                %>
                                                                                                        </span>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <% } %>
                                                                                                    <% if
                                                                                                        (reservations.isEmpty())
                                                                                                        { %>
                                                                                                        <tr>
                                                                                                            <td
                                                                                                                colspan="8">
                                                                                                                <div
                                                                                                                    class="empty-state">
                                                                                                                    <div
                                                                                                                        class="empty-state-icon">
                                                                                                                        📅
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="empty-state-text">
                                                                                                                        No
                                                                                                                        reservations
                                                                                                                        found
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <% } %>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                            </div>

                                                                            <!-- ═══════ TAB: ROOMS ═══════ -->
                                                                            <div class="tab-content" id="tab-rooms">
                                                                                <div class="data-panel">
                                                                                    <div class="panel-header">
                                                                                        <div class="panel-title">All
                                                                                            Rooms</div>
                                                                                        <span class="panel-count">
                                                                                            <%= rooms.size() %> total
                                                                                        </span>
                                                                                    </div>
                                                                                    <table class="data-table"
                                                                                        id="roomsTable">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th>Room ID</th>
                                                                                                <th>Room Number</th>
                                                                                                <th>Room Type ID</th>
                                                                                                <th>Status</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                            <% for (Room rm : rooms) {
                                                                                                %>
                                                                                                <tr>
                                                                                                    <td
                                                                                                        style="color: var(--gold); font-weight: 500;">
                                                                                                        <%= rm.getRoomId()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        style="font-weight: 500;">
                                                                                                        <%= rm.getRoomNumber()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= rm.getRoomTypeId()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <span
                                                                                                            class="status-badge <%= rm.getStatus() != null ? rm.getStatus().toLowerCase() : "" %>">
                                                                                                            <%= rm.getStatus()
                                                                                                                !=null ?
                                                                                                                rm.getStatus()
                                                                                                                : "—" %>
                                                                                                        </span>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <% } %>
                                                                                                    <% if
                                                                                                        (rooms.isEmpty())
                                                                                                        { %>
                                                                                                        <tr>
                                                                                                            <td
                                                                                                                colspan="4">
                                                                                                                <div
                                                                                                                    class="empty-state">
                                                                                                                    <div
                                                                                                                        class="empty-state-icon">
                                                                                                                        🛏️
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="empty-state-text">
                                                                                                                        No
                                                                                                                        rooms
                                                                                                                        found
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <% } %>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                            </div>

                                                                            <!-- ═══════ TAB: STAFF ═══════ -->
                                                                            <div class="tab-content" id="tab-staff">

                                                                                <!-- Add Staff Form -->
                                                                                <div class="add-staff-panel">
                                                                                    <div class="form-title">➕ Add New
                                                                                        Staff Member</div>
                                                                                    <form
                                                                                        action="${pageContext.request.contextPath}/staff-servlet"
                                                                                        method="post">
                                                                                        <input type="hidden"
                                                                                            name="action" value="add">
                                                                                        <div class="form-grid">
                                                                                            <div class="form-group">
                                                                                                <label
                                                                                                    for="fullName">Full
                                                                                                    Name</label>
                                                                                                <input type="text"
                                                                                                    id="fullName"
                                                                                                    name="fullName"
                                                                                                    placeholder="e.g. John Doe"
                                                                                                    required>
                                                                                            </div>
                                                                                            <div class="form-group">
                                                                                                <label
                                                                                                    for="email">Email</label>
                                                                                                <input type="email"
                                                                                                    id="email"
                                                                                                    name="email"
                                                                                                    placeholder="e.g. john@oceanview.com"
                                                                                                    required>
                                                                                            </div>
                                                                                            <div class="form-group">
                                                                                                <label
                                                                                                    for="phone">Phone</label>
                                                                                                <input type="text"
                                                                                                    id="phone"
                                                                                                    name="phone"
                                                                                                    placeholder="e.g. +94 77 123 4567"
                                                                                                    required>
                                                                                            </div>
                                                                                            <div class="form-group">
                                                                                                <label
                                                                                                    for="position">Position</label>
                                                                                                <select id="position"
                                                                                                    name="position"
                                                                                                    required>
                                                                                                    <option value="">
                                                                                                        Select Position
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Receptionist">
                                                                                                        Receptionist
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Housekeeping">
                                                                                                        Housekeeping
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Chef">
                                                                                                        Chef</option>
                                                                                                    <option
                                                                                                        value="Waiter">
                                                                                                        Waiter</option>
                                                                                                    <option
                                                                                                        value="Security">
                                                                                                        Security
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Maintenance">
                                                                                                        Maintenance
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Concierge">
                                                                                                        Concierge
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Supervisor">
                                                                                                        Supervisor
                                                                                                    </option>
                                                                                                </select>
                                                                                            </div>
                                                                                            <div class="form-group">
                                                                                                <label
                                                                                                    for="department">Department</label>
                                                                                                <select id="department"
                                                                                                    name="department"
                                                                                                    required>
                                                                                                    <option value="">
                                                                                                        Select
                                                                                                        Department
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Front Office">
                                                                                                        Front Office
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Housekeeping">
                                                                                                        Housekeeping
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Food & Beverage">
                                                                                                        Food & Beverage
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Security">
                                                                                                        Security
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Maintenance">
                                                                                                        Maintenance
                                                                                                    </option>
                                                                                                    <option
                                                                                                        value="Guest Services">
                                                                                                        Guest Services
                                                                                                    </option>
                                                                                                </select>
                                                                                            </div>
                                                                                            <div class="form-group">
                                                                                                <label
                                                                                                    for="salary">Salary
                                                                                                    ($)</label>
                                                                                                <input type="number"
                                                                                                    id="salary"
                                                                                                    name="salary"
                                                                                                    placeholder="e.g. 35000"
                                                                                                    step="0.01"
                                                                                                    required>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-actions">
                                                                                            <button type="reset"
                                                                                                class="btn btn-ghost">Clear</button>
                                                                                            <button type="submit"
                                                                                                class="btn btn-primary">Add
                                                                                                Staff Member</button>
                                                                                        </div>
                                                                                    </form>
                                                                                </div>

                                                                                <!-- Staff Table -->
                                                                                <div class="data-panel">
                                                                                    <div class="panel-header">
                                                                                        <div class="panel-title">All
                                                                                            Staff Members</div>
                                                                                        <span class="panel-count">
                                                                                            <%= staffList.size() %>
                                                                                                members
                                                                                        </span>
                                                                                    </div>
                                                                                    <table class="data-table"
                                                                                        id="staffTable">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th>ID</th>
                                                                                                <th>Full Name</th>
                                                                                                <th>Email</th>
                                                                                                <th>Phone</th>
                                                                                                <th>Position</th>
                                                                                                <th>Department</th>
                                                                                                <th>Salary</th>
                                                                                                <th>Action</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                            <% for (Staff s : staffList)
                                                                                                { %>
                                                                                                <tr>
                                                                                                    <td
                                                                                                        style="color: var(--gold); font-weight: 500;">
                                                                                                        #<%= s.getStaffId()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td
                                                                                                        style="font-weight: 500;">
                                                                                                        <%= s.getFullName()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= s.getEmail()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= s.getPhone()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= s.getPosition()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <%= s.getDepartment()
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>$<%= String.format("%.2f",
                                                                                                            s.getSalary())
                                                                                                            %>
                                                                                                    </td>
                                                                                                    <td>
                                                                                                        <form
                                                                                                            action="${pageContext.request.contextPath}/staff-servlet"
                                                                                                            method="post"
                                                                                                            style="margin:0; display:inline;"
                                                                                                            onsubmit="return confirm('Are you sure you want to remove this staff member?');">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="action"
                                                                                                                value="delete">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="staffId"
                                                                                                                value="<%= s.getStaffId() %>">
                                                                                                            <button
                                                                                                                type="submit"
                                                                                                                class="btn-danger-sm">Remove</button>
                                                                                                        </form>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <% } %>
                                                                                                    <% if
                                                                                                        (staffList.isEmpty())
                                                                                                        { %>
                                                                                                        <tr>
                                                                                                            <td
                                                                                                                colspan="8">
                                                                                                                <div
                                                                                                                    class="empty-state">
                                                                                                                    <div
                                                                                                                        class="empty-state-icon">
                                                                                                                        👥
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="empty-state-text">
                                                                                                                        No
                                                                                                                        staff
                                                                                                                        members
                                                                                                                        yet.
                                                                                                                        Add
                                                                                                                        your
                                                                                                                        first
                                                                                                                        team
                                                                                                                        member
                                                                                                                        above!
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <% } %>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </main>

                                                                    <script>
                                                                        // ─── Tab Switching ───
                                                                        function switchTab(tabName) {
                                                                            // Hide all tabs
                                                                            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
                                                                            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                                                                            document.querySelectorAll('.menu-item').forEach(m => m.classList.remove('active'));

                                                                            // Show selected tab
                                                                            const tab = document.getElementById('tab-' + tabName);
                                                                            if (tab) tab.classList.add('active');

                                                                            // Activate tab button
                                                                            document.querySelectorAll('.tab-btn').forEach(b => {
                                                                                if (b.getAttribute('data-tab') === tabName) b.classList.add('active');
                                                                            });

                                                                            // Activate sidebar nav
                                                                            const sidebarLabels = { 'overview': 'Overview', 'reservations': 'Reservations', 'rooms': 'Rooms', 'staff': 'Staff' };
                                                                            document.querySelectorAll('.menu-item span:not(.menu-icon)').forEach(s => {
                                                                                if (s.textContent.trim() === sidebarLabels[tabName]) {
                                                                                    s.parentElement.classList.add('active');
                                                                                }
                                                                            });
                                                                        }

                                                                        // ─── Auto-hide toast ───
                                                                        const toast = document.getElementById('toast');
                                                                        if (toast) {
                                                                            setTimeout(() => { toast.remove(); }, 4000);
                                                                        }

                                                                        // ─── Open tab from URL param ───
                                                                        (function () {
                                                                            const params = new URLSearchParams(window.location.search);
                                                                            const tab = params.get('tab');
                                                                            if (tab && ['overview', 'reservations', 'rooms', 'staff'].includes(tab)) {
                                                                                switchTab(tab);
                                                                            }
                                                                        })();

                                                                        // ─── Simple search across visible tables ───
                                                                        function handleSearch(query) {
                                                                            query = query.toLowerCase();
                                                                            document.querySelectorAll('.tab-content.active .data-table tbody tr').forEach(row => {
                                                                                const text = row.textContent.toLowerCase();
                                                                                row.style.display = text.includes(query) ? '' : 'none';
                                                                            });
                                                                        }
                                                                    </script>

                                                        </body>

                                                        </html>