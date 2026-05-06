package servlet;

import model.Customer;
import model.User;
import service.UserService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserService userService;
    private service.CartService cartService;

    @Override
    public void init() throws ServletException {
        String dataPath = service.FileService.DATA_PATH;
        userService = new UserService(dataPath);
        cartService = new service.CartService(dataPath, new service.BookService(dataPath));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            User user = userService.login(request.getParameter("username"), request.getParameter("password"));
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Load cart from file
                session.setAttribute("cart", cartService.getCartItems(user.getId()));

                if ("ADMIN".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if ("register".equals(action)) {
            String id = String.valueOf(System.currentTimeMillis());
            String u = request.getParameter("username");
            String p = request.getParameter("password");
            String e = request.getParameter("email");
            String a = request.getParameter("address");
            Customer customer = new Customer(id, u, p, e, a);
            userService.register(customer);
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Registered successfully");
        } else if ("updateProfile".equals(action)) {
            User user = (User) request.getSession().getAttribute("user");
            if (user != null) {
                String e = request.getParameter("email");
                String p = request.getParameter("password");
                String a = request.getParameter("address");
                
                user.setEmail(e);
                user.setPassword(p);
                user.setAddress(a);
                
                userService.updateUser(user);
                request.getSession().setAttribute("user", user);
                response.sendRedirect(request.getContextPath() + "/profile.jsp?msg=Profile updated");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}
