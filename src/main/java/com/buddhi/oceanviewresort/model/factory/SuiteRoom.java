package com.buddhi.oceanviewresort.model.factory;

import com.buddhi.oceanviewresort.model.entity.Room;

public class SuiteRoom extends Room {

    public SuiteRoom(int roomId, String roomNumber, String status) {
        super(roomId, roomNumber, 3, status); // 3 represents Suite Room Type
    }

    public SuiteRoom(String roomNumber, String status) {
        super(0, roomNumber, 3, status);
    }

    @Override
    public String toString() {
        return "Suite Room [ID=" + getRoomId() + ", Number=" + getRoomNumber() + "]";
    }
}
