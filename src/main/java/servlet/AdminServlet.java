package servlet;

import model.*;
import service.BookService;
import service.UserService;
import service.PaymentService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private BookService bookService;
    private UserService userService;
    private PaymentService paymentService;

    @Override
    public void init() throws ServletException {
        String dataPath = service.FileService.DATA_PATH;
        bookService = new BookService(dataPath);
        userService = new UserService(dataPath);
        paymentService = new PaymentService(dataPath);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("addBook".equals(action)) {
            String id = String.valueOf(System.currentTimeMillis());
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            int stock = Integer.parseInt(request.getParameter("stock"));
            String type = request.getParameter("type");

            if ("EBOOK".equals(type)) {
                String size = request.getParameter("fileSize");
                String link = request.getParameter("downloadLink");
                bookService.addBook(new EBook(id, title, author, price, category, stock, size, link));
            } else {
                bookService.addBook(new PrintedBook(id, title, author, price, category, stock));
            }
            response.sendRedirect(request.getContextPath() + "/manage-books.jsp");
        } else if ("updateBook".equals(action)) {
            String id = request.getParameter("id");
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            int stock = Integer.parseInt(request.getParameter("stock"));
            String type = request.getParameter("type");

            if ("EBOOK".equals(type)) {
                String size = request.getParameter("fileSize");
                String link = request.getParameter("downloadLink");
                bookService.updateBook(new EBook(id, title, author, price, category, stock, size, link));
            } else {
                bookService.updateBook(new PrintedBook(id, title, author, price, category, stock));
            }
            response.sendRedirect(request.getContextPath() + "/manage-books.jsp");
        } else if ("addAdmin".equals(action)) {
            String id = "ADM" + System.currentTimeMillis();
            String u = request.getParameter("username");
            String p = request.getParameter("password");
            String e = request.getParameter("email");
            String a = "N/A"; // Admins don't need address
            userService.register(new Admin(id, u, p, e, a));
            response.sendRedirect(request.getContextPath() + "/manage-admins.jsp");
        } else if ("updateAdmin".equals(action)) {
            String id = request.getParameter("id");
            String u = request.getParameter("username");
            String p = request.getParameter("password");
            String e = request.getParameter("email");
            String a = "N/A";
            userService.updateUser(new Admin(id, u, p, e, a));
            response.sendRedirect(request.getContextPath() + "/manage-admins.jsp");
        } else if ("updatePayment".equals(action)) {
            String pId = request.getParameter("paymentId");
            String status = request.getParameter("status");
            paymentService.updatePaymentStatus(pId, status);
            response.sendRedirect(request.getContextPath() + "/manage-payments.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("deleteBook".equals(action)) {
            bookService.deleteBook(request.getParameter("id"));
            response.sendRedirect(request.getContextPath() + "/manage-books.jsp");
        } else if ("deleteUser".equals(action)) {
            userService.deleteUser(request.getParameter("id"));
            response.sendRedirect(request.getContextPath() + "/manage-users.jsp");
        }
    }
}
