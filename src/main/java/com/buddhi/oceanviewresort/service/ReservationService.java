package com.buddhi.oceanviewresort.service;

import com.buddhi.oceanviewresort.dao.ReservationDAO;
import com.buddhi.oceanviewresort.model.entity.Reservation;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public class ReservationService {
    private static ReservationService instance;
    private ReservationDAO reservationDAO;

    private ReservationService() {
        this.reservationDAO = ReservationDAO.getInstance();
    }

    public static synchronized ReservationService getInstance() {
        if (instance == null) {
            instance = new ReservationService();
        }
        return instance;
    }

    public boolean createReservation(Reservation reservation) {
        validateReservationDates(reservation);
        return reservationDAO.createReservation(reservation);
    }

    public List<Reservation> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    public String generateReservationNumber() {
        return "RES-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }

    private void validateReservationDates(Reservation reservation) {
        LocalDateTime now = LocalDateTime.now();
        if (reservation.getCheckInDate().isBefore(now)) {
            throw new IllegalArgumentException("Check-in date cannot be in the past");
        }

        long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(
                reservation.getCheckInDate(),
                reservation.getCheckOutDate());

        if (daysBetween > 30) {
            throw new IllegalArgumentException("Reservation cannot exceed 30 days");
        }
    }

    public boolean isRoomAvailable(int roomTypeId, LocalDateTime checkIn, LocalDateTime checkOut) {
        return true;
    }

//    public boolean deleteReservation(String reservationNo) {
//        // Delete associated bill first due to foreign key constraint
//        BillService billService = new BillService();
//        billService.deleteBill(reservationNo);
//        return reservationDAO.deleteReservation(reservationNo);
//    }

    public Reservation getReservationByNo(String reservationNo) {
        return reservationDAO.getReservationByNo(reservationNo);
    }

    public boolean updateReservation(Reservation reservation) {
        validateReservationDates(reservation);
        return reservationDAO.updateReservation(reservation);
    }
}
