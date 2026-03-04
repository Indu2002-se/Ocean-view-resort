package com.buddhi.oceanviewresort.controller;

import com.buddhi.oceanviewresort.model.entity.Staff;
import com.buddhi.oceanviewresort.service.StaffService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = { "/staff-servlet" })
public class StaffServlet extends HttpServlet {
    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.staffService = StaffService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check manager role
        HttpSession session = req.getSession(false);
        if (session == null || !"MANAGER".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/Auth/Login.jsp?role=MANAGER&error=unauthorized");
            return;
        }
        // Redirect to manager dashboard (data is loaded by the JSP)
        resp.sendRedirect(req.getContextPath() + "/Dashboard/ManagerDashboard.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check manager role
        HttpSession session = req.getSession(false);
        if (session == null || !"MANAGER".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/Auth/Login.jsp?role=MANAGER&error=unauthorized");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "add";
        }

        switch (action) {
            case "add":
                addStaff(req, resp);
                break;
            case "delete":
                deleteStaff(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/Dashboard/ManagerDashboard.jsp");
                break;
        }
    }

    private void addStaff(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String fullName = req.getParameter("fullName");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String position = req.getParameter("position");
            String department = req.getParameter("department");
            double salary = Double.parseDouble(req.getParameter("salary"));

            Staff staff = new Staff(0, fullName, email, phone, position, department, salary);
            boolean success = staffService.addStaff(staff);

            if (success) {
                req.getSession().setAttribute("message", "Staff member added successfully");
                req.getSession().setAttribute("messageType", "success");
            } else {
                req.getSession().setAttribute("message", "Failed to add staff member");
                req.getSession().setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("message", "Error: " + e.getMessage());
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect(req.getContextPath() + "/Dashboard/ManagerDashboard.jsp?tab=staff");
    }

    private void deleteStaff(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int staffId = Integer.parseInt(req.getParameter("staffId"));
            boolean success = staffService.deleteStaff(staffId);

            if (success) {
                req.getSession().setAttribute("message", "Staff member removed successfully");
                req.getSession().setAttribute("messageType", "success");
            } else {
                req.getSession().setAttribute("message", "Failed to remove staff member");
                req.getSession().setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("message", "Error: " + e.getMessage());
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect(req.getContextPath() + "/Dashboard/ManagerDashboard.jsp?tab=staff");
    }
}
