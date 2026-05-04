package servlet;

import model.Review;
import model.User;
import service.ReviewService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/reviews")
public class ReviewServlet extends HttpServlet {
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        String dataPath = service.FileService.DATA_PATH;
        reviewService = new ReviewService(dataPath);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String id = String.valueOf(System.currentTimeMillis());
        String bId = request.getParameter("bookId");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        reviewService.addReview(new Review(id, user.getId(), bId, rating, comment));
        response.sendRedirect(request.getContextPath() + "/books?id=" + bId);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            reviewService.deleteReview(request.getParameter("id"));
            response.sendRedirect(request.getContextPath() + "/admin/review-management.jsp");
        }
    }
}
