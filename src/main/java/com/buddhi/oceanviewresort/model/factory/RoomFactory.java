package com.buddhi.oceanviewresort.model.factory;

import com.buddhi.oceanviewresort.model.entity.*;

/**
 * Enhanced RoomFactory demonstrating Extends Logic
 * by creating specific subclasses (Standard, Deluxe, Suite)
 * based on the room type identifier.
 */
public class RoomFactory {

    // Factory method for existing rooms (from DB)
    public Room createRoom(int roomId, String roomNumber, int roomTypeId, String status) {
        switch (roomTypeId) {
            case 1:
                return new StandardRoom(roomId, roomNumber, status);
            case 2:
                return new DeluxeRoom(roomId, roomNumber, status);
            case 3:
                return new SuiteRoom(roomId, roomNumber, status);
            default:
                // Fallback to generic Room if type is unknown
                return new Room(roomId, roomNumber, roomTypeId, status);
        }
    }

    // Factory method for new rooms (before DB insertion)
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
