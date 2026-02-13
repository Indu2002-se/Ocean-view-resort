package com.buddhi.oceanviewresort.model.strategy;

import java.time.temporal.ChronoUnit;
import com.buddhi.oceanviewresort.model.entity.Reservation;

public class ExtendedStayBillStrategy implements BillStrategy {
    @Override
    public double calculateTotal(Reservation reservation, double roomRate) {
        long days = ChronoUnit.DAYS.between(reservation.getCheckInDate(), reservation.getCheckOutDate());
        if (days < 1)
            days = 1;

        double total = days * roomRate;
        if (days > 7) {
            return total * 0.90; // 10% discount for extended stay
        }
        return total;
    }
}
