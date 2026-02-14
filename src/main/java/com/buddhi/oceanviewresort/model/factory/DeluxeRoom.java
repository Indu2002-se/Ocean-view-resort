package com.buddhi.oceanviewresort.model.factory;

import com.buddhi.oceanviewresort.model.entity.Room;

public class DeluxeRoom extends Room {

    public DeluxeRoom(int roomId, String roomNumber, String status) {
        super(roomId, roomNumber, 2, status); // 2 represents Deluxe Room Type
    }

    public DeluxeRoom(String roomNumber, String status) {
        super(0, roomNumber, 2, status);
    }

    @Override
    public String toString() {
        return "Deluxe Room [ID=" + getRoomId() + ", Number=" + getRoomNumber() + "]";
    }
}
