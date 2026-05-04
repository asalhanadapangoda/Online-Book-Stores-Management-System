package servlet;

import model.*;
import service.PaymentService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {
    private PaymentService paymentService;
    private service.CartService cartService;

    @Override
    public void init() throws ServletException {
        String dataPath = service.FileService.DATA_PATH;
        paymentService = new PaymentService(dataPath);
        cartService = new service.CartService(dataPath, new service.BookService(dataPath));
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        double total = 0;
        for (CartItem item : cart) {
            total += item.getTotalPrice();
        }

        String method = request.getParameter("method");
        String pId = String.valueOf(System.currentTimeMillis());
        String oId = "ORD-" + pId;
        
        Payment payment;
        if ("PAYNOW".equals(method)) {
            payment = new PayNowPayment(pId, oId, user.getId(), total);
        } else {
            payment = new CashOnDelivery(pId, oId, user.getId(), total);
        }

        paymentService.recordPayment(payment);
        cartService.clearCart(user.getId());
        session.removeAttribute("cart");
        response.sendRedirect(request.getContextPath() + "/order-confirmation.jsp?orderId=" + oId);
    }
}
