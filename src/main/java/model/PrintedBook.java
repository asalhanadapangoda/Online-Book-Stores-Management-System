package model;

public class PrintedBook extends Book {

    public PrintedBook() {
        super();
        setType("PRINTED");
    }

    public PrintedBook(String id, String title, String author, double price, String category, int stock) {
        super(id, title, author, price, category, stock, "PRINTED");
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
