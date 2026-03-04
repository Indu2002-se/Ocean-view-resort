package com.buddhi.oceanviewresort.controller;

import com.buddhi.oceanviewresort.model.entity.Bill;
import com.buddhi.oceanviewresort.model.entity.Reservation;
import com.buddhi.oceanviewresort.model.entity.Room;

import com.buddhi.oceanviewresort.service.BillService;
import com.buddhi.oceanviewresort.service.ReservationService;
import com.buddhi.oceanviewresort.service.RoomService;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/report-servlet")
public class ReportServlet extends HttpServlet {
    private ReservationService reservationService;
    private BillService billService;

    private RoomService roomService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.reservationService = ReservationService.getInstance();
        this.billService = BillService.getInstance();

        this.roomService = new RoomService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Fetch all data for reports
            List<Reservation> reservations = reservationService.getAllReservations();
            List<Bill> bills = billService.getAllBills();

            List<Room> rooms = roomService.getAllRooms();

            // Set attributes for JSP
            req.setAttribute("reservations", reservations);
            req.setAttribute("bills", bills);

            req.setAttribute("rooms", rooms);

            // Compute summary stats
            double totalRevenue = 0;
            for (Bill b : bills) {
                totalRevenue += b.getAmount();
            }
            req.setAttribute("totalRevenue", totalRevenue);

            int confirmedCount = 0, pendingCount = 0, cancelledCount = 0;
            int standardRoomCount = 0, deluxeRoomCount = 0, suiteRoomCount = 0;
            int totalGuestsInReservations = 0;

            for (Reservation r : reservations) {
                String status = r.getStatus();
                if ("CONFIRMED".equalsIgnoreCase(status))
                    confirmedCount++;
                else if ("PENDING".equalsIgnoreCase(status))
                    pendingCount++;
                else if ("CANCELLED".equalsIgnoreCase(status))
                    cancelledCount++;

                int roomType = r.getRoomTypeId();
                if (roomType == 1)
                    standardRoomCount++;
                else if (roomType == 2)
                    deluxeRoomCount++;
                else if (roomType == 3)
                    suiteRoomCount++;

                totalGuestsInReservations += r.getNumGuests();
            }

            req.setAttribute("confirmedCount", confirmedCount);
            req.setAttribute("pendingCount", pendingCount);
            req.setAttribute("cancelledCount", cancelledCount);
            req.setAttribute("standardRoomCount", standardRoomCount);
            req.setAttribute("deluxeRoomCount", deluxeRoomCount);
            req.setAttribute("suiteRoomCount", suiteRoomCount);
            req.setAttribute("totalGuestsInReservations", totalGuestsInReservations);

            // Room status counts
            int availableRooms = 0, occupiedRooms = 0, maintenanceRooms = 0;
            for (Room room : rooms) {
                String s = room.getStatus();
                if ("available".equalsIgnoreCase(s))
                    availableRooms++;
                else if ("occupied".equalsIgnoreCase(s))
                    occupiedRooms++;
                else if ("maintenance".equalsIgnoreCase(s))
                    maintenanceRooms++;
            }
            req.setAttribute("availableRooms", availableRooms);
            req.setAttribute("occupiedRooms", occupiedRooms);
            req.setAttribute("maintenanceRooms", maintenanceRooms);

        } catch (Exception e) {
            System.err.println("Error generating reports: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("reportError", "Unable to load report data: " + e.getMessage());
        }

        req.getRequestDispatcher("/Dashboard/Reports.jsp").forward(req, resp);
    }
}
