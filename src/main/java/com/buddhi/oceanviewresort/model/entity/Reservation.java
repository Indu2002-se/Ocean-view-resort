package com.buddhi.oceanviewresort.model.entity;

import java.time.LocalDateTime;

public class Reservation {
    private String reservationNo;
    private String guestName;
    private String guestEmail;
    private String phoneNo;
    private String address;
    private int roomTypeId;
    private int numGuests;
    private LocalDateTime checkInDate;
    private LocalDateTime checkOutDate;
    private String specialRequests;
    private String status; // Added status field for confirmation

    // Private constructor - only Builder can create instances
    private Reservation(Builder builder) {
        this.reservationNo = builder.reservationNo;
        this.guestName = builder.guestName;
        this.guestEmail = builder.guestEmail;
        this.phoneNo = builder.phoneNo;
        this.address = builder.address;
        this.roomTypeId = builder.roomTypeId;
        this.numGuests = builder.numGuests;
        this.checkInDate = builder.checkInDate;
        this.checkOutDate = builder.checkOutDate;
        this.specialRequests = builder.specialRequests;
        this.status = builder.status;
    }

    // Static method to get Builder instance
    public static Builder builder() {
        return new Builder();
    }

    // Builder class
    public static class Builder {
        private String reservationNo;
        private String guestName;
        private String guestEmail;
        private String phoneNo;
        private String address;
        private int roomTypeId;
        private int numGuests = 1; // Default value
        private LocalDateTime checkInDate;
        private LocalDateTime checkOutDate;
        private String specialRequests;
        private String status = "PENDING"; // Default status

        private Builder() {
        }

        public Builder reservationNo(String reservationNo) {
            this.reservationNo = reservationNo;
            return this;
        }

        public Builder guestName(String guestName) {
            this.guestName = guestName;
            return this;
        }

        public Builder guestEmail(String guestEmail) {
            this.guestEmail = guestEmail;
            return this;
        }

        public Builder phoneNo(String phoneNo) {
            this.phoneNo = phoneNo;
            return this;
        }

        public Builder address(String address) {
            this.address = address;
            return this;
        }

        public Builder roomTypeId(int roomTypeId) {
            this.roomTypeId = roomTypeId;
            return this;
        }

        public Builder numGuests(int numGuests) {
            this.numGuests = numGuests;
            return this;
        }

        public Builder checkInDate(LocalDateTime checkInDate) {
            this.checkInDate = checkInDate;
            return this;
        }

        public Builder checkOutDate(LocalDateTime checkOutDate) {
            this.checkOutDate = checkOutDate;
            return this;
        }

        public Builder specialRequests(String specialRequests) {
            this.specialRequests = specialRequests;
            return this;
        }

        public Builder status(String status) {
            this.status = status;
            return this;
        }

        public Reservation build() {
            return build(false);
        }

        public Reservation build(boolean skipValidation) {
            if (!skipValidation) {
                validateReservation();
            }
            return new Reservation(this);
        }

        private void validateReservation() {
            if (reservationNo == null || reservationNo.trim().isEmpty()) {
                throw new IllegalArgumentException("Reservation number is required");
            }
            if (guestName == null || guestName.trim().isEmpty()) {
                throw new IllegalArgumentException("Guest name is required");
            }
            if (guestEmail == null || guestEmail.trim().isEmpty()) {
                throw new IllegalArgumentException("Guest email is required");
            }
            if (phoneNo == null || phoneNo.trim().isEmpty()) {
                throw new IllegalArgumentException("Phone number is required");
            }
            if (roomTypeId <= 0) {
                throw new IllegalArgumentException("Valid room type is required");
            }
            if (numGuests <= 0) {
                throw new IllegalArgumentException("Number of guests must be at least 1");
            }
            if (checkInDate == null) {
                throw new IllegalArgumentException("Check-in date is required");
            }
            if (checkOutDate == null) {
                throw new IllegalArgumentException("Check-out date is required");
            }
            if (checkOutDate.isBefore(checkInDate)) {
                throw new IllegalArgumentException("Check-out date must be after check-in date");
            }
        }
    }

    public String getReservationNo() {
        return reservationNo;
    }

    public void setReservationNo(String reservationNo) {
        this.reservationNo = reservationNo;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getGuestEmail() {
        return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
        this.guestEmail = guestEmail;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public int getNumGuests() {
        return numGuests;
    }

    public void setNumGuests(int numGuests) {
        this.numGuests = numGuests;
    }

    public LocalDateTime getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(LocalDateTime checkInDate) {
        this.checkInDate = checkInDate;
    }

    public LocalDateTime getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(LocalDateTime checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public String getSpecialRequests() {
        return specialRequests;
    }

    public void setSpecialRequests(String specialRequests) {
        this.specialRequests = specialRequests;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
