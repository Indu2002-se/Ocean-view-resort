package com.buddhi.oceanviewresort.controller;

import com.buddhi.oceanviewresort.model.entity.Bill;
import com.buddhi.oceanviewresort.service.BillService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/bill-servlet")
public class BillServlet extends HttpServlet {
    private BillService billService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.billService = BillService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String reservationNo = req.getParameter("reservationNo");

        try {
            if ("generate".equals(action)) {
                if (reservationNo != null && !reservationNo.isEmpty()) {
                    Bill bill = billService.generateBill(reservationNo);
                    req.setAttribute("bill", bill);
                    req.getSession().setAttribute("message", "Bill generated successfully!");
                    req.getSession().setAttribute("messageType", "success");
                    resp.sendRedirect(req.getContextPath() + "/bill-servlet?action=view&reservationNo=" + reservationNo);
                    return;
                } else {
                    req.getSession().setAttribute("message", "Reservation Number is required to generate bill.");
                    req.getSession().setAttribute("messageType", "error");
                }
            } else if ("view".equals(action)) {
                if (reservationNo != null && !reservationNo.isEmpty()) {
                    Bill bill = billService.getBill(reservationNo);
                    if (bill != null) {
                        req.setAttribute("bill", bill);
                        req.setAttribute("reservation", billService.getReservationForBill(reservationNo));
                        req.getRequestDispatcher("/Bill/ViewBill.jsp").forward(req, resp);
                        return;
                    } else {
                        req.getSession().setAttribute("message", "Bill not found for reservation: " + reservationNo);
                        req.getSession().setAttribute("messageType", "error");
                    }
                }
            }
        } catch (Exception e) {
            req.getSession().setAttribute("message", "Error: " + e.getMessage());
            req.getSession().setAttribute("messageType", "error");
            e.printStackTrace();
        }

        // Default: show list of reservations for bill generation
        req.setAttribute("reservations", billService.getAllConfirmedReservations());
        req.getRequestDispatcher("/Bill/GenerateBill.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
