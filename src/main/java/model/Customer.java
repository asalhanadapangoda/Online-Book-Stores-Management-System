package model;

public class Customer extends User {
    public Customer() {
        super();
        setRole("CUSTOMER");
    }

    public Customer(String id, String username, String password, String email, String address) {
        super(id, username, password, email, "CUSTOMER", address);
    }
}
