<%-- Guests Management Page - Ocean View Resort Staff Dashboard --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="java.util.*, com.buddhi.oceanviewresort.model.entity.User" %>
            <% // Check if user is logged in as staff
                String username=(String) session.getAttribute("username"); String
                role=(String) session.getAttribute("role"); if (username==null) { response.sendRedirect("login.jsp");
                return; } // Get guests list from request attribute (set by UserServlet)
                 List<User> guests = (List<User>
                    ) request.getAttribute("users");
                    if (guests == null) {
                    guests = new ArrayList<>();
                        }

                        // Get flash messages
                        String message = (String) session.getAttribute("message");
                        String messageType = (String) session.getAttribute("messageType");
                        // Clear flash messages after reading
                        session.removeAttribute("message");
                        session.removeAttribute("messageType");
                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Guest Management - Ocean View Resort</title>
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

                                /* Page Content */
                                .page-content {
                                    padding: 40px;
                                }

                                /* Stats Row */
                                .guest-stats {
                                    display: grid;
                                    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                                    gap: 20px;
                                    margin-bottom: 30px;
                                }

                                .guest-stat-card {
                                    background: rgba(13, 13, 13, 0.95);
                                    border: 1px solid rgba(255, 255, 255, 0.05);
                                    border-radius: 12px;
                                    padding: 24px;
                                    position: relative;
                                    overflow: hidden;
                                    transition: all 0.3s;
                                }

                                .guest-stat-card::before {
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

                                .guest-stat-card:hover {
                                    border-color: rgba(201, 165, 92, 0.3);
                                    transform: translateY(-3px);
                                }

                                .guest-stat-card:hover::before {
                                    opacity: 1;
                                }

                                .guest-stat-label {
                                    font-size: 10px;
                                    letter-spacing: 2px;
                                    text-transform: uppercase;
                                    color: rgba(255, 255, 255, 0.5);
                                    margin-bottom: 8px;
                                }

                                .guest-stat-value {
                                    font-size: 28px;
                                    font-weight: 600;
                                    color: #c9a55c;
                                }

                                .guest-stat-icon {
                                    position: absolute;
                                    top: 20px;
                                    right: 20px;
                                    font-size: 28px;
                                    opacity: 0.3;
                                }

                                /* Table Container */
                                .table-container {
                                    background: rgba(13, 13, 13, 0.95);
                                    border: 1px solid rgba(255, 255, 255, 0.05);
                                    border-radius: 12px;
                                    overflow: hidden;
                                }

                                .table-header {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    padding: 25px 30px;
                                    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                                }

                                .table-title {
                                    font-size: 18px;
                                    font-weight: 400;
                                    letter-spacing: 1px;
                                }

                                .table-actions {
                                    display: flex;
                                    gap: 12px;
                                    align-items: center;
                                }

                                .search-input {
                                    background: rgba(255, 255, 255, 0.05);
                                    border: 1px solid rgba(255, 255, 255, 0.1);
                                    border-radius: 20px;
                                    padding: 10px 20px 10px 40px;
                                    color: #fff;
                                    font-size: 12px;
                                    width: 260px;
                                    transition: all 0.3s;
                                    font-family: inherit;
                                    position: relative;
                                }

                                .search-input:focus {
                                    outline: none;
                                    border-color: #c9a55c;
                                    width: 300px;
                                }

                                .search-input::placeholder {
                                    color: rgba(255, 255, 255, 0.3);
                                }

                                .search-wrapper {
                                    position: relative;
                                }

                                .search-wrapper .search-icon {
                                    position: absolute;
                                    left: 15px;
                                    top: 50%;
                                    transform: translateY(-50%);
                                    color: rgba(255, 255, 255, 0.4);
                                    font-size: 14px;
                                    pointer-events: none;
                                }

                                .guest-count-badge {
                                    background: rgba(201, 165, 92, 0.15);
                                    color: #c9a55c;
                                    padding: 6px 14px;
                                    border-radius: 20px;
                                    font-size: 11px;
                                    letter-spacing: 1px;
                                    font-weight: 600;
                                }

                                /* Table */
                                .guests-table {
                                    width: 100%;
                                    border-collapse: collapse;
                                }

                                .guests-table thead th {
                                    text-align: left;
                                    padding: 16px 30px;
                                    font-size: 10px;
                                    letter-spacing: 2px;
                                    text-transform: uppercase;
                                    color: rgba(255, 255, 255, 0.4);
                                    background: rgba(255, 255, 255, 0.02);
                                    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                                    font-weight: 600;
                                }

                                .guests-table tbody tr {
                                    border-bottom: 1px solid rgba(255, 255, 255, 0.03);
                                    transition: all 0.3s;
                                }

                                .guests-table tbody tr:hover {
                                    background: rgba(201, 165, 92, 0.05);
                                }

                                .guests-table tbody tr:last-child {
                                    border-bottom: none;
                                }

                                .guests-table tbody td {
                                    padding: 18px 30px;
                                    font-size: 13px;
                                    color: rgba(255, 255, 255, 0.85);
                                }

                                .guest-name-cell {
                                    display: flex;
                                    align-items: center;
                                    gap: 12px;
                                }

                                .guest-avatar {
                                    width: 38px;
                                    height: 38px;
                                    border-radius: 50%;
                                    background: linear-gradient(135deg, #c9a55c, #f4e5c3);
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-weight: 700;
                                    color: #1a1a1a;
                                    font-size: 14px;
                                    flex-shrink: 0;
                                }

                                .guest-name-info .name {
                                    font-weight: 500;
                                    color: #fff;
                                    margin-bottom: 2px;
                                }

                                .guest-name-info .id {
                                    font-size: 10px;
                                    color: rgba(255, 255, 255, 0.4);
                                    letter-spacing: 1px;
                                }

                                .email-cell {
                                    color: rgba(255, 255, 255, 0.6) !important;
                                }

                                .phone-cell {
                                    color: rgba(255, 255, 255, 0.6) !important;
                                }

                                .status-badge {
                                    display: inline-block;
                                    padding: 5px 12px;
                                    border-radius: 20px;
                                    font-size: 10px;
                                    letter-spacing: 1px;
                                    text-transform: uppercase;
                                    font-weight: 600;
                                    background: rgba(81, 207, 102, 0.1);
                                    color: #51cf66;
                                }

                                /* Action Buttons */
                                .action-btns {
                                    display: flex;
                                    gap: 8px;
                                }

                                .btn-action {
                                    width: 34px;
                                    height: 34px;
                                    border: 1px solid rgba(255, 255, 255, 0.1);
                                    border-radius: 8px;
                                    background: rgba(255, 255, 255, 0.05);
                                    color: rgba(255, 255, 255, 0.7);
                                    cursor: pointer;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-size: 14px;
                                    transition: all 0.3s;
                                }

                                .btn-action.edit:hover {
                                    background: rgba(201, 165, 92, 0.15);
                                    border-color: #c9a55c;
                                    color: #c9a55c;
                                }

                                .btn-action.delete:hover {
                                    background: rgba(220, 53, 69, 0.15);
                                    border-color: #ff6b6b;
                                    color: #ff6b6b;
                                }

                                /* Empty State */
                                .empty-state {
                                    text-align: center;
                                    padding: 60px 30px;
                                }

                                .empty-state-icon {
                                    font-size: 60px;
                                    margin-bottom: 20px;
                                    opacity: 0.3;
                                }

                                .empty-state-title {
                                    font-size: 18px;
                                    font-weight: 400;
                                    margin-bottom: 8px;
                                    color: rgba(255, 255, 255, 0.6);
                                }

                                .empty-state-text {
                                    font-size: 13px;
                                    color: rgba(255, 255, 255, 0.4);
                                }

                                /* Modal Overlay */
                                .modal-overlay {
                                    display: none;
                                    position: fixed;
                                    top: 0;
                                    left: 0;
                                    right: 0;
                                    bottom: 0;
                                    background: rgba(0, 0, 0, 0.7);
                                    backdrop-filter: blur(5px);
                                    z-index: 2000;
                                    align-items: center;
                                    justify-content: center;
                                    animation: fadeIn 0.3s ease;
                                }

                                .modal-overlay.show {
                                    display: flex;
                                }

                                @keyframes fadeIn {
                                    from {
                                        opacity: 0;
                                    }

                                    to {
                                        opacity: 1;
                                    }
                                }

                                .modal {
                                    background: #1a1a1a;
                                    border: 1px solid rgba(255, 255, 255, 0.1);
                                    border-radius: 16px;
                                    width: 90%;
                                    max-width: 500px;
                                    box-shadow: 0 25px 60px rgba(0, 0, 0, 0.5);
                                    animation: slideUp 0.3s ease;
                                    overflow: hidden;
                                }

                                @keyframes slideUp {
                                    from {
                                        opacity: 0;
                                        transform: translateY(30px);
                                    }

                                    to {
                                        opacity: 1;
                                        transform: translateY(0);
                                    }
                                }

                                .modal-header {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    padding: 25px 30px;
                                    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                                }

                                .modal-title {
                                    font-size: 18px;
                                    font-weight: 400;
                                    letter-spacing: 1px;
                                }

                                .modal-close {
                                    width: 34px;
                                    height: 34px;
                                    border: 1px solid rgba(255, 255, 255, 0.1);
                                    border-radius: 8px;
                                    background: rgba(255, 255, 255, 0.05);
                                    color: rgba(255, 255, 255, 0.7);
                                    cursor: pointer;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    font-size: 16px;
                                    transition: all 0.3s;
                                }

                                .modal-close:hover {
                                    background: rgba(220, 53, 69, 0.15);
                                    border-color: #ff6b6b;
                                    color: #ff6b6b;
                                }

                                .modal-body {
                                    padding: 30px;
                                }

                                .modal-form-group {
                                    margin-bottom: 20px;
                                }

                                .modal-form-group label {
                                    display: block;
                                    font-size: 10px;
                                    letter-spacing: 2px;
                                    text-transform: uppercase;
                                    color: rgba(255, 255, 255, 0.5);
                                    margin-bottom: 10px;
                                    font-weight: 600;
                                }

                                .modal-form-group input {
                                    width: 100%;
                                    background: rgba(255, 255, 255, 0.05);
                                    border: 1px solid rgba(255, 255, 255, 0.1);
                                    border-radius: 8px;
                                    padding: 14px 18px;
                                    color: #fff;
                                    font-size: 13px;
                                    font-family: inherit;
                                    transition: all 0.3s;
                                }

                                .modal-form-group input:focus {
                                    outline: none;
                                    border-color: #c9a55c;
                                    background: rgba(255, 255, 255, 0.08);
                                    box-shadow: 0 0 0 3px rgba(201, 165, 92, 0.1);
                                }

                                .modal-form-group input::placeholder {
                                    color: rgba(255, 255, 255, 0.3);
                                }

                                .modal-footer {
                                    display: flex;
                                    justify-content: flex-end;
                                    gap: 12px;
                                    padding: 20px 30px;
                                    border-top: 1px solid rgba(255, 255, 255, 0.05);
                                }

                                .btn-modal {
                                    padding: 12px 24px;
                                    border-radius: 8px;
                                    font-size: 11px;
                                    letter-spacing: 1px;
                                    text-transform: uppercase;
                                    font-weight: 600;
                                    cursor: pointer;
                                    transition: all 0.3s;
                                    font-family: inherit;
                                    border: none;
                                }

                                .btn-cancel {
                                    background: rgba(255, 255, 255, 0.05);
                                    border: 1px solid rgba(255, 255, 255, 0.1) !important;
                                    color: rgba(255, 255, 255, 0.7);
                                }

                                .btn-cancel:hover {
                                    background: rgba(255, 255, 255, 0.1);
                                    color: #fff;
                                }

                                .btn-save {
                                    background: #c9a55c;
                                    color: #1a1a1a;
                                }

                                .btn-save:hover {
                                    background: #d4b06a;
                                    transform: translateY(-1px);
                                    box-shadow: 0 5px 15px rgba(201, 165, 92, 0.3);
                                }

                                .btn-delete-confirm {
                                    background: #dc3545;
                                    color: #fff;
                                }

                                .btn-delete-confirm:hover {
                                    background: #c82333;
                                    transform: translateY(-1px);
                                    box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
                                }

                                /* Delete Confirmation */
                                .delete-confirm-text {
                                    font-size: 14px;
                                    color: rgba(255, 255, 255, 0.7);
                                    line-height: 1.6;
                                    margin-bottom: 10px;
                                }

                                .delete-confirm-name {
                                    color: #ff6b6b;
                                    font-weight: 600;
                                }

                                .delete-warning {
                                    display: flex;
                                    align-items: center;
                                    gap: 10px;
                                    background: rgba(220, 53, 69, 0.1);
                                    border: 1px solid rgba(220, 53, 69, 0.2);
                                    border-radius: 8px;
                                    padding: 12px 16px;
                                    font-size: 11px;
                                    color: #ff6b6b;
                                }

                                /* Toast Notification */
                                .toast {
                                    position: fixed;
                                    top: 30px;
                                    right: 30px;
                                    z-index: 3000;
                                    padding: 16px 24px;
                                    border-radius: 10px;
                                    font-size: 13px;
                                    font-weight: 500;
                                    display: flex;
                                    align-items: center;
                                    gap: 10px;
                                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                                    transform: translateX(120%);
                                    transition: transform 0.4s cubic-bezier(0.68, -0.55, 0.27, 1.55);
                                    max-width: 400px;
                                }

                                .toast.show {
                                    transform: translateX(0);
                                }

                                .toast.success {
                                    background: rgba(40, 167, 69, 0.95);
                                    border: 1px solid rgba(81, 207, 102, 0.3);
                                    color: #fff;
                                }

                                .toast.error {
                                    background: rgba(220, 53, 69, 0.95);
                                    border: 1px solid rgba(255, 107, 107, 0.3);
                                    color: #fff;
                                }

                                /* Table Pagination */
                                .table-footer {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    padding: 16px 30px;
                                    border-top: 1px solid rgba(255, 255, 255, 0.05);
                                }

                                .table-info {
                                    font-size: 12px;
                                    color: rgba(255, 255, 255, 0.4);
                                }

                                /* No Results */
                                .no-results {
                                    display: none;
                                    text-align: center;
                                    padding: 40px;
                                    color: rgba(255, 255, 255, 0.4);
                                    font-size: 13px;
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

                                    .table-header {
                                        flex-direction: column;
                                        gap: 15px;
                                        align-items: flex-start;
                                    }

                                    .guests-table {
                                        display: block;
                                        overflow-x: auto;
                                    }
                                }

                                /* Fade in animation for rows */
                                @keyframes fadeInRow {
                                    from {
                                        opacity: 0;
                                        transform: translateY(10px);
                                    }

                                    to {
                                        opacity: 1;
                                        transform: translateY(0);
                                    }
                                }

                                .guests-table tbody tr {
                                    animation: fadeInRow 0.4s ease forwards;
                                }

                                .guests-table tbody tr:nth-child(1) {
                                    animation-delay: 0.05s;
                                }

                                .guests-table tbody tr:nth-child(2) {
                                    animation-delay: 0.1s;
                                }

                                .guests-table tbody tr:nth-child(3) {
                                    animation-delay: 0.15s;
                                }

                                .guests-table tbody tr:nth-child(4) {
                                    animation-delay: 0.2s;
                                }

                                .guests-table tbody tr:nth-child(5) {
                                    animation-delay: 0.25s;
                                }

                                .guests-table tbody tr:nth-child(6) {
                                    animation-delay: 0.3s;
                                }

                                .guests-table tbody tr:nth-child(7) {
                                    animation-delay: 0.35s;
                                }

                                .guests-table tbody tr:nth-child(8) {
                                    animation-delay: 0.4s;
                                }

                                .guests-table tbody tr:nth-child(9) {
                                    animation-delay: 0.45s;
                                }

                                .guests-table tbody tr:nth-child(10) {
                                    animation-delay: 0.5s;
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
                                            class="menu-item">
                                            <span class="menu-icon">📅</span>
                                            <span>Reservations</span>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/Reservation/CreateReservation.jsp"
                                            class="menu-item">
                                            <span class="menu-icon">➕</span>
                                            <span>New Reservation</span>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/user-servlet?action=list"
                                            class="menu-item active">
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
                                        <a href="${pageContext.request.contextPath}/report-servlet" class="menu-item">
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
                                                <a href="${pageContext.request.contextPath}/help-servlet"
                                                    class="menu-item">
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
                                    <h1 class="page-title">Guest Management</h1>
                                    <div class="top-actions">
                                        <span class="guest-count-badge">
                                            <%= guests.size() %> Total Guests
                                        </span>
                                    </div>
                                </div>

                                <!-- Page Content -->
                                <div class="page-content">
                                    <!-- Stats Row -->
                                    <div class="guest-stats">
                                        <div class="guest-stat-card">
                                            <div class="guest-stat-label">Total Registered</div>
                                            <div class="guest-stat-value">
                                                <%= guests.size() %>
                                            </div>
                                            <div class="guest-stat-icon">👥</div>
                                        </div>
                                        <div class="guest-stat-card">
                                            <div class="guest-stat-label">With Email</div>
                                            <div class="guest-stat-value">
                                                <% int withEmail=0; for (User g : guests) { if (g.getEmail() !=null &&
                                                    !g.getEmail().isEmpty()) withEmail++; } %>
                                                    <%= withEmail %>
                                            </div>
                                            <div class="guest-stat-icon">📧</div>
                                        </div>
                                        <div class="guest-stat-card">
                                            <div class="guest-stat-label">With Phone</div>
                                            <div class="guest-stat-value">
                                                <% int withPhone=0; for (User g : guests) { if (g.getPhoneNo() !=null &&
                                                    !g.getPhoneNo().isEmpty()) withPhone++; } %>
                                                    <%= withPhone %>
                                            </div>
                                            <div class="guest-stat-icon">📱</div>
                                        </div>
                                    </div>

                                    <!-- Guest Table -->
                                    <div class="table-container">
                                        <div class="table-header">
                                            <h2 class="table-title">All Registered Guests</h2>
                                            <div class="table-actions">
                                                <div class="search-wrapper">
                                                    <span class="search-icon">🔍</span>
                                                    <input type="text" class="search-input" id="guestSearch"
                                                        placeholder="Search by name, email, or phone...">
                                                </div>
                                            </div>
                                        </div>

                                        <% if (guests.isEmpty()) { %>
                                            <div class="empty-state">
                                                <div class="empty-state-icon">👥</div>
                                                <div class="empty-state-title">No Guests Found</div>
                                                <div class="empty-state-text">
                                                    There are no registered guests yet. Guests will appear here after
                                                    they sign up.
                                                </div>
                                            </div>
                                            <% } else { %>
                                                <table class="guests-table" id="guestsTable">
                                                    <thead>
                                                        <tr>
                                                            <th>Guest</th>
                                                            <th>Email</th>
                                                            <th>Phone</th>
                                                            <th>Status</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="guestsTableBody">
                                                        <% for (User guest : guests) { %>
                                                            <tr data-id="<%= guest.getUserID() %>"
                                                                data-name="<%= guest.getUserName() %>"
                                                                data-email="<%= guest.getEmail() %>"
                                                                data-phone="<%= guest.getPhoneNo() %>">
                                                                <td>
                                                                    <div class="guest-name-cell">
                                                                        <div class="guest-avatar">
                                                                            <%= guest.getUserName() !=null &&
                                                                                !guest.getUserName().isEmpty() ?
                                                                                guest.getUserName().substring(0,
                                                                                1).toUpperCase() : "?" %>
                                                                        </div>
                                                                        <div class="guest-name-info">
                                                                            <div class="name">
                                                                                <%= guest.getUserName() %>
                                                                            </div>
                                                                            <div class="id">ID: #<%= guest.getUserID()
                                                                                    %>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td class="email-cell">
                                                                    <%= guest.getEmail() !=null ? guest.getEmail() : "—"
                                                                        %>
                                                                </td>
                                                                <td class="phone-cell">
                                                                    <%= guest.getPhoneNo() !=null ? guest.getPhoneNo()
                                                                        : "—" %>
                                                                </td>
                                                                <td><span class="status-badge">Registered</span></td>
                                                                <td>
                                                                    <div class="action-btns">
                                                                        <button class="btn-action edit"
                                                                            title="Edit Guest"
                                                                            onclick="openEditModal(<%= guest.getUserID() %>, '<%= guest.getUserName() %>', '<%= guest.getEmail() %>', '<%= guest.getPhoneNo() %>')">
                                                                            ✏️
                                                                        </button>
                                                                        <button class="btn-action delete"
                                                                            title="Delete Guest"
                                                                            onclick="openDeleteModal(<%= guest.getUserID() %>, '<%= guest.getUserName() %>')">
                                                                            🗑️
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                    </tbody>
                                                </table>
                                                <div class="no-results" id="noResults">
                                                    <p>😕 No guests match your search.</p>
                                                </div>
                                                <div class="table-footer">
                                                    <div class="table-info">
                                                        Showing <span id="visibleCount">
                                                            <%= guests.size() %>
                                                        </span> of <%= guests.size() %> guests
                                                    </div>
                                                </div>
                                                <% } %>
                                    </div>
                                </div>
                            </main>

                            <!-- Edit Modal -->
                            <div class="modal-overlay" id="editModal">
                                <div class="modal">
                                    <div class="modal-header">
                                        <h3 class="modal-title">✏️ Edit Guest</h3>
                                        <button class="modal-close" onclick="closeEditModal()">✕</button>
                                    </div>
                                    <form id="editForm" method="post"
                                        action="${pageContext.request.contextPath}/user-servlet">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" id="editId">
                                        <div class="modal-body">
                                            <div class="modal-form-group">
                                                <label for="editUsername">Username</label>
                                                <input type="text" id="editUsername" name="username"
                                                    placeholder="Enter username" required>
                                            </div>
                                            <div class="modal-form-group">
                                                <label for="editEmail">Email Address</label>
                                                <input type="email" id="editEmail" name="email"
                                                    placeholder="Enter email" required>
                                            </div>
                                            <div class="modal-form-group">
                                                <label for="editPhone">Phone Number</label>
                                                <input type="text" id="editPhone" name="phoneNo"
                                                    placeholder="Enter phone number">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn-modal btn-cancel"
                                                onclick="closeEditModal()">Cancel</button>
                                            <button type="submit" class="btn-modal btn-save">Save Changes</button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Delete Confirmation Modal -->
                            <div class="modal-overlay" id="deleteModal">
                                <div class="modal">
                                    <div class="modal-header">
                                        <h3 class="modal-title">⚠️ Confirm Delete</h3>
                                        <button class="modal-close" onclick="closeDeleteModal()">✕</button>
                                    </div>
                                    <div class="modal-body">
                                        <p class="delete-confirm-text">
                                            Are you sure you want to delete the guest
                                            <span class="delete-confirm-name" id="deleteGuestName"></span>?
                                        </p>
                                        <div class="delete-warning">
                                            ⚠️ This action cannot be undone. All associated data will be permanently
                                            removed.
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn-modal btn-cancel"
                                            onclick="closeDeleteModal()">Cancel</button>
                                        <form id="deleteForm" method="post"
                                            action="${pageContext.request.contextPath}/user-servlet" style="margin:0;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" id="deleteId">
                                            <button type="submit" class="btn-modal btn-delete-confirm">Delete
                                                Guest</button>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Toast Notification -->
                            <div class="toast" id="toast"></div>

                            <script>
                                // ===== Search / Filter =====
                                const searchInput = document.getElementById('guestSearch');
                                const tableBody = document.getElementById('guestsTableBody');
                                const noResults = document.getElementById('noResults');
                                const visibleCount = document.getElementById('visibleCount');

                                if (searchInput && tableBody) {
                                    searchInput.addEventListener('input', function () {
                                        const query = this.value.toLowerCase().trim();
                                        const rows = tableBody.querySelectorAll('tr');
                                        let count = 0;

                                        rows.forEach(row => {
                                            const name = (row.getAttribute('data-name') || '').toLowerCase();
                                            const email = (row.getAttribute('data-email') || '').toLowerCase();
                                            const phone = (row.getAttribute('data-phone') || '').toLowerCase();

                                            if (name.includes(query) || email.includes(query) || phone.includes(query)) {
                                                row.style.display = '';
                                                count++;
                                            } else {
                                                row.style.display = 'none';
                                            }
                                        });

                                        if (visibleCount) visibleCount.textContent = count;

                                        if (noResults) {
                                            noResults.style.display = count === 0 ? 'block' : 'none';
                                        }
                                    });
                                }

                                // ===== Edit Modal =====
                                function openEditModal(id, username, email, phone) {
                                    document.getElementById('editId').value = id;
                                    document.getElementById('editUsername').value = username;
                                    document.getElementById('editEmail').value = email;
                                    document.getElementById('editPhone').value = phone || '';
                                    document.getElementById('editModal').classList.add('show');
                                }

                                function closeEditModal() {
                                    document.getElementById('editModal').classList.remove('show');
                                }

                                // ===== Delete Modal =====
                                function openDeleteModal(id, name) {
                                    document.getElementById('deleteId').value = id;
                                    document.getElementById('deleteGuestName').textContent = name;
                                    document.getElementById('deleteModal').classList.add('show');
                                }

                                function closeDeleteModal() {
                                    document.getElementById('deleteModal').classList.remove('show');
                                }

                                // Close modal on overlay click
                                document.querySelectorAll('.modal-overlay').forEach(overlay => {
                                    overlay.addEventListener('click', function (e) {
                                        if (e.target === this) {
                                            this.classList.remove('show');
                                        }
                                    });
                                });

                                // Close modal on ESC key
                                document.addEventListener('keydown', function (e) {
                                    if (e.key === 'Escape') {
                                        closeEditModal();
                                        closeDeleteModal();
                                    }
                                });

                                // ===== Toast Notification =====
                                function showToast(message, type) {
                                    const toast = document.getElementById('toast');
                                    toast.textContent = (type === 'success' ? '✅ ' : '❌ ') + message;
                                    toast.className = 'toast ' + type;
                                    setTimeout(() => toast.classList.add('show'), 100);
                                    setTimeout(() => toast.classList.remove('show'), 4000);
                                }

        // Show any flash message from session
        <% if (message != null) { %>
                                    showToast('<%= message %>', '<%= messageType %>');
        <% } %>

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