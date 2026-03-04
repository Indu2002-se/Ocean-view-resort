package com.buddhi.oceanviewresort.controller;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/login-servlet")
public class LoginServlet extends HttpServlet {


    public void init() throws ServletException {
        super.init();

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String role = req.getParameter("role");
            String username = req.getParameter("username");
            String password = req.getParameter("password");

            // Default to GUEST if role is missing/null (though frontend should send it)
            if (role == null || role.isEmpty()) {
                role = "GUEST";
            }

            HttpSession session = req.getSession();
            boolean isAuthenticated = false;
            String redirectUrl = "";

            if ("STAFF".equalsIgnoreCase(role)) {
                // Hardcoded Staff Credentials
                if ("staff".equals(username) && "staff123".equals(password)) {
                    isAuthenticated = true;
                    session.setAttribute("username", username);
                    session.setAttribute("role", "STAFF");
                    redirectUrl = "/Dashboard/StaffDashboard.jsp";
                }
            } else if ("MANAGER".equalsIgnoreCase(role)) {
                // Hardcoded Manager Credentials
                if ("manager".equals(username) && "manager123".equals(password)) {
                    isAuthenticated = true;
                    session.setAttribute("username", username);
                    session.setAttribute("role", "MANAGER");
                    redirectUrl = "/Dashboard/ManagerDashboard.jsp";
                }
            }


            if (isAuthenticated) {
                resp.sendRedirect(req.getContextPath() + redirectUrl);
            } else {
                // Redirect back to login with error and preserve role (so UI stays consistent)
                resp.sendRedirect(req.getContextPath() + "/Auth/Login.jsp?error=invalid&role=" + role);
            }

        } catch (Exception e) {
            e.printStackTrace();
            String role = req.getParameter("role");
            resp.sendRedirect(
                    req.getContextPath() + "/Auth/Login.jsp?error=true&role=" + (role != null ? role : "GUEST"));
        }
    }
}
