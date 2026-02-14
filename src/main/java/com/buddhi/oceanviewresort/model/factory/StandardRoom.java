package com.buddhi.oceanviewresort.model.factory;

import com.buddhi.oceanviewresort.model.entity.Room;

public class StandardRoom extends Room {

    public StandardRoom(int roomId, String roomNumber, String status) {
        super(roomId, roomNumber, 1, status); // 1 represents Standard Room Type
    }

    public StandardRoom(String roomNumber, String status) {
        super(0, roomNumber, 1, status);
    }

    @Override
    public String toString() {
        return "Standard Room [ID=" + getRoomId() + ", Number=" + getRoomNumber() + "]";
    }
}
