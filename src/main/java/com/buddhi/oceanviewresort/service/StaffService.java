package com.buddhi.oceanviewresort.service;

import com.buddhi.oceanviewresort.dao.StaffDAO;
import com.buddhi.oceanviewresort.model.entity.Staff;

import java.util.List;

public class StaffService {
    private static StaffService instance;
    private StaffDAO staffDAO;

    private StaffService() {
        this.staffDAO = StaffDAO.getInstance();
    }

    public static synchronized StaffService getInstance() {
        if (instance == null) {
            instance = new StaffService();
        }
        return instance;
    }

    public boolean addStaff(Staff staff) {
        return staffDAO.addStaff(staff);
    }

    public List<Staff> getAllStaff() {
        return staffDAO.getAllStaff();
    }

    public Staff getStaffById(int staffId) {
        return staffDAO.getStaffById(staffId);
    }

    public boolean deleteStaff(int staffId) {
        return staffDAO.deleteStaff(staffId);
    }
}
