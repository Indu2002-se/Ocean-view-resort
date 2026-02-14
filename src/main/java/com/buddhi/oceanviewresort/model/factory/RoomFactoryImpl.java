package com.buddhi.oceanviewresort.model.factory;

import com.buddhi.oceanviewresort.model.entity.Room;

public class RoomFactoryImpl implements RoomFactory {

    @Override
    public Room createRoom(int roomId, String roomNumber, int roomTypeId, String status) {
        switch (roomTypeId) {
            case 1:
                return new StandardRoom(roomId, roomNumber, status);
            case 2:
                return new DeluxeRoom(roomId, roomNumber, status);
            case 3:
                return new SuiteRoom(roomId, roomNumber, status);
            default:
                return new Room(roomId, roomNumber, roomTypeId, status);
        }
    }

    @Override
    public Room createRoom(String roomNumber, int roomTypeId, String status) {
        switch (roomTypeId) {
            case 1:
                return new StandardRoom(roomNumber, status);
            case 2:
                return new DeluxeRoom(roomNumber, status);
            case 3:
                return new SuiteRoom(roomNumber, status);
            default:
                return new Room(0, roomNumber, roomTypeId, status);
        }
    }
}
