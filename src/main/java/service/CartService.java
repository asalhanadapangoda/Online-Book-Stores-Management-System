package service;

import model.Book;
import model.CartItem;
import java.util.ArrayList;
import java.util.List;

public class CartService {
    private String filePath;
    private BookService bookService;

    public CartService(String dataPath, BookService bookService) {
        this.filePath = dataPath + "cart.txt";
        this.bookService = bookService;
    }

    public List<CartItem> getCartItems(String userId) {
        List<CartItem> items = new ArrayList<>();
        List<String> lines = FileService.readAllLines(filePath);
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 3) {
                if (parts[0].equals(userId)) {
                    Book book = bookService.getBookById(parts[1]);
                    if (book != null) {
                        items.add(new CartItem(book, Integer.parseInt(parts[2])));
                    }
                }
            }
        }
        return items;
    }

    public void addToCart(String userId, String bookId) {
        List<String> lines = FileService.readAllLines(filePath);
        boolean found = false;
        List<String> newLines = new ArrayList<>();
        
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 3 && parts[0].equals(userId) && parts[1].equals(bookId)) {
                int qty = Integer.parseInt(parts[2]) + 1;
                newLines.add(userId + "|" + bookId + "|" + qty);
                found = true;
            } else {
                newLines.add(line);
            }
        }
        
        if (!found) {
            newLines.add(userId + "|" + bookId + "|1");
        }
        FileService.writeAllLines(filePath, newLines);
    }

    public void removeFromCart(String userId, String bookId) {
        List<String> lines = FileService.readAllLines(filePath);
        List<String> newLines = new ArrayList<>();
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (!(parts.length >= 3 && parts[0].equals(userId) && parts[1].equals(bookId))) {
                newLines.add(line);
            }
        }
        FileService.writeAllLines(filePath, newLines);
    }

    public void clearCart(String userId) {
        List<String> lines = FileService.readAllLines(filePath);
        List<String> newLines = new ArrayList<>();
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 3 && !parts[0].equals(userId)) {
                newLines.add(line);
            }
        }
        FileService.writeAllLines(filePath, newLines);
    }
}
