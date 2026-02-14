package com.buddhi.oceanviewresort.model.factory;

import com.buddhi.oceanviewresort.model.entity.*;

/**
 * Enhanced RoomFactory demonstrating Extends Logic
 * by creating specific subclasses (Standard, Deluxe, Suite)
 * based on the room type identifier.
 */
public interface RoomFactory {

    // Factory method for existing rooms (from DB)
    Room createRoom(int roomId, String roomNumber, int roomTypeId, String status);

    // Factory method for new rooms (before DB insertion)
    Room createRoom(String roomNumber, int roomTypeId, String status);
}
