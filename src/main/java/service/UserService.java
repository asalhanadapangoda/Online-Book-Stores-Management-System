package service;

import model.Admin;
import model.Customer;
import model.User;
import java.util.ArrayList;
import java.util.List;

public class UserService {
    private String userPath;
    private String adminPath;

    public UserService(String dataPath) {
        this.userPath = dataPath + "users.txt";
        this.adminPath = dataPath + "admins.txt";
    }

    public void register(User user) {
        if ("ADMIN".equals(user.getRole())) {
            FileService.appendLine(adminPath, user.toString());
        } else {
            FileService.appendLine(userPath, user.toString());
        }
    }

    public User login(String username, String password) {
        // Try admin login first
        User admin = findUserInFile(adminPath, username, password);
        if (admin != null) return admin;
        
        // Then try customer login
        return findUserInFile(userPath, username, password);
    }

    private User findUserInFile(String path, String username, String password) {
        List<String> lines = FileService.readAllLines(path);
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 6) {
                if (parts[1].equals(username) && parts[2].equals(password)) {
                    String id = parts[0];
                    String email = parts[3];
                    String role = parts[4];
                    String address = parts[5];
                    if ("ADMIN".equals(role)) {
                        return new Admin(id, username, password, email, address);
                    } else {
                        return new Customer(id, username, password, email, address);
                    }
                }
            }
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        users.addAll(loadUsersFromFile(adminPath));
        users.addAll(loadUsersFromFile(userPath));
        return users;
    }

    private List<User> loadUsersFromFile(String path) {
        List<User> users = new ArrayList<>();
        List<String> lines = FileService.readAllLines(path);
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 6) {
                String id = parts[0];
                String u = parts[1];
                String p = parts[2];
                String email = parts[3];
                String role = parts[4];
                String address = parts[5];
                if (role.equals("ADMIN")) {
                    users.add(new Admin(id, u, p, email, address));
                } else {
                    users.add(new Customer(id, u, p, email, address));
                }
            }
        }
        return users;
    }

    public void updateUser(User updatedUser) {
        String path = "ADMIN".equals(updatedUser.getRole()) ? adminPath : userPath;
        List<User> users = loadUsersFromFile(path);
        List<String> lines = new ArrayList<>();
        for (User u : users) {
            if (u.getId().equals(updatedUser.getId())) {
                lines.add(updatedUser.toString());
            } else {
                lines.add(u.toString());
            }
        }
        FileService.writeAllLines(path, lines);
    }

    public void deleteUser(String id) {
        // Try deleting from admins
        if (deleteFromFile(adminPath, id)) return;
        // Try deleting from users
        deleteFromFile(userPath, id);
    }

    private boolean deleteFromFile(String path, String id) {
        List<User> users = loadUsersFromFile(path);
        boolean found = false;
        List<String> lines = new ArrayList<>();
        for (User u : users) {
            if (!u.getId().equals(id)) {
                lines.add(u.toString());
            } else {
                found = true;
            }
        }
        if (found) {
            FileService.writeAllLines(path, lines);
        }
        return found;
    }

    public User getUserById(String id) {
        for (User u : getAllUsers()) {
            if (u.getId().equals(id)) {
                return u;
            }
        }
        return null;
    }
}
