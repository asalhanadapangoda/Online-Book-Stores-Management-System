package model;

public class Admin extends User {
    public Admin() {
        super();
        setRole("ADMIN");
    }

    public Admin(String id, String username, String password, String email, String address) {
        super(id, username, password, email, "ADMIN", address);
    }
}
