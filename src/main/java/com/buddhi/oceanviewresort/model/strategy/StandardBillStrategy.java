package com.buddhi.oceanviewresort.model.strategy;

import java.time.temporal.ChronoUnit;
import com.buddhi.oceanviewresort.model.entity.Reservation;

public class StandardBillStrategy implements BillStrategy {
    @Override
    public double calculateTotal(Reservation reservation, double roomRate) {
        long days = ChronoUnit.DAYS.between(reservation.getCheckInDate(), reservation.getCheckOutDate());
        if (days < 1)
            days = 1; // Minimum 1 night charge
        return days * roomRate;
    }
}
