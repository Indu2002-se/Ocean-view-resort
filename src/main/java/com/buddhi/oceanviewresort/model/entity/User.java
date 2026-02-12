package com.buddhi.oceanviewresort.model.entity;

public class User {
    private int userID;
    private String username;
    private String email;
    private String password;
    private String phoneNo;

    public User(int userID, String username, String email, String password, String phoneNo) {
        this.userID = userID;
        this.username = username;
        this.email = email;
        this.password = password;
        this.phoneNo = phoneNo;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String userName) {
        this.username = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }
}
