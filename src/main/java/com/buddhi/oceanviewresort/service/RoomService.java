package com.buddhi.oceanviewresort.service;

import com.buddhi.oceanviewresort.dao.RoomDAO;
import com.buddhi.oceanviewresort.model.entity.Room;
import com.buddhi.oceanviewresort.model.factory.RoomFactory;
import com.buddhi.oceanviewresort.model.factory.RoomFactoryImpl;

import java.util.List;

public class RoomService {

    // Dependencies
    private final RoomDAO roomDAO;
    private final RoomFactory roomFactory;

    public RoomService() {
        // Instantiate dependencies directly (no singleton)
        this.roomDAO = new RoomDAO();
        this.roomFactory = new RoomFactoryImpl();
    }

    public List<Room> getAllRooms() {
        return roomDAO.getAllRooms();
    }

    public Room getRoomById(int roomId) {
        return roomDAO.getRoomById(roomId);
    }

    // Creating Room using Factory within Service
    public boolean addRoom(String roomNumber, int roomTypeId, String status) {
        // Use factory to create Room object
        Room room = roomFactory.createRoom(roomNumber, roomTypeId, status);
        return roomDAO.addRoom(room);
    }

    // Update existing room
    public boolean updateRoom(int roomId, String roomNumber, int roomTypeId, String status) {
        // Use factory to create Room object with ID
        Room room = roomFactory.createRoom(roomId, roomNumber, roomTypeId, status);
        return roomDAO.updateRoom(room);
    }

    public boolean deleteRoom(int roomId) {
        return roomDAO.deleteRoom(roomId);
    }
}
