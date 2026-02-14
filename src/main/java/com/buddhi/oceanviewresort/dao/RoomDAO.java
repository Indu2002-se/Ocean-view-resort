package com.buddhi.oceanviewresort.dao;

import com.buddhi.oceanviewresort.config.DBConnection;
import com.buddhi.oceanviewresort.model.entity.Room;
import com.buddhi.oceanviewresort.model.factory.RoomFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    // Using factory to create Room objects from ResultSet
    private final RoomFactory roomFactory;

    public RoomDAO() {
        this.roomFactory = new RoomFactory();
    }

    public boolean addRoom(Room room) {
        String sql = "INSERT INTO rooms (roomNumber, roomTypeId, status) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, room.getRoomNumber());
            stmt.setInt(2, room.getRoomTypeId());
            stmt.setString(3, room.getStatus()); // 'available', 'occupied', 'maintenance'

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRoom(Room room) {
        String sql = "UPDATE rooms SET roomNumber = ?, roomTypeId = ?, status = ? WHERE roomId = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, room.getRoomNumber());
            stmt.setInt(2, room.getRoomTypeId());
            stmt.setString(3, room.getStatus());
            stmt.setInt(4, room.getRoomId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRoom(int roomId) {
        String sql = "DELETE FROM rooms WHERE roomId = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roomId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Room getRoomById(int roomId) {
        String sql = "SELECT * FROM rooms WHERE roomId = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, roomId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Use factory to create object
                return roomFactory.createRoom(
                        rs.getInt("roomId"),
                        rs.getString("roomNumber"),
                        rs.getInt("roomTypeId"),
                        rs.getString("status"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if not found
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms";

        try (Connection conn = DBConnection.getInstance().getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                rooms.add(roomFactory.createRoom(
                        rs.getInt("roomId"),
                        rs.getString("roomNumber"),
                        rs.getInt("roomTypeId"),
                        rs.getString("status")));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }
}
