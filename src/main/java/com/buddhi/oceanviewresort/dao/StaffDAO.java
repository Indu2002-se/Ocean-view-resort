package com.buddhi.oceanviewresort.dao;

import com.buddhi.oceanviewresort.config.DBConnection;
import com.buddhi.oceanviewresort.model.entity.Staff;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {
    private static StaffDAO instance;

    private StaffDAO() {
    }

    public static synchronized StaffDAO getInstance() {
        if (instance == null) {
            instance = new StaffDAO();
        }
        return instance;
    }

    public boolean addStaff(Staff staff) {
        String sql = "INSERT INTO staff(full_name, email, phone, position, department, salary) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, staff.getFullName());
            stmt.setString(2, staff.getEmail());
            stmt.setString(3, staff.getPhone());
            stmt.setString(4, staff.getPosition());
            stmt.setString(5, staff.getDepartment());
            stmt.setDouble(6, staff.getSalary());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error adding staff: " + e.getMessage());
            return false;
        }
    }

    public List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM staff ORDER BY staff_id DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Staff staff = new Staff(
                        rs.getInt("staff_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("position"),
                        rs.getString("department"),
                        rs.getDouble("salary"));
                staffList.add(staff);
            }
        } catch (Exception e) {
            System.err.println("Error loading staff: " + e.getMessage());
        }
        return staffList;
    }

    public Staff getStaffById(int staffId) {
        String sql = "SELECT * FROM staff WHERE staff_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Staff(
                        rs.getInt("staff_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("position"),
                        rs.getString("department"),
                        rs.getDouble("salary"));
            }
        } catch (Exception e) {
            System.err.println("Error getting staff: " + e.getMessage());
        }
        return null;
    }

    public boolean deleteStaff(int staffId) {
        String sql = "DELETE FROM staff WHERE staff_id=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            System.err.println("Error deleting staff: " + e.getMessage());
            return false;
        }
    }
}
