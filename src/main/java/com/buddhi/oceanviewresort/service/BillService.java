package com.buddhi.oceanviewresort.service;

import com.buddhi.oceanviewresort.dao.BillDAO;
import com.buddhi.oceanviewresort.dao.ReservationDAO;
import com.buddhi.oceanviewresort.model.entity.Bill;
import com.buddhi.oceanviewresort.model.entity.Reservation;
import com.buddhi.oceanviewresort.model.strategy.BillStrategy;
import com.buddhi.oceanviewresort.model.strategy.ExtendedStayBillStrategy;
import com.buddhi.oceanviewresort.model.strategy.StandardBillStrategy;

import java.time.LocalDateTime;
import java.util.Optional;

public class BillService {
    private static BillService instance;
    private BillDAO billDAO;
    private ReservationDAO reservationDAO;

    private BillService() {
        this.billDAO = BillDAO.getInstance();
        this.reservationDAO = ReservationDAO.getInstance();
    }

    public static synchronized BillService getInstance() {
        if (instance == null) {
            instance = new BillService();
        }
        return instance;
    }

    public Bill generateBill(String reservationNo) {
        Reservation reservation = reservationDAO.getReservationByNo(reservationNo);
        if (reservation == null) {
            throw new IllegalArgumentException("Reservation not found: " + reservationNo);
        }

        long days = java.time.temporal.ChronoUnit.DAYS.between(reservation.getCheckInDate(),
                reservation.getCheckOutDate());
        if (days < 1)
            days = 1;

        BillStrategy strategy;
        if (days > 7) {
            strategy = new ExtendedStayBillStrategy();
        } else {
            strategy = new StandardBillStrategy();
        }

        double roomRate = getRoomRate(reservation.getRoomTypeId());
        double amount = strategy.calculateTotal(reservation, roomRate);

        Bill bill = Bill.builder()
                .reservationNo(reservationNo)
                .amount(amount)
                .issueDate(LocalDateTime.now())
                .status("PENDING")
                .build();

        if (billDAO.createBill(bill)) {
            return bill;
        } else {
            throw new RuntimeException("Failed to create bill");
        }
    }

    public Bill getBill(String reservationNo) {
        Optional<Bill> bill = billDAO.getBillByReservationNo(reservationNo);
        return bill.orElse(null);
    }

    public Reservation getReservationForBill(String reservationNo) {
        return reservationDAO.getReservationByNo(reservationNo);
    }

    public java.util.List<Reservation> getAllConfirmedReservations() {
        return reservationDAO.getAllReservations();
    }

    public java.util.List<Bill> getAllBills() {
        return billDAO.getAllBills();
    }

    private double getRoomRate(int roomTypeId) {
        switch (roomTypeId) {
            case 1:
                return 100.0; // Standard
            case 2:
                return 200.0; // Deluxe
            case 3:
                return 300.0; // Suite
            default:
                return 150.0;
        }
    }
}
