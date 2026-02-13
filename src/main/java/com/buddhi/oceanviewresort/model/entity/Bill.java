package com.buddhi.oceanviewresort.model.entity;

import java.time.LocalDateTime;

public class Bill {
    private int billId;
    private String reservationNo;
    private double amount;
    private LocalDateTime issueDate;
    private String status;

    private Bill(Builder builder) {
        this.billId = builder.billId;
        this.reservationNo = builder.reservationNo;
        this.amount = builder.amount;
        this.issueDate = builder.issueDate;
        this.status = builder.status;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private int billId;
        private String reservationNo;
        private double amount;
        private LocalDateTime issueDate;
        private String status = "PENDING";

        public Builder billId(int billId) {
            this.billId = billId;
            return this;
        }

        public Builder reservationNo(String reservationNo) {
            this.reservationNo = reservationNo;
            return this;
        }

        public Builder amount(double amount) {
            this.amount = amount;
            return this;
        }

        public Builder issueDate(LocalDateTime issueDate) {
            this.issueDate = issueDate;
            return this;
        }

        public Builder status(String status) {
            this.status = status;
            return this;
        }

        public Bill build() {
            return new Bill(this);
        }
    }

    public int getBillId() {
        return billId;
    }

    public String getReservationNo() {
        return reservationNo;
    }

    public double getAmount() {
        return amount;
    }

    public LocalDateTime getIssueDate() {
        return issueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
