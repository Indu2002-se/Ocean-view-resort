<%-- Reports Page - Ocean View Resort Staff Dashboard --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page
            import="java.util.*, com.buddhi.oceanviewresort.model.entity.*, java.time.format.DateTimeFormatter, java.time.LocalDateTime, java.time.temporal.ChronoUnit"
            %>
            <% // Check if user is logged in
                 String username=(String) session.getAttribute("username"); String
                role=(String) session.getAttribute("role"); if (username==null) { response.sendRedirect("login.jsp");
                return; } // Data from ReportServlet
                 List<Reservation> reservations = (List<Reservation>)
                    request.getAttribute("reservations");
                    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
                            List<User> users = (List<User>) request.getAttribute("users");
                                    List<Room> rooms = (List<Room>) request.getAttribute("rooms");

                                            if (reservations == null) reservations = new ArrayList<>();
                                                if (bills == null) bills = new ArrayList<>();
                                                    if (users == null) users = new ArrayList<>();
                                                        if (rooms == null) rooms = new ArrayList<>();

                                                            // Pre-computed stats
                                                            double totalRevenue = request.getAttribute("totalRevenue")
                                                            != null ? (Double) request.getAttribute("totalRevenue") : 0;
                                                            int confirmedCount = request.getAttribute("confirmedCount")
                                                            != null ? (Integer) request.getAttribute("confirmedCount") :
                                                            0;
                                                            int pendingCount = request.getAttribute("pendingCount") !=
                                                            null ? (Integer) request.getAttribute("pendingCount") : 0;
                                                            int cancelledCount = request.getAttribute("cancelledCount")
                                                            != null ? (Integer) request.getAttribute("cancelledCount") :
                                                            0;
                                                            int standardRoomCount =
                                                            request.getAttribute("standardRoomCount") != null ?
                                                            (Integer) request.getAttribute("standardRoomCount") : 0;
                                                            int deluxeRoomCount =
                                                            request.getAttribute("deluxeRoomCount") != null ? (Integer)
                                                            request.getAttribute("deluxeRoomCount") : 0;
                                                            int suiteRoomCount = request.getAttribute("suiteRoomCount")
                                                            != null ? (Integer) request.getAttribute("suiteRoomCount") :
                                                            0;
                                                            int totalGuestsInReservations =
                                                            request.getAttribute("totalGuestsInReservations") != null ?
                                                            (Integer) request.getAttribute("totalGuestsInReservations")
                                                            : 0;
                                                            int availableRooms = request.getAttribute("availableRooms")
                                                            != null ? (Integer) request.getAttribute("availableRooms") :
                                                            0;
                                                            int occupiedRooms = request.getAttribute("occupiedRooms") !=
                                                            null ? (Integer) request.getAttribute("occupiedRooms") : 0;
                                                            int maintenanceRooms =
                                                            request.getAttribute("maintenanceRooms") != null ? (Integer)
                                                            request.getAttribute("maintenanceRooms") : 0;

                                                            int totalRooms = rooms.size();
                                                            double occupancyRate = totalRooms > 0 ? ((double)
                                                            occupiedRooms / totalRooms) * 100 : 0;
                                                            double avgBillAmount = bills.size() > 0 ? totalRevenue /
                                                            bills.size() : 0;
                                                            int totalReservations = reservations.size();

                                                            // Room type percentages for reservations
                                                            int roomTypeTotal = standardRoomCount + deluxeRoomCount +
                                                            suiteRoomCount;
                                                            double standardPct = roomTypeTotal > 0 ? ((double)
                                                            standardRoomCount / roomTypeTotal) * 100 : 0;
                                                            double deluxePct = roomTypeTotal > 0 ? ((double)
                                                            deluxeRoomCount / roomTypeTotal) * 100 : 0;
                                                            double suitePct = roomTypeTotal > 0 ? ((double)
                                                            suiteRoomCount / roomTypeTotal) * 100 : 0;

                                                            // Reservation status percentages
                                                            double confirmedPct = totalReservations > 0 ? ((double)
                                                            confirmedCount / totalReservations) * 100 : 0;
                                                            double pendingPct = totalReservations > 0 ? ((double)
                                                            pendingCount / totalReservations) * 100 : 0;
                                                            double cancelledPct = totalReservations > 0 ? ((double)
                                                            cancelledCount / totalReservations) * 100 : 0;

                                                            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MMM dd, yyyy");
                                                            DateTimeFormatter dtfFull = DateTimeFormatter.ofPattern("MMM dd, yyyy hh:mm a");

                                                            String reportError = (String)
                                                            request.getAttribute("reportError");
                                                            %>
                                                            <!DOCTYPE html>
                                                            <html lang="en">

                                                            <head>
                                                                <meta charset="UTF-8">
                                                                <meta name="viewport"
                                                                    content="width=device-width, initial-scale=1.0">
                                                                <title>Reports - Ocean View Resort</title>
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

                                                                    /* ===== SIDEBAR ===== */
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

                                                                    /* ===== MAIN CONTENT ===== */
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

                                                                    .page-content {
                                                                        padding: 40px;
                                                                    }

                                                                    /* ===== REPORT HEADER ===== */
                                                                    .report-header-banner {
                                                                        background: linear-gradient(135deg, rgba(201, 165, 92, 0.12), rgba(201, 165, 92, 0.04));
                                                                        border: 1px solid rgba(201, 165, 92, 0.2);
                                                                        border-radius: 14px;
                                                                        padding: 30px;
                                                                        margin-bottom: 30px;
                                                                        display: flex;
                                                                        justify-content: space-between;
                                                                        align-items: center;
                                                                    }

                                                                    .report-header-left {}

                                                                    .report-header-title {
                                                                        font-size: 26px;
                                                                        font-weight: 300;
                                                                        margin-bottom: 6px;
                                                                        letter-spacing: 1px;
                                                                    }

                                                                    .report-header-sub {
                                                                        font-size: 12px;
                                                                        color: rgba(255, 255, 255, 0.5);
                                                                    }

                                                                    .report-date-badge {
                                                                        background: rgba(201, 165, 92, 0.15);
                                                                        color: #c9a55c;
                                                                        padding: 8px 18px;
                                                                        border-radius: 20px;
                                                                        font-size: 11px;
                                                                        letter-spacing: 1px;
                                                                        font-weight: 600;
                                                                    }

                                                                    /* ===== KPI / STAT CARDS ===== */
                                                                    .kpi-grid {
                                                                        display: grid;
                                                                        grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
                                                                        gap: 20px;
                                                                        margin-bottom: 35px;
                                                                    }

                                                                    .kpi-card {
                                                                        background: rgba(13, 13, 13, 0.95);
                                                                        border: 1px solid rgba(255, 255, 255, 0.05);
                                                                        border-radius: 14px;
                                                                        padding: 26px;
                                                                        position: relative;
                                                                        overflow: hidden;
                                                                        transition: all 0.35s;
                                                                    }

                                                                    .kpi-card::before {
                                                                        content: '';
                                                                        position: absolute;
                                                                        top: 0;
                                                                        left: 0;
                                                                        right: 0;
                                                                        height: 3px;
                                                                        opacity: 0;
                                                                        transition: opacity 0.3s;
                                                                    }

                                                                    .kpi-card:hover {
                                                                        transform: translateY(-4px);
                                                                        border-color: rgba(201, 165, 92, 0.3);
                                                                    }

                                                                    .kpi-card:hover::before {
                                                                        opacity: 1;
                                                                    }

                                                                    .kpi-card.gold::before {
                                                                        background: linear-gradient(90deg, #c9a55c, #f4e5c3);
                                                                    }

                                                                    .kpi-card.green::before {
                                                                        background: linear-gradient(90deg, #51cf66, #8ce99a);
                                                                    }

                                                                    .kpi-card.blue::before {
                                                                        background: linear-gradient(90deg, #4dabf7, #a5d8ff);
                                                                    }

                                                                    .kpi-card.purple::before {
                                                                        background: linear-gradient(90deg, #cc5de8, #e599f7);
                                                                    }

                                                                    .kpi-icon {
                                                                        position: absolute;
                                                                        top: 22px;
                                                                        right: 22px;
                                                                        font-size: 30px;
                                                                        opacity: 0.25;
                                                                    }

                                                                    .kpi-label {
                                                                        font-size: 10px;
                                                                        letter-spacing: 2px;
                                                                        text-transform: uppercase;
                                                                        color: rgba(255, 255, 255, 0.45);
                                                                        margin-bottom: 10px;
                                                                    }

                                                                    .kpi-value {
                                                                        font-size: 30px;
                                                                        font-weight: 700;
                                                                        margin-bottom: 4px;
                                                                    }

                                                                    .kpi-value.gold-text {
                                                                        color: #c9a55c;
                                                                    }

                                                                    .kpi-value.green-text {
                                                                        color: #51cf66;
                                                                    }

                                                                    .kpi-value.blue-text {
                                                                        color: #4dabf7;
                                                                    }

                                                                    .kpi-value.purple-text {
                                                                        color: #cc5de8;
                                                                    }

                                                                    .kpi-sub {
                                                                        font-size: 11px;
                                                                        color: rgba(255, 255, 255, 0.4);
                                                                    }

                                                                    /* ===== SECTION PANELS ===== */
                                                                    .report-grid {
                                                                        display: grid;
                                                                        grid-template-columns: 1fr 1fr;
                                                                        gap: 25px;
                                                                        margin-bottom: 35px;
                                                                    }

                                                                    .report-grid.three-col {
                                                                        grid-template-columns: 1fr 1fr 1fr;
                                                                    }

                                                                    .report-panel {
                                                                        background: rgba(13, 13, 13, 0.95);
                                                                        border: 1px solid rgba(255, 255, 255, 0.05);
                                                                        border-radius: 14px;
                                                                        overflow: hidden;
                                                                    }

                                                                    .report-panel.full-width {
                                                                        grid-column: 1 / -1;
                                                                    }

                                                                    .panel-header {
                                                                        display: flex;
                                                                        justify-content: space-between;
                                                                        align-items: center;
                                                                        padding: 22px 28px;
                                                                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                                                                    }

                                                                    .panel-title {
                                                                        font-size: 16px;
                                                                        font-weight: 400;
                                                                        letter-spacing: 1px;
                                                                    }

                                                                    .panel-badge {
                                                                        font-size: 10px;
                                                                        letter-spacing: 1px;
                                                                        text-transform: uppercase;
                                                                        padding: 4px 12px;
                                                                        border-radius: 10px;
                                                                        font-weight: 600;
                                                                    }

                                                                    .panel-badge.live {
                                                                        background: rgba(81, 207, 102, 0.15);
                                                                        color: #51cf66;
                                                                    }

                                                                    .panel-body {
                                                                        padding: 28px;
                                                                    }

                                                                    /* ===== BAR CHART (CSS) ===== */
                                                                    .bar-chart {
                                                                        display: flex;
                                                                        flex-direction: column;
                                                                        gap: 18px;
                                                                    }

                                                                    .bar-row {
                                                                        display: flex;
                                                                        align-items: center;
                                                                        gap: 14px;
                                                                    }

                                                                    .bar-label {
                                                                        width: 100px;
                                                                        font-size: 12px;
                                                                        color: rgba(255, 255, 255, 0.7);
                                                                        text-align: right;
                                                                        flex-shrink: 0;
                                                                    }

                                                                    .bar-track {
                                                                        flex: 1;
                                                                        height: 28px;
                                                                        background: rgba(255, 255, 255, 0.04);
                                                                        border-radius: 6px;
                                                                        overflow: hidden;
                                                                        position: relative;
                                                                    }

                                                                    .bar-fill {
                                                                        height: 100%;
                                                                        border-radius: 6px;
                                                                        transition: width 1s cubic-bezier(.4, 0, .2, 1);
                                                                        display: flex;
                                                                        align-items: center;
                                                                        padding-left: 12px;
                                                                        font-size: 11px;
                                                                        font-weight: 600;
                                                                        color: #1a1a1a;
                                                                        min-width: 40px;
                                                                    }

                                                                    .bar-fill.gold {
                                                                        background: linear-gradient(90deg, #c9a55c, #f4e5c3);
                                                                    }

                                                                    .bar-fill.green {
                                                                        background: linear-gradient(90deg, #51cf66, #8ce99a);
                                                                    }

                                                                    .bar-fill.red {
                                                                        background: linear-gradient(90deg, #ff6b6b, #ffa8a8);
                                                                    }

                                                                    .bar-fill.blue {
                                                                        background: linear-gradient(90deg, #4dabf7, #a5d8ff);
                                                                    }

                                                                    .bar-fill.purple {
                                                                        background: linear-gradient(90deg, #cc5de8, #e599f7);
                                                                    }

                                                                    .bar-fill.amber {
                                                                        background: linear-gradient(90deg, #ffd93d, #ffe66d);
                                                                    }

                                                                    .bar-count {
                                                                        margin-left: auto;
                                                                        font-size: 13px;
                                                                        font-weight: 700;
                                                                        color: rgba(255, 255, 255, 0.8);
                                                                        width: 50px;
                                                                        text-align: right;
                                                                        flex-shrink: 0;
                                                                    }

                                                                    /* ===== DONUT / RING (CSS) ===== */
                                                                    .donut-container {
                                                                        display: flex;
                                                                        align-items: center;
                                                                        gap: 35px;
                                                                    }

                                                                    .donut-ring {
                                                                        width: 140px;
                                                                        height: 140px;
                                                                        position: relative;
                                                                        flex-shrink: 0;
                                                                    }

                                                                    .donut-ring svg {
                                                                        width: 140px;
                                                                        height: 140px;
                                                                        transform: rotate(-90deg);
                                                                    }

                                                                    .donut-ring circle {
                                                                        fill: none;
                                                                        stroke-width: 14;
                                                                    }

                                                                    .donut-bg {
                                                                        stroke: rgba(255, 255, 255, 0.06);
                                                                    }

                                                                    .donut-segment {
                                                                        transition: stroke-dasharray 1s cubic-bezier(.4, 0, .2, 1);
                                                                    }

                                                                    .donut-center {
                                                                        position: absolute;
                                                                        top: 50%;
                                                                        left: 50%;
                                                                        transform: translate(-50%, -50%);
                                                                        text-align: center;
                                                                    }

                                                                    .donut-center-value {
                                                                        font-size: 28px;
                                                                        font-weight: 700;
                                                                        color: #c9a55c;
                                                                        line-height: 1;
                                                                    }

                                                                    .donut-center-label {
                                                                        font-size: 9px;
                                                                        letter-spacing: 1px;
                                                                        text-transform: uppercase;
                                                                        color: rgba(255, 255, 255, 0.4);
                                                                        margin-top: 4px;
                                                                    }

                                                                    .donut-legend {
                                                                        display: flex;
                                                                        flex-direction: column;
                                                                        gap: 12px;
                                                                    }

                                                                    .legend-item {
                                                                        display: flex;
                                                                        align-items: center;
                                                                        gap: 10px;
                                                                        font-size: 13px;
                                                                    }

                                                                    .legend-dot {
                                                                        width: 10px;
                                                                        height: 10px;
                                                                        border-radius: 3px;
                                                                        flex-shrink: 0;
                                                                    }

                                                                    .legend-dot.gold {
                                                                        background: #c9a55c;
                                                                    }

                                                                    .legend-dot.blue {
                                                                        background: #4dabf7;
                                                                    }

                                                                    .legend-dot.purple {
                                                                        background: #cc5de8;
                                                                    }

                                                                    .legend-dot.green {
                                                                        background: #51cf66;
                                                                    }

                                                                    .legend-dot.amber {
                                                                        background: #ffd93d;
                                                                    }

                                                                    .legend-dot.red {
                                                                        background: #ff6b6b;
                                                                    }

                                                                    .legend-dot.gray {
                                                                        background: rgba(255, 255, 255, 0.2);
                                                                    }

                                                                    .legend-value {
                                                                        margin-left: auto;
                                                                        font-weight: 600;
                                                                        color: rgba(255, 255, 255, 0.8);
                                                                    }

                                                                    /* ===== RECENT BILLS TABLE ===== */
                                                                    .report-table {
                                                                        width: 100%;
                                                                        border-collapse: collapse;
                                                                    }

                                                                    .report-table thead th {
                                                                        text-align: left;
                                                                        padding: 14px 24px;
                                                                        font-size: 10px;
                                                                        letter-spacing: 2px;
                                                                        text-transform: uppercase;
                                                                        color: rgba(255, 255, 255, 0.4);
                                                                        background: rgba(255, 255, 255, 0.02);
                                                                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                                                                        font-weight: 600;
                                                                    }

                                                                    .report-table tbody tr {
                                                                        border-bottom: 1px solid rgba(255, 255, 255, 0.03);
                                                                        transition: background 0.3s;
                                                                    }

                                                                    .report-table tbody tr:hover {
                                                                        background: rgba(201, 165, 92, 0.04);
                                                                    }

                                                                    .report-table tbody tr:last-child {
                                                                        border-bottom: none;
                                                                    }

                                                                    .report-table tbody td {
                                                                        padding: 16px 24px;
                                                                        font-size: 13px;
                                                                        color: rgba(255, 255, 255, 0.8);
                                                                    }

                                                                    .amount-cell {
                                                                        font-weight: 700;
                                                                        color: #c9a55c !important;
                                                                    }

                                                                    .status-pill {
                                                                        display: inline-block;
                                                                        padding: 4px 12px;
                                                                        border-radius: 20px;
                                                                        font-size: 10px;
                                                                        letter-spacing: 1px;
                                                                        text-transform: uppercase;
                                                                        font-weight: 600;
                                                                    }

                                                                    .status-pill.confirmed {
                                                                        background: rgba(81, 207, 102, 0.12);
                                                                        color: #51cf66;
                                                                    }

                                                                    .status-pill.pending {
                                                                        background: rgba(255, 211, 61, 0.12);
                                                                        color: #ffd93d;
                                                                    }

                                                                    .status-pill.cancelled {
                                                                        background: rgba(255, 107, 107, 0.12);
                                                                        color: #ff6b6b;
                                                                    }

                                                                    .status-pill.paid {
                                                                        background: rgba(81, 207, 102, 0.12);
                                                                        color: #51cf66;
                                                                    }

                                                                    /* ===== PROGRESS / GAUGE ===== */
                                                                    .gauge-container {
                                                                        text-align: center;
                                                                    }

                                                                    .gauge-ring {
                                                                        width: 160px;
                                                                        height: 160px;
                                                                        position: relative;
                                                                        margin: 0 auto 16px;
                                                                    }

                                                                    .gauge-ring svg {
                                                                        width: 160px;
                                                                        height: 160px;
                                                                        transform: rotate(-90deg);
                                                                    }

                                                                    .gauge-ring circle {
                                                                        fill: none;
                                                                        stroke-width: 12;
                                                                    }

                                                                    .gauge-bg {
                                                                        stroke: rgba(255, 255, 255, 0.06);
                                                                    }

                                                                    .gauge-fill {
                                                                        transition: stroke-dasharray 1.2s cubic-bezier(.4, 0, .2, 1);
                                                                    }

                                                                    .gauge-center {
                                                                        position: absolute;
                                                                        top: 50%;
                                                                        left: 50%;
                                                                        transform: translate(-50%, -50%);
                                                                        text-align: center;
                                                                    }

                                                                    .gauge-pct {
                                                                        font-size: 34px;
                                                                        font-weight: 700;
                                                                        color: #c9a55c;
                                                                        line-height: 1;
                                                                    }

                                                                    .gauge-label {
                                                                        font-size: 9px;
                                                                        letter-spacing: 2px;
                                                                        text-transform: uppercase;
                                                                        color: rgba(255, 255, 255, 0.4);
                                                                        margin-top: 4px;
                                                                    }

                                                                    .gauge-desc {
                                                                        font-size: 12px;
                                                                        color: rgba(255, 255, 255, 0.5);
                                                                    }

                                                                    /* ===== EMPTY / ERROR ===== */
                                                                    .error-banner {
                                                                        background: rgba(220, 53, 69, 0.1);
                                                                        border: 1px solid rgba(220, 53, 69, 0.2);
                                                                        border-radius: 10px;
                                                                        padding: 16px 22px;
                                                                        margin-bottom: 25px;
                                                                        font-size: 13px;
                                                                        color: #ff6b6b;
                                                                        display: flex;
                                                                        align-items: center;
                                                                        gap: 10px;
                                                                    }

                                                                    .empty-panel {
                                                                        text-align: center;
                                                                        padding: 40px;
                                                                        color: rgba(255, 255, 255, 0.3);
                                                                        font-size: 13px;
                                                                    }

                                                                    /* ===== RESPONSIVE ===== */
                                                                    @media (max-width: 1200px) {
                                                                        .report-grid {
                                                                            grid-template-columns: 1fr;
                                                                        }

                                                                        .report-grid.three-col {
                                                                            grid-template-columns: 1fr;
                                                                        }
                                                                    }

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

                                                                        .menu-item span:not(.menu-icon) {
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

                                                                        .page-content {
                                                                            padding: 20px;
                                                                        }

                                                                        .kpi-grid {
                                                                            grid-template-columns: 1fr;
                                                                        }

                                                                        .report-header-banner {
                                                                            flex-direction: column;
                                                                            gap: 15px;
                                                                            align-items: flex-start;
                                                                        }

                                                                        .donut-container {
                                                                            flex-direction: column;
                                                                            align-items: center;
                                                                        }
                                                                    }

                                                                    /* ===== ANIMATIONS ===== */
                                                                    @keyframes fadeInUp {
                                                                        from {
                                                                            opacity: 0;
                                                                            transform: translateY(18px);
                                                                        }

                                                                        to {
                                                                            opacity: 1;
                                                                            transform: translateY(0);
                                                                        }
                                                                    }

                                                                    .kpi-card {
                                                                        animation: fadeInUp 0.5s ease backwards;
                                                                    }

                                                                    .kpi-card:nth-child(1) {
                                                                        animation-delay: 0.05s;
                                                                    }

                                                                    .kpi-card:nth-child(2) {
                                                                        animation-delay: 0.12s;
                                                                    }

                                                                    .kpi-card:nth-child(3) {
                                                                        animation-delay: 0.19s;
                                                                    }

                                                                    .kpi-card:nth-child(4) {
                                                                        animation-delay: 0.26s;
                                                                    }

                                                                    .kpi-card:nth-child(5) {
                                                                        animation-delay: 0.33s;
                                                                    }

                                                                    .report-panel {
                                                                        animation: fadeInUp 0.5s ease backwards;
                                                                        animation-delay: 0.35s;
                                                                    }
                                                                </style>
                                                            </head>

                                                            <body>
                                                                <!-- ===== SIDEBAR ===== -->
                                                                <aside class="sidebar" id="sidebar">
                                                                    <div class="sidebar-header">
                                                                        <div class="logo">ocean<span>.view</span></div>
                                                                        <div class="logo-subtitle">Resort Management
                                                                        </div>
                                                                    </div>
                                                                    <nav class="sidebar-menu">
                                                                        <div class="menu-section">
                                                                            <div class="menu-title">Main Menu</div>
                                                                            <a href="${pageContext.request.contextPath}/Dashboard/StaffDashboard.jsp"
                                                                                class="menu-item">
                                                                                <span
                                                                                    class="menu-icon">📊</span><span>Dashboard</span>
                                                                            </a>
                                                                            <a href="${pageContext.request.contextPath}/reservation-servlet"
                                                                                class="menu-item">
                                                                                <span
                                                                                    class="menu-icon">📅</span><span>Reservations</span>
                                                                            </a>
                                                                            <a href="${pageContext.request.contextPath}/Reservation/CreateReservation.jsp"
                                                                                class="menu-item">
                                                                                <span
                                                                                    class="menu-icon">➕</span><span>New
                                                                                    Reservation</span>
                                                                            </a>
                                                                            <a href="${pageContext.request.contextPath}/user-servlet?action=list"
                                                                                class="menu-item">
                                                                                <span
                                                                                    class="menu-icon">👥</span><span>Guests</span>
                                                                            </a>
                                                                            <a href="${pageContext.request.contextPath}/room-servlet?action=list"
                                                                                class="menu-item">
                                                                                <span
                                                                                    class="menu-icon">🛏️</span><span>Rooms</span>
                                                                            </a>
                                                                        </div>
                                                                        <div class="menu-section">
                                                                            <div class="menu-title">Reports & Billing
                                                                            </div>
                                                                            <a href="${pageContext.request.contextPath}/bill-servlet"
                                                                                class="menu-item">
                                                                                <span
                                                                                    class="menu-icon">💰</span><span>Billing</span>
                                                                            </a>
                                                                            <a href="${pageContext.request.contextPath}/report-servlet"
                                                                                class="menu-item active">
                                                                                <span
                                                                                    class="menu-icon">📈</span><span>Reports</span>
                                                                            </a>
                                                                        </div>
                                                                        <% if ("STAFF".equals(role)) { %>
                                                                            <div class="menu-section">
                                                                                <div class="menu-title">Administration
                                                                                </div>
                                                                                <a href="users.jsp" class="menu-item">
                                                                                    <span
                                                                                        class="menu-icon">👔</span><span>User
                                                                                        Management</span>
                                                                                </a>
                                                                                <a href="settings.jsp"
                                                                                    class="menu-item">
                                                                                    <span
                                                                                        class="menu-icon">⚙️</span><span>Settings</span>
                                                                                </a>
                                                                            </div>
                                                                            <% } %>
                                                                                <div class="menu-section">
                                                                                    <div class="menu-title">Support
                                                                                    </div>
                                                                                    <a href="${pageContext.request.contextPath}/help-servlet"
                                                                                        class="menu-item">
                                                                                        <span
                                                                                            class="menu-icon">❓</span><span>Help
                                                                                            & Guide</span>
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
                                                                                <div class="user-role">
                                                                                    <%= role %>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <form action="LogoutServlet" method="post"
                                                                            style="margin:0;">
                                                                            <button type="submit" class="logout-btn">🚪
                                                                                Logout</button>
                                                                        </form>
                                                                    </div>
                                                                </aside>

                                                                <!-- ===== MAIN ===== -->
                                                                <main class="main-content">
                                                                    <div class="top-bar">
                                                                        <h1 class="page-title">Reports & Analytics</h1>
                                                                    </div>

                                                                    <div class="page-content">

                                                                        <% if (reportError !=null) { %>
                                                                            <div class="error-banner">⚠️ <%= reportError
                                                                                    %>
                                                                            </div>
                                                                            <% } %>

                                                                                <!-- Report Header -->
                                                                                <div class="report-header-banner">
                                                                                    <div class="report-header-left">
                                                                                        <div
                                                                                            class="report-header-title">
                                                                                            Resort Performance Overview
                                                                                        </div>
                                                                                        <div class="report-header-sub">
                                                                                            Comprehensive analytics for
                                                                                            Ocean View Resort operations
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="report-date-badge">
                                                                                        📅 Generated: <%=
                                                                                            LocalDateTime.now().format(dtf)
                                                                                            %>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- ===== KPI CARDS ===== -->
                                                                                <div class="kpi-grid">
                                                                                    <div class="kpi-card gold">
                                                                                        <div class="kpi-icon">💵</div>
                                                                                        <div class="kpi-label">Total
                                                                                            Revenue</div>
                                                                                        <div
                                                                                            class="kpi-value gold-text">
                                                                                            $<%= String.format("%,.2f",
                                                                                                totalRevenue) %>
                                                                                        </div>
                                                                                        <div class="kpi-sub">
                                                                                            <%= bills.size() %> bills
                                                                                                generated
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="kpi-card green">
                                                                                        <div class="kpi-icon">📋</div>
                                                                                        <div class="kpi-label">Total
                                                                                            Reservations</div>
                                                                                        <div
                                                                                            class="kpi-value green-text">
                                                                                            <%= totalReservations %>
                                                                                        </div>
                                                                                        <div class="kpi-sub">
                                                                                            <%= confirmedCount %>
                                                                                                confirmed
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="kpi-card blue">
                                                                                        <div class="kpi-icon">👥</div>
                                                                                        <div class="kpi-label">
                                                                                            Registered Guests</div>
                                                                                        <div
                                                                                            class="kpi-value blue-text">
                                                                                            <%= users.size() %>
                                                                                        </div>
                                                                                        <div class="kpi-sub">
                                                                                            <%= totalGuestsInReservations
                                                                                                %> guests in bookings
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="kpi-card purple">
                                                                                        <div class="kpi-icon">🏨</div>
                                                                                        <div class="kpi-label">Total
                                                                                            Rooms</div>
                                                                                        <div
                                                                                            class="kpi-value purple-text">
                                                                                            <%= totalRooms %>
                                                                                        </div>
                                                                                        <div class="kpi-sub">
                                                                                            <%= availableRooms %>
                                                                                                available
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="kpi-card gold">
                                                                                        <div class="kpi-icon">💰</div>
                                                                                        <div class="kpi-label">Avg Bill
                                                                                            Amount</div>
                                                                                        <div
                                                                                            class="kpi-value gold-text">
                                                                                            $<%= String.format("%,.2f",
                                                                                                avgBillAmount) %>
                                                                                        </div>
                                                                                        <div class="kpi-sub">Per
                                                                                            reservation</div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- ===== ROW 1: Reservation Status + Room Type Distribution ===== -->
                                                                                <div class="report-grid">
                                                                                    <!-- Reservation Status Breakdown -->
                                                                                    <div class="report-panel">
                                                                                        <div class="panel-header">
                                                                                            <h2 class="panel-title">📋
                                                                                                Reservation Status</h2>
                                                                                            <span
                                                                                                class="panel-badge live">●
                                                                                                Live</span>
                                                                                        </div>
                                                                                        <div class="panel-body">
                                                                                            <% if (totalReservations==0)
                                                                                                { %>
                                                                                                <div
                                                                                                    class="empty-panel">
                                                                                                    No reservations
                                                                                                    found</div>
                                                                                                <% } else { %>
                                                                                                    <div
                                                                                                        class="bar-chart">
                                                                                                        <div
                                                                                                            class="bar-row">
                                                                                                            <div
                                                                                                                class="bar-label">
                                                                                                                Confirmed
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="bar-track">
                                                                                                                <div class="bar-fill green"
                                                                                                                    style="width: <%= confirmedPct %>%;">
                                                                                                                    <%= String.format("%.0f",
                                                                                                                        confirmedPct)
                                                                                                                        %>
                                                                                                                        %
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="bar-count">
                                                                                                                <%= confirmedCount
                                                                                                                    %>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div
                                                                                                            class="bar-row">
                                                                                                            <div
                                                                                                                class="bar-label">
                                                                                                                Pending
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="bar-track">
                                                                                                                <div class="bar-fill amber"
                                                                                                                    style="width: <%= pendingPct %>%;">
                                                                                                                    <%= String.format("%.0f",
                                                                                                                        pendingPct)
                                                                                                                        %>
                                                                                                                        %
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="bar-count">
                                                                                                                <%= pendingCount
                                                                                                                    %>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div
                                                                                                            class="bar-row">
                                                                                                            <div
                                                                                                                class="bar-label">
                                                                                                                Cancelled
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="bar-track">
                                                                                                                <div class="bar-fill red"
                                                                                                                    style="width: <%= cancelledPct %>%;">
                                                                                                                    <%= String.format("%.0f",
                                                                                                                        cancelledPct)
                                                                                                                        %>
                                                                                                                        %
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="bar-count">
                                                                                                                <%= cancelledCount
                                                                                                                    %>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <% } %>
                                                                                        </div>
                                                                                    </div>

                                                                                    <!-- Room Type Distribution (Donut) -->
                                                                                    <div class="report-panel">
                                                                                        <div class="panel-header">
                                                                                            <h2 class="panel-title">🛏️
                                                                                                Room Type Distribution
                                                                                            </h2>
                                                                                        </div>
                                                                                        <div class="panel-body">
                                                                                            <% if (roomTypeTotal==0) {
                                                                                                %>
                                                                                                <div
                                                                                                    class="empty-panel">
                                                                                                    No reservation data
                                                                                                </div>
                                                                                                <% } else { double
                                                                                                    circumference=2 *
                                                                                                    Math.PI * 56; double
                                                                                                    stdDash=(standardPct
                                                                                                    / 100) *
                                                                                                    circumference;
                                                                                                    double
                                                                                                    dlxDash=(deluxePct /
                                                                                                    100) *
                                                                                                    circumference;
                                                                                                    double
                                                                                                    steDash=(suitePct /
                                                                                                    100) *
                                                                                                    circumference;
                                                                                                    double stdOffset=0;
                                                                                                    double
                                                                                                    dlxOffset=stdDash;
                                                                                                    double
                                                                                                    steOffset=stdDash +
                                                                                                    dlxDash; %>
                                                                                                    <div
                                                                                                        class="donut-container">
                                                                                                        <div
                                                                                                            class="donut-ring">
                                                                                                            <svg
                                                                                                                viewBox="0 0 140 140">
                                                                                                                <circle
                                                                                                                    class="donut-bg"
                                                                                                                    cx="70"
                                                                                                                    cy="70"
                                                                                                                    r="56" />
                                                                                                                <circle
                                                                                                                    class="donut-segment"
                                                                                                                    cx="70"
                                                                                                                    cy="70"
                                                                                                                    r="56"
                                                                                                                    stroke="#c9a55c"
                                                                                                                    stroke-dasharray="<%= stdDash %> <%= circumference - stdDash %>"
                                                                                                                    stroke-dashoffset="0" />
                                                                                                                <circle
                                                                                                                    class="donut-segment"
                                                                                                                    cx="70"
                                                                                                                    cy="70"
                                                                                                                    r="56"
                                                                                                                    stroke="#4dabf7"
                                                                                                                    stroke-dasharray="<%= dlxDash %> <%= circumference - dlxDash %>"
                                                                                                                    stroke-dashoffset="-<%= dlxOffset %>" />
                                                                                                                <circle
                                                                                                                    class="donut-segment"
                                                                                                                    cx="70"
                                                                                                                    cy="70"
                                                                                                                    r="56"
                                                                                                                    stroke="#cc5de8"
                                                                                                                    stroke-dasharray="<%= steDash %> <%= circumference - steDash %>"
                                                                                                                    stroke-dashoffset="-<%= steOffset %>" />
                                                                                                            </svg>
                                                                                                            <div
                                                                                                                class="donut-center">
                                                                                                                <div
                                                                                                                    class="donut-center-value">
                                                                                                                    <%= roomTypeTotal
                                                                                                                        %>
                                                                                                                </div>
                                                                                                                <div
                                                                                                                    class="donut-center-label">
                                                                                                                    Bookings
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div
                                                                                                            class="donut-legend">
                                                                                                            <div
                                                                                                                class="legend-item">
                                                                                                                <div
                                                                                                                    class="legend-dot gold">
                                                                                                                </div>
                                                                                                                Standard
                                                                                                                (<%= String.format("%.0f",
                                                                                                                    standardPct)
                                                                                                                    %>%)
                                                                                                                    <span
                                                                                                                        class="legend-value">
                                                                                                                        <%= standardRoomCount
                                                                                                                            %>
                                                                                                                    </span>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="legend-item">
                                                                                                                <div
                                                                                                                    class="legend-dot blue">
                                                                                                                </div>
                                                                                                                Deluxe (
                                                                                                                <%= String.format("%.0f",
                                                                                                                    deluxePct)
                                                                                                                    %>%)
                                                                                                                    <span
                                                                                                                        class="legend-value">
                                                                                                                        <%= deluxeRoomCount
                                                                                                                            %>
                                                                                                                    </span>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="legend-item">
                                                                                                                <div
                                                                                                                    class="legend-dot purple">
                                                                                                                </div>
                                                                                                                Suite (
                                                                                                                <%= String.format("%.0f",
                                                                                                                    suitePct)
                                                                                                                    %>%)
                                                                                                                    <span
                                                                                                                        class="legend-value">
                                                                                                                        <%= suiteRoomCount
                                                                                                                            %>
                                                                                                                    </span>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <% } %>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- ===== ROW 2: Room Occupancy Gauge + Revenue Overview ===== -->
                                                                                <div class="report-grid">
                                                                                    <!-- Room Occupancy -->
                                                                                    <div class="report-panel">
                                                                                        <div class="panel-header">
                                                                                            <h2 class="panel-title">🏨
                                                                                                Room Occupancy</h2>
                                                                                        </div>
                                                                                        <div class="panel-body">
                                                                                            <% if (totalRooms==0) { %>
                                                                                                <div
                                                                                                    class="empty-panel">
                                                                                                    No rooms configured
                                                                                                </div>
                                                                                                <% } else { double
                                                                                                    gaugePct=occupancyRate;
                                                                                                    double gaugeCirc=2 *
                                                                                                    Math.PI * 66; double
                                                                                                    gaugeFill=(gaugePct
                                                                                                    / 100) * gaugeCirc;
                                                                                                    String
                                                                                                    gaugeColor=gaugePct>
                                                                                                    80 ? "#ff6b6b" :
                                                                                                    gaugePct > 50 ?
                                                                                                    "#ffd93d" :
                                                                                                    "#51cf66";
                                                                                                    %>
                                                                                                    <div
                                                                                                        class="donut-container">
                                                                                                        <div
                                                                                                            class="gauge-container">
                                                                                                            <div
                                                                                                                class="gauge-ring">
                                                                                                                <svg
                                                                                                                    viewBox="0 0 160 160">
                                                                                                                    <circle
                                                                                                                        class="gauge-bg"
                                                                                                                        cx="80"
                                                                                                                        cy="80"
                                                                                                                        r="66" />
                                                                                                                    <circle
                                                                                                                        class="gauge-fill"
                                                                                                                        cx="80"
                                                                                                                        cy="80"
                                                                                                                        r="66"
                                                                                                                        stroke="<%= gaugeColor %>"
                                                                                                                        stroke-dasharray="<%= gaugeFill %> <%= gaugeCirc - gaugeFill %>"
                                                                                                                        stroke-dashoffset="0"
                                                                                                                        stroke-linecap="round" />
                                                                                                                </svg>
                                                                                                                <div
                                                                                                                    class="gauge-center">
                                                                                                                    <div class="gauge-pct"
                                                                                                                        style="color: <%= gaugeColor %>;">
                                                                                                                        <%= String.format("%.0f",
                                                                                                                            gaugePct)
                                                                                                                            %>
                                                                                                                            %
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="gauge-label">
                                                                                                                        Occupied
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div
                                                                                                            class="donut-legend">
                                                                                                            <div
                                                                                                                class="legend-item">
                                                                                                                <div
                                                                                                                    class="legend-dot green">
                                                                                                                </div>
                                                                                                                Available
                                                                                                                <span
                                                                                                                    class="legend-value">
                                                                                                                    <%= availableRooms
                                                                                                                        %>
                                                                                                                </span>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="legend-item">
                                                                                                                <div
                                                                                                                    class="legend-dot red">
                                                                                                                </div>
                                                                                                                Occupied
                                                                                                                <span
                                                                                                                    class="legend-value">
                                                                                                                    <%= occupiedRooms
                                                                                                                        %>
                                                                                                                </span>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                class="legend-item">
                                                                                                                <div
                                                                                                                    class="legend-dot amber">
                                                                                                                </div>
                                                                                                                Maintenance
                                                                                                                <span
                                                                                                                    class="legend-value">
                                                                                                                    <%= maintenanceRooms
                                                                                                                        %>
                                                                                                                </span>
                                                                                                            </div>
                                                                                                            <div class="legend-item"
                                                                                                                style="margin-top: 8px; padding-top: 8px; border-top: 1px solid rgba(255,255,255,0.05);">
                                                                                                                <div
                                                                                                                    class="legend-dot gray">
                                                                                                                </div>
                                                                                                                Total
                                                                                                                Rooms
                                                                                                                <span
                                                                                                                    class="legend-value">
                                                                                                                    <%= totalRooms
                                                                                                                        %>
                                                                                                                </span>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                    <% } %>
                                                                                        </div>
                                                                                    </div>

                                                                                    <!-- Revenue by Room Type -->
                                                                                    <div class="report-panel">
                                                                                        <div class="panel-header">
                                                                                            <h2 class="panel-title">💵
                                                                                                Revenue Breakdown</h2>
                                                                                        </div>
                                                                                        <div class="panel-body">
                                                                                            <% // Compute revenue by room type from reservations + bills
                                                                                                double stdRevenue=0,
                                                                                                dlxRevenue=0,
                                                                                                steRevenue=0;
                                                                                                java.util.Map<String,
                                                                                                Double> billMap = new
                                                                                                java.util.HashMap<>();
                                                                                                    for (Bill b : bills)
                                                                                                    {
                                                                                                    billMap.put(b.getReservationNo(),
                                                                                                    b.getAmount());
                                                                                                    }
                                                                                                    for (Reservation r :
                                                                                                    reservations) {
                                                                                                    Double amt =
                                                                                                    billMap.get(r.getReservationNo());
                                                                                                    if (amt != null) {
                                                                                                    int rt =
                                                                                                    r.getRoomTypeId();
                                                                                                    if (rt == 1)
                                                                                                    stdRevenue += amt;
                                                                                                    else if (rt == 2)
                                                                                                    dlxRevenue += amt;
                                                                                                    else if (rt == 3)
                                                                                                    steRevenue += amt;
                                                                                                    }
                                                                                                    }
                                                                                                    double maxRevenue =
                                                                                                    Math.max(stdRevenue,
                                                                                                    Math.max(dlxRevenue,
                                                                                                    steRevenue));
                                                                                                    if (maxRevenue == 0)
                                                                                                    maxRevenue = 1;
                                                                                                    %>
                                                                                                    <% if
                                                                                                        (bills.isEmpty())
                                                                                                        { %>
                                                                                                        <div
                                                                                                            class="empty-panel">
                                                                                                            No billing
                                                                                                            data yet
                                                                                                        </div>
                                                                                                        <% } else { %>
                                                                                                            <div
                                                                                                                class="bar-chart">
                                                                                                                <div
                                                                                                                    class="bar-row">
                                                                                                                    <div
                                                                                                                        class="bar-label">
                                                                                                                        Standard
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="bar-track">
                                                                                                                        <div class="bar-fill gold"
                                                                                                                            style="width: <%= (stdRevenue / maxRevenue) * 100 %>%;">
                                                                                                                            $
                                                                                                                            <%= String.format("%,.0f",
                                                                                                                                stdRevenue)
                                                                                                                                %>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="bar-count">
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <div
                                                                                                                    class="bar-row">
                                                                                                                    <div
                                                                                                                        class="bar-label">
                                                                                                                        Deluxe
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="bar-track">
                                                                                                                        <div class="bar-fill blue"
                                                                                                                            style="width: <%= (dlxRevenue / maxRevenue) * 100 %>%;">
                                                                                                                            $
                                                                                                                            <%= String.format("%,.0f",
                                                                                                                                dlxRevenue)
                                                                                                                                %>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="bar-count">
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                                <div
                                                                                                                    class="bar-row">
                                                                                                                    <div
                                                                                                                        class="bar-label">
                                                                                                                        Suite
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="bar-track">
                                                                                                                        <div class="bar-fill purple"
                                                                                                                            style="width: <%= (steRevenue / maxRevenue) * 100 %>%;">
                                                                                                                            $
                                                                                                                            <%= String.format("%,.0f",
                                                                                                                                steRevenue)
                                                                                                                                %>
                                                                                                                        </div>
                                                                                                                    </div>
                                                                                                                    <div
                                                                                                                        class="bar-count">
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                            <div
                                                                                                                style="margin-top: 20px; padding-top: 16px; border-top: 1px solid rgba(255,255,255,0.05); text-align: right;">
                                                                                                                <span
                                                                                                                    style="font-size: 11px; color: rgba(255,255,255,0.4); letter-spacing: 1px; text-transform: uppercase;">Total
                                                                                                                    Revenue</span>
                                                                                                                <span
                                                                                                                    style="font-size: 20px; font-weight: 700; color: #c9a55c; margin-left: 12px;">$
                                                                                                                    <%= String.format("%,.2f",
                                                                                                                        totalRevenue)
                                                                                                                        %>
                                                                                                                        </span>
                                                                                                            </div>
                                                                                                            <% } %>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <!-- ===== RECENT BILLS TABLE ===== -->
                                                                                <div class="report-panel full-width"
                                                                                    style="margin-bottom: 35px;">
                                                                                    <div class="panel-header">
                                                                                        <h2 class="panel-title">🧾
                                                                                            Recent Bills</h2>
                                                                                        <span class="panel-badge"
                                                                                            style="background: rgba(201,165,92,0.15); color: #c9a55c;">
                                                                                            <%= bills.size() %> Total
                                                                                        </span>
                                                                                    </div>
                                                                                    <% if (bills.isEmpty()) { %>
                                                                                        <div class="empty-panel"
                                                                                            style="padding: 50px;">
                                                                                            <div
                                                                                                style="font-size: 40px; margin-bottom: 12px; opacity: 0.3;">
                                                                                                🧾</div>
                                                                                            No bills have been generated
                                                                                            yet.
                                                                                        </div>
                                                                                        <% } else { %>
                                                                                            <table class="report-table">
                                                                                                <thead>
                                                                                                    <tr>
                                                                                                        <th>Bill ID</th>
                                                                                                        <th>Reservation
                                                                                                            No</th>
                                                                                                        <th>Amount</th>
                                                                                                        <th>Issue Date
                                                                                                        </th>
                                                                                                        <th>Status</th>
                                                                                                    </tr>
                                                                                                </thead>
                                                                                                <tbody>
                                                                                                    <% // Show most-recent first (reverse order)
                                                                                                         int
                                                                                                        billLimit=Math.min(bills.size(),
                                                                                                        10); for (int
                                                                                                        i=bills.size() -
                                                                                                        1; i>=
                                                                                                        bills.size() -
                                                                                                        billLimit; i--)
                                                                                                        {
                                                                                                        Bill b =
                                                                                                        bills.get(i);
                                                                                                        String bStatus =
                                                                                                        b.getStatus() !=
                                                                                                        null ?
                                                                                                        b.getStatus() :
                                                                                                        "PENDING";
                                                                                                        String
                                                                                                        bStatusClass =
                                                                                                        "pending";
                                                                                                        if
                                                                                                        ("PAID".equalsIgnoreCase(bStatus))
                                                                                                        bStatusClass =
                                                                                                        "paid";
                                                                                                        else if
                                                                                                        ("CONFIRMED".equalsIgnoreCase(bStatus))
                                                                                                        bStatusClass =
                                                                                                        "confirmed";
                                                                                                        else if
                                                                                                        ("CANCELLED".equalsIgnoreCase(bStatus))
                                                                                                        bStatusClass =
                                                                                                        "cancelled";
                                                                                                        %>
                                                                                                        <tr>
                                                                                                            <td>#<%= b.getBillId()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= b.getReservationNo()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td
                                                                                                                class="amount-cell">
                                                                                                                $<%= String.format("%,.2f",
                                                                                                                    b.getAmount())
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= b.getIssueDate()
                                                                                                                    !=null
                                                                                                                    ?
                                                                                                                    b.getIssueDate().format(dtfFull)
                                                                                                                    : "—"
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td><span
                                                                                                                    class="status-pill <%= bStatusClass %>">
                                                                                                                    <%= bStatus
                                                                                                                        %>
                                                                                                                </span>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <% } %>
                                                                                                </tbody>
                                                                                            </table>
                                                                                            <% } %>
                                                                                </div>

                                                                                <!-- ===== RECENT RESERVATIONS TABLE ===== -->
                                                                                <div class="report-panel full-width">
                                                                                    <div class="panel-header">
                                                                                        <h2 class="panel-title">📅
                                                                                            Recent Reservations</h2>
                                                                                        <span class="panel-badge"
                                                                                            style="background: rgba(81,207,102,0.15); color: #51cf66;">
                                                                                            <%= reservations.size() %>
                                                                                                Total
                                                                                        </span>
                                                                                    </div>
                                                                                    <% if (reservations.isEmpty()) { %>
                                                                                        <div class="empty-panel"
                                                                                            style="padding: 50px;">
                                                                                            <div
                                                                                                style="font-size: 40px; margin-bottom: 12px; opacity: 0.3;">
                                                                                                📅</div>
                                                                                            No reservations found.
                                                                                        </div>
                                                                                        <% } else { %>
                                                                                            <table class="report-table">
                                                                                                <thead>
                                                                                                    <tr>
                                                                                                        <th>Reservation
                                                                                                            No</th>
                                                                                                        <th>Guest</th>
                                                                                                        <th>Room Type
                                                                                                        </th>
                                                                                                        <th>Check-In
                                                                                                        </th>
                                                                                                        <th>Check-Out
                                                                                                        </th>
                                                                                                        <th>Guests</th>
                                                                                                        <th>Status</th>
                                                                                                    </tr>
                                                                                                </thead>
                                                                                                <tbody>
                                                                                                    <% int
                                                                                                        resLimit=Math.min(reservations.size(),
                                                                                                        10); for (int
                                                                                                        i=reservations.size()
                                                                                                        - 1; i>=
                                                                                                        reservations.size()
                                                                                                        - resLimit; i--)
                                                                                                        {
                                                                                                        Reservation r =
                                                                                                        reservations.get(i);
                                                                                                        String rStatus =
                                                                                                        r.getStatus() !=
                                                                                                        null ?
                                                                                                        r.getStatus() :
                                                                                                        "PENDING";
                                                                                                        String
                                                                                                        rStatusClass =
                                                                                                        "pending";
                                                                                                        if
                                                                                                        ("CONFIRMED".equalsIgnoreCase(rStatus))
                                                                                                        rStatusClass =
                                                                                                        "confirmed";
                                                                                                        else if
                                                                                                        ("CANCELLED".equalsIgnoreCase(rStatus))
                                                                                                        rStatusClass =
                                                                                                        "cancelled";

                                                                                                        String
                                                                                                        roomTypeName;
                                                                                                        switch
                                                                                                        (r.getRoomTypeId())
                                                                                                        {
                                                                                                        case 1:
                                                                                                        roomTypeName =
                                                                                                        "Standard";
                                                                                                        break;
                                                                                                        case 2:
                                                                                                        roomTypeName =
                                                                                                        "Deluxe"; break;
                                                                                                        case 3:
                                                                                                        roomTypeName =
                                                                                                        "Suite"; break;
                                                                                                        default:
                                                                                                        roomTypeName =
                                                                                                        "Other"; break;
                                                                                                        }
                                                                                                        %>
                                                                                                        <tr>
                                                                                                            <td
                                                                                                                style="font-weight: 600;">
                                                                                                                <%= r.getReservationNo()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= r.getGuestName()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= roomTypeName
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= r.getCheckInDate()
                                                                                                                    !=null
                                                                                                                    ?
                                                                                                                    r.getCheckInDate().format(dtf)
                                                                                                                    : "—"
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= r.getCheckOutDate()
                                                                                                                    !=null
                                                                                                                    ?
                                                                                                                    r.getCheckOutDate().format(dtf)
                                                                                                                    : "—"
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td>
                                                                                                                <%= r.getNumGuests()
                                                                                                                    %>
                                                                                                            </td>
                                                                                                            <td><span
                                                                                                                    class="status-pill <%= rStatusClass %>">
                                                                                                                    <%= rStatus
                                                                                                                        %>
                                                                                                                </span>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                        <% } %>
                                                                                                </tbody>
                                                                                            </table>
                                                                                            <% } %>
                                                                                </div>

                                                                    </div><!-- .page-content -->
                                                                </main>

                                                                <script>
                                                                    // Mobile sidebar toggle
                                                                    const menuToggle = document.querySelector('.menu-toggle');
                                                                    const sidebar = document.getElementById('sidebar');
                                                                    if (menuToggle && sidebar) {
                                                                        menuToggle.addEventListener('click', () => {
                                                                            sidebar.classList.toggle('mobile-open');
                                                                        });
                                                                    }
                                                                </script>
                                                            </body>

                                                            </html>