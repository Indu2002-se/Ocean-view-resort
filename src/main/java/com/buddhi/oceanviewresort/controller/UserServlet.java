package com.buddhi.oceanviewresort.controller;

import com.buddhi.oceanviewresort.model.entity.User;
import com.buddhi.oceanviewresort.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class UserServlet extends HttpServlet {
    private UserService userService;

    public void init() throws ServletException {
        super.init();
        this.userService = UserService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("list".equals(action)) {
            List<User> users = userService.getAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/Dashboard/guests.jsp").forward(req, resp);
        }
    }

    // Signup user
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("update".equals(action)) {
            updateUser(req, resp);
        } else if ("delete".equals(action)) {
            deleteUser(req, resp);
        } else {
            // Default to signup
            signupUser(req, resp);
        }
    }

    private void signupUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phoneNo = req.getParameter("phoneNo");

        User user = new User(0, username, email, password, phoneNo);
        boolean success = userService.creatUser(user);

        try {
            if (success) {
                req.setAttribute("guestName", username);
                req.setAttribute("guestEmail", email);
                req.setAttribute("message", "Registration Successful!");
                req.setAttribute("messageType", "success");
                req.getRequestDispatcher("/Auth/Login.jsp").forward(req, resp);
            } else {
                req.setAttribute("message", "Registration Failed - Email may already exist");
                req.setAttribute("messageType", "error");
                resp.sendRedirect("signup.jsp?error=true");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String phoneNo = req.getParameter("phoneNo");

        User user = new User(id, username, email, null, phoneNo); // Password not updated here
        boolean success = userService.updateUser(user);

        if (success) {
            req.getSession().setAttribute("message", "Guest updated successfully");
            req.getSession().setAttribute("messageType", "success");
        } else {
            req.getSession().setAttribute("message", "Failed to update guest");
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect(req.getContextPath() + "/user-servlet?action=list");
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        boolean success = userService.deleteUser(id);

        if (success) {
            req.getSession().setAttribute("message", "Guest deleted successfully");
            req.getSession().setAttribute("messageType", "success");
        } else {
            req.getSession().setAttribute("message", "Failed to delete guest");
            req.getSession().setAttribute("messageType", "error");
        }
        resp.sendRedirect(req.getContextPath() + "/user-servlet?action=list");
    }
}
