package com.buddhi.oceanviewresort.service;

import com.buddhi.oceanviewresort.dao.UserDAO;
import com.buddhi.oceanviewresort.model.User;

import java.util.List;

public class UserService {
    private static UserService instance;
    private UserDAO userDAO;

    private UserService() {
        this.userDAO = UserDAO.getInstance();
    }

    public static synchronized UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }

    public boolean creatUser(User user) {
        return userDAO.createUser(user);
    }

    public User getUser(String username, String password) {
        return userDAO.getUser(username, password);
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }

    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
}
