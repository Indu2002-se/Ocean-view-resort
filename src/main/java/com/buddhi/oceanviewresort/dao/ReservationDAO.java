package com.buddhi.oceanviewresort.dao;

import com.buddhi.oceanviewresort.config.DBConnection;
import com.buddhi.oceanviewresort.model.entity.Reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    private static ReservationDAO instance;

    private ReservationDAO() {
    }

    public static synchronized ReservationDAO getInstance() {
        if (instance == null) {
            instance = new ReservationDAO();
        }
        return instance;
    }

    public boolean createReservation(Reservation reservation) {
        String sql = "INSERT INTO reservation (reservationNo, guestName, guestEmail, phoneNo, address, room_type_id, num_guests, checkInDate, checkOutDate, special_requests, status) VALUES (?,?,?,?,?,?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, reservation.getReservationNo());
            stmt.setString(2, reservation.getGuestName());
            stmt.setString(3, reservation.getGuestEmail());
            stmt.setString(4, reservation.getPhoneNo());
            stmt.setString(5, reservation.getAddress());
            stmt.setInt(6, reservation.getRoomTypeId());
            stmt.setInt(7, reservation.getNumGuests());
            stmt.setTimestamp(8, Timestamp.valueOf(reservation.getCheckInDate()));
            stmt.setTimestamp(9, Timestamp.valueOf(reservation.getCheckOutDate()));
            stmt.setString(10, reservation.getSpecialRequests());
            stmt.setString(11, reservation.getStatus());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error create reservation" + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM reservation";

        System.out.println("Attempting to fetch all reservations from database...");

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            System.out.println("Database connection successful");
            ResultSet rs = stmt.executeQuery();

            int count = 0;
            while (rs.next()) {
                // Using Builder Pattern to construct Reservation from database
                Reservation reservation = Reservation.builder()
                        .reservationNo(rs.getString("reservationNo"))
                        .guestName(rs.getString("guestName"))
                        .guestEmail(rs.getString("guestEmail"))
                        .phoneNo(rs.getString("phoneNo"))
                        .address(rs.getString("address"))
                        .roomTypeId(rs.getInt("room_type_id"))
                        .numGuests(rs.getInt("num_guests"))
                        .checkInDate(rs.getTimestamp("checkInDate").toLocalDateTime())
                        .checkOutDate(rs.getTimestamp("checkOutDate").toLocalDateTime())
                        .specialRequests(rs.getString("special_requests"))
                        .status(rs.getString("status"))
                        .build(true);

                reservations.add(reservation);
                count++;
            }

            System.out.println("Successfully fetched " + count + " reservations from database");

        } catch (Exception e) {
            System.err.println("Error fetching reservations: " + e.getMessage());
            e.printStackTrace();

        }
        return reservations;
    }

    public boolean deleteReservation(String reservationNo) {
        String sql = "DELETE FROM reservation WHERE reservationNo = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, reservationNo);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error deleting reservation " + reservationNo + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Reservation getReservationByNo(String reservationNo) {
        String sql = "SELECT * FROM reservation WHERE reservationNo = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, reservationNo);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return Reservation.builder()
                        .reservationNo(rs.getString("reservationNo"))
                        .guestName(rs.getString("guestName"))
                        .guestEmail(rs.getString("guestEmail"))
                        .phoneNo(rs.getString("phoneNo"))
                        .address(rs.getString("address"))
                        .roomTypeId(rs.getInt("room_type_id"))
                        .numGuests(rs.getInt("num_guests"))
                        .checkInDate(rs.getTimestamp("checkInDate").toLocalDateTime())
                        .checkOutDate(rs.getTimestamp("checkOutDate").toLocalDateTime())
                        .specialRequests(rs.getString("special_requests"))
                        .status(rs.getString("status"))
                        .build(true);
            }
        } catch (Exception e) {
            System.err.println("Error fetching reservation " + reservationNo + ": " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateReservation(Reservation reservation) {
        String sql = "UPDATE reservation SET guestName=?, guestEmail=?, phoneNo=?, address=?, " +
                "room_type_id=?, num_guests=?, checkInDate=?, checkOutDate=?, special_requests=?, status=? " +
                "WHERE reservationNo=?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, reservation.getGuestName());
            stmt.setString(2, reservation.getGuestEmail());
            stmt.setString(3, reservation.getPhoneNo());
            stmt.setString(4, reservation.getAddress());
            stmt.setInt(5, reservation.getRoomTypeId());
            stmt.setInt(6, reservation.getNumGuests());
            stmt.setTimestamp(7, Timestamp.valueOf(reservation.getCheckInDate()));
            stmt.setTimestamp(8, Timestamp.valueOf(reservation.getCheckOutDate()));
            stmt.setString(9, reservation.getSpecialRequests());
            stmt.setString(10, reservation.getStatus());
            stmt.setString(11, reservation.getReservationNo());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error updating reservation " + reservation.getReservationNo() + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
