package com.buddhi.oceanviewresort.model.strategy;

import com.buddhi.oceanviewresort.model.entity.Reservation;

public interface BillStrategy {
    double calculateTotal(Reservation reservation, double roomRate);
}
