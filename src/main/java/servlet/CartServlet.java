package servlet;

import model.Book;
import model.CartItem;
import model.User;
import service.BookService;
import service.CartService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private BookService bookService;
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        String dataPath = service.FileService.DATA_PATH;
        bookService = new BookService(dataPath);
        cartService = new CartService(dataPath, bookService);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if ("add".equals(action)) {
            String id = request.getParameter("bookId");
            cartService.addToCart(user.getId(), id);
        } else if ("remove".equals(action)) {
            String id = request.getParameter("bookId");
            cartService.removeFromCart(user.getId(), id);
        }

        // Synchronize session cart with file
        List<CartItem> cart = cartService.getCartItems(user.getId());
        session.setAttribute("cart", cart);
        
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            List<CartItem> cart = cartService.getCartItems(user.getId());
            session.setAttribute("cart", cart);
        }
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
}
