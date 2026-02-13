package com.buddhi.oceanviewresort.controller;

import com.buddhi.oceanviewresort.model.entity.Reservation;
import com.buddhi.oceanviewresort.service.ReservationService;
import com.buddhi.oceanviewresort.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/reservation-servlet")
public class ReservationServlet extends HttpServlet {
    private ReservationService reservationService;
    private UserService userService;

    public void init() throws ServletException {
        super.init();
        this.reservationService = ReservationService.getInstance();
        this.userService = UserService.getInstance();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            handleDelete(req, resp);
            return;
        }

        if ("update".equalsIgnoreCase(action)) {
            handleUpdate(req, resp);
            return;
        }

        if ("confirm".equalsIgnoreCase(action)) {
            handleConfirm(req, resp);
            return;
        }

        try {
            // Retrieve parameters from CreateReservation.jsp
            String reservationNo = req.getParameter("reservationNo");
            if (reservationNo == null || reservationNo.trim().isEmpty()) {
                reservationNo = reservationService.generateReservationNumber();
            }

            String guestName = req.getParameter("guestName");
            String guestEmail = req.getParameter("guestEmail");
            String phoneNo = req.getParameter("phoneNo");
            String address = req.getParameter("address");

            // Handle integer parsing safely
            int roomTypeId = 0;
            try {
                String roomTypeIdStr = req.getParameter("room_type_id");
                if (roomTypeIdStr != null && !roomTypeIdStr.isEmpty()) {
                    roomTypeId = Integer.parseInt(roomTypeIdStr);
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid room type ID: " + e.getMessage());
            }

            int numGuests = 1;
            try {
                String numGuestsStr = req.getParameter("num_guests");
                if (numGuestsStr != null && !numGuestsStr.isEmpty()) {
                    numGuests = Integer.parseInt(numGuestsStr);
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid number of guests: " + e.getMessage());
            }

            String specialRequests = req.getParameter("special_requests");

            LocalDateTime checkIn = LocalDateTime.parse(req.getParameter("checkInDate"));
            LocalDateTime checkOut = LocalDateTime.parse(req.getParameter("checkOutDate"));

            // Using Builder Pattern to create Reservation
            Reservation reservation = Reservation.builder()
                    .reservationNo(reservationNo)
                    .guestName(guestName)
                    .guestEmail(guestEmail)
                    .phoneNo(phoneNo)
                    .address(address)
                    .roomTypeId(roomTypeId)
                    .numGuests(numGuests)
                    .checkInDate(checkIn)
                    .checkOutDate(checkOut)
                    .specialRequests(specialRequests)
                    .status("CONFIRMED") // Auto-confirm for immediate billing
                    .build();

            boolean success = reservationService.createReservation(reservation);

            if (success) {
                // Redirect back to CreateReservation.jsp to show the success popup
                resp.sendRedirect(req.getContextPath()
                        + "/Reservation/CreateReservation.jsp?status=success&reservationNo=" + reservationNo);
            } else {
                resp.sendRedirect(req.getContextPath() + "/Reservation/CreateReservation.jsp?error=true");
            }
        } catch (IllegalArgumentException e) {
            System.err.println("Validation error: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/Reservation/CreateReservation.jsp?error=validation&message="
                    + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/Reservation/CreateReservation.jsp?error=exception");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("ReservationServlet doGet called");

        // Check if this is a request to edit a specific reservation
        String editReservationNo = req.getParameter("edit");
        if (editReservationNo != null && !editReservationNo.trim().isEmpty()) {
            Reservation reservation = reservationService.getReservationByNo(editReservationNo);
            if (reservation != null) {
                req.setAttribute("reservation", reservation);
                req.getRequestDispatcher("/Reservation/UpdateReservation.jsp").forward(req, resp);
                return;
            } else {
                resp.sendRedirect(req.getContextPath() + "/reservation-servlet?error=notfound");
                return;
            }
        }

        List<Reservation> reservations = reservationService.getAllReservations();
        System.out.println("Retrieved " + (reservations != null ? reservations.size() : "null") + " reservations");
        req.setAttribute("reservations", reservations);

        String deleteStatus = req.getParameter("deleteStatus");
        if (deleteStatus != null) {
            req.setAttribute("deleteStatus", deleteStatus);
        }
        String deleteMessage = req.getParameter("deleteMessage");
        if (deleteMessage != null) {
            req.setAttribute("deleteMessage", deleteMessage);
        }

        String updateStatus = req.getParameter("updateStatus");
        if (updateStatus != null) {
            req.setAttribute("updateStatus", updateStatus);
        }
        String updateMessage = req.getParameter("updateMessage");
        if (updateMessage != null) {
            req.setAttribute("updateMessage", updateMessage);
        }

        String confirmStatus = req.getParameter("confirmStatus");
        if (confirmStatus != null) {
            req.setAttribute("confirmStatus", confirmStatus);
        }
        String confirmedReservationNo = req.getParameter("confirmedReservationNo");
        if (confirmedReservationNo != null) {
            req.setAttribute("confirmedReservationNo", confirmedReservationNo);
        }

        System.out.println("Forwarding to ViewReservation.jsp...");
        req.getRequestDispatcher("/Reservation/ViewReservation.jsp").forward(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        handleDelete(req, resp);
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String reservationNo = req.getParameter("reservationNo");
        if (reservationNo == null || reservationNo.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath()
                    + "/reservation-servlet?deleteStatus=error&deleteMessage=Missing+reservation+number");
            return;
        }

        try {
            boolean success = reservationService.deleteReservation(reservationNo);
            if (success) {
                resp.sendRedirect(req.getContextPath()
                        + "/reservation-servlet?deleteStatus=success&deleteMessage=Reservation+deleted+successfully");
            } else {
                resp.sendRedirect(req.getContextPath()
                        + "/reservation-servlet?deleteStatus=error&deleteMessage=Failed+to+delete+reservation");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(
                    req.getContextPath() + "/reservation-servlet?deleteStatus=error&deleteMessage=Unexpected+error");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String reservationNo = req.getParameter("reservationNo");
            if (reservationNo == null || reservationNo.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath()
                        + "/reservation-servlet?updateStatus=error&updateMessage=Missing+reservation+number");
                return;
            }

            String guestName = req.getParameter("guestName");
            String guestEmail = req.getParameter("guestEmail");
            String phoneNo = req.getParameter("phoneNo");
            String address = req.getParameter("address");

            int roomTypeId = 0;
            try {
                String roomTypeIdStr = req.getParameter("room_type_id");
                if (roomTypeIdStr != null && !roomTypeIdStr.isEmpty()) {
                    roomTypeId = Integer.parseInt(roomTypeIdStr);
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid room type ID: " + e.getMessage());
            }

            int numGuests = 1;
            try {
                String numGuestsStr = req.getParameter("num_guests");
                if (numGuestsStr != null && !numGuestsStr.isEmpty()) {
                    numGuests = Integer.parseInt(numGuestsStr);
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid number of guests: " + e.getMessage());
            }

            String specialRequests = req.getParameter("special_requests");
            LocalDateTime checkIn = LocalDateTime.parse(req.getParameter("checkInDate"));
            LocalDateTime checkOut = LocalDateTime.parse(req.getParameter("checkOutDate"));

            Reservation reservation = Reservation.builder()
                    .reservationNo(reservationNo)
                    .guestName(guestName)
                    .guestEmail(guestEmail)
                    .phoneNo(phoneNo)
                    .address(address)
                    .roomTypeId(roomTypeId)
                    .numGuests(numGuests)
                    .checkInDate(checkIn)
                    .checkOutDate(checkOut)
                    .specialRequests(specialRequests)
                    .build();

            boolean success = reservationService.updateReservation(reservation);

            if (success) {
                resp.sendRedirect(req.getContextPath()
                        + "/reservation-servlet?updateStatus=success&updateMessage=Reservation+updated+successfully");
            } else {
                resp.sendRedirect(req.getContextPath()
                        + "/reservation-servlet?updateStatus=error&updateMessage=Failed+to+update+reservation");
            }
        } catch (IllegalArgumentException e) {
            System.err.println("Validation error: " + e.getMessage());
            resp.sendRedirect(
                    req.getContextPath() + "/reservation-servlet?updateStatus=error&updateMessage=" + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(
                    req.getContextPath() + "/reservation-servlet?updateStatus=error&updateMessage=Unexpected+error");
        }
    }

    private void handleConfirm(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String reservationNo = req.getParameter("reservationNo");
        if (reservationNo == null || reservationNo.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/reservation-servlet?error=missing_id");
            return;
        }

        Reservation reservation = reservationService.getReservationByNo(reservationNo);
        if (reservation != null) {
            reservation.setStatus("CONFIRMED");
            boolean success = reservationService.updateReservation(reservation);
            if (success) {
                // Redirect with special flag to trigger popup
                resp.sendRedirect(req.getContextPath()
                        + "/reservation-servlet?confirmStatus=success&confirmedReservationNo=" + reservationNo);
            } else {
                resp.sendRedirect(req.getContextPath() + "/reservation-servlet?confirmStatus=error");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/reservation-servlet?error=notfound");
        }
    }
}
