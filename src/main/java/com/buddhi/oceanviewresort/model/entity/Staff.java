package com.buddhi.oceanviewresort.model.entity;

public class Staff {
    private int staffId;
    private String fullName;
    private String email;
    private String phone;
    private String position;
    private String department;
    private double salary;

    public Staff() {
    }

    public Staff(int staffId, String fullName, String email, String phone, String position, String department,
            double salary) {
        this.staffId = staffId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.position = position;
        this.department = department;
        this.salary = salary;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }
}
