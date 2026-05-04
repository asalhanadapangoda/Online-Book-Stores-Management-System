package service;

import model.Book;
import model.EBook;
import model.PrintedBook;
import java.util.ArrayList;
import java.util.List;

public class BookService {
    private String filePath;

    public BookService(String dataPath) {
        this.filePath = dataPath + "books.txt";
    }

    public void addBook(Book book) {
        FileService.appendLine(filePath, book.toString());
    }

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        List<String> lines = FileService.readAllLines(filePath);
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 7) {
                String id = parts[0];
                String title = parts[1];
                String author = parts[2];
                double price = Double.parseDouble(parts[3]);
                String category = parts[4];
                int stock = Integer.parseInt(parts[5]);
                String type = parts[6];

                if (type.equals("EBOOK") && parts.length >= 9) {
                    books.add(new EBook(id, title, author, price, category, stock, parts[7], parts[8]));
                } else if (type.equals("PRINTED")) {
                    books.add(new PrintedBook(id, title, author, price, category, stock));
                }
            }
        }
        return books;
    }

    public void updateBook(Book updatedBook) {
        List<Book> books = getAllBooks();
        List<String> lines = new ArrayList<>();
        for (Book b : books) {
            if (b.getId().equals(updatedBook.getId())) {
                lines.add(updatedBook.toString());
            } else {
                lines.add(b.toString());
            }
        }
        FileService.writeAllLines(filePath, lines);
    }

    public void deleteBook(String id) {
        List<Book> books = getAllBooks();
        List<String> lines = new ArrayList<>();
        for (Book b : books) {
            if (!b.getId().equals(id)) {
                lines.add(b.toString());
            }
        }
        FileService.writeAllLines(filePath, lines);
    }
    
    public Book getBookById(String id) {
        for (Book b : getAllBooks()) {
            if (b.getId().equals(id)) return b;
        }
        return null;
    }
}
