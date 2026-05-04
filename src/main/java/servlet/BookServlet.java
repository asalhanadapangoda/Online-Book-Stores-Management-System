package servlet;

import model.Book;
import service.BookService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private BookService bookService;

    @Override
    public void init() throws ServletException {
        String dataPath = service.FileService.DATA_PATH;
        bookService = new BookService(dataPath);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null) {
            Book book = bookService.getBookById(id);
            request.setAttribute("book", book);
            request.getRequestDispatcher("book-details.jsp").forward(request, response);
        } else {
            List<Book> books = bookService.getAllBooks();
            request.setAttribute("books", books);
            request.getRequestDispatcher("books.jsp").forward(request, response);
        }
    }
}
