package com.buddhi.oceanviewresort.dao;

import com.buddhi.oceanviewresort.config.DBConnection;
import com.buddhi.oceanviewresort.model.entity.Bill;
import java.sql.*;
import java.util.Optional;

public class BillDAO {
    private static BillDAO instance;

    private BillDAO() {
    }

    public static synchronized BillDAO getInstance() {
        if (instance == null) {
            instance = new BillDAO();
        }
        return instance;
    }

    public boolean createBill(Bill bill) {
        String sql = "INSERT INTO bill (reservationNo, amount, issue_date, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bill.getReservationNo());
            stmt.setDouble(2, bill.getAmount());
            stmt.setTimestamp(3, Timestamp.valueOf(bill.getIssueDate()));
            stmt.setString(4, bill.getStatus());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating bill: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public java.util.List<Bill> getAllBills() {
        java.util.List<Bill> bills = new java.util.ArrayList<>();
        String sql = "SELECT * FROM bill";
        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                bills.add(Bill.builder()
                        .billId(rs.getInt("billId"))
                        .reservationNo(rs.getString("reservationNo"))
                        .amount(rs.getDouble("amount"))
                        .issueDate(rs.getTimestamp("issue_date").toLocalDateTime())
                        .status(rs.getString("status"))
                        .build());
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all bills: " + e.getMessage());
            e.printStackTrace();
        }
        return bills;
    }

    public Optional<Bill> getBillByReservationNo(String reservationNo) {
        String sql = "SELECT * FROM bill WHERE reservationNo = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, reservationNo);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return Optional.of(Bill.builder()
                        .billId(rs.getInt("billId"))
                        .reservationNo(rs.getString("reservationNo"))
                        .amount(rs.getDouble("amount"))
                        .issueDate(rs.getTimestamp("issue_date").toLocalDateTime())
                        .status(rs.getString("status"))
                        .build());
            }
        } catch (SQLException e) {
            System.err.println("Error fetching bill: " + e.getMessage());
            e.printStackTrace();
        }
        return Optional.empty();
    }
}
