package com.buddhi.oceanviewresort.controller;

import com.buddhi.oceanviewresort.model.entity.Room;
import com.buddhi.oceanviewresort.service.RoomService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { "/room-servlet", "/rooms" })
public class RoomServlet extends HttpServlet {

    private RoomService roomService;

    @Override
    public void init() throws ServletException {
        super.init();
        // Initialize RoomService directly without Singleton pattern
        this.roomService = new RoomService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "edit":
                showEditForm(req, resp);
                break;
            case "list":
            default:
                listRooms(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "add";
        }

        switch (action) {
            case "add":
                addRoom(req, resp);
                break;
            case "update":
                updateRoom(req, resp);
                break;
            case "delete":
                deleteRoom(req, resp);
                break;
            default:
                listRooms(req, resp);
                break;
        }
    }

    private void listRooms(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Room> rooms = roomService.getAllRooms();
        req.setAttribute("rooms", rooms);
        // Forwarding to Room.jsp
        req.getRequestDispatcher("/Dashboard/Room.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                Room existingRoom = roomService.getRoomById(id);
                req.setAttribute("room", existingRoom);
                req.getRequestDispatcher("/Dashboard/room-form.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("room-servlet?action=list&error=MissingId");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("room-servlet?action=list&error=InvalidId");
        }
    }

    private void addRoom(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String roomNumber = req.getParameter("roomNumber");
            int roomTypeId = Integer.parseInt(req.getParameter("roomTypeId"));
            String status = req.getParameter("status");

            boolean success = roomService.addRoom(roomNumber, roomTypeId, status);
            if (success) {
                resp.sendRedirect("room-servlet?action=list&success=RoomAdded");
            } else {
                resp.sendRedirect("room-servlet?action=list&error=AddFailed");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("room-servlet?action=list&error=InvalidInput");
        }
    }

    private void updateRoom(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String roomNumber = req.getParameter("roomNumber");
            int roomTypeId = Integer.parseInt(req.getParameter("roomTypeId"));
            String status = req.getParameter("status");

            boolean success = roomService.updateRoom(id, roomNumber, roomTypeId, status);
            if (success) {
                resp.sendRedirect("room-servlet?action=list&success=RoomUpdated");
            } else {
                resp.sendRedirect("room-servlet?action=list&error=UpdateFailed");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("room-servlet?action=list&error=InvalidInput");
        }
    }

    private void deleteRoom(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean success = roomService.deleteRoom(id);
            if (success) {
                resp.sendRedirect("room-servlet?action=list&success=RoomDeleted");
            } else {
                resp.sendRedirect("room-servlet?action=list&error=DeleteFailed");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("room-servlet?action=list&error=InvalidId");
        }
    }
}
