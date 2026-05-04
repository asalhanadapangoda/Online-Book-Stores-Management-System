package service;

import model.Review;
import java.util.ArrayList;
import java.util.List;

public class ReviewService {
    private String filePath;

    public ReviewService(String dataPath) {
        this.filePath = dataPath + "reviews.txt";
    }

    public void addReview(Review review) {
        FileService.appendLine(filePath, review.toString());
    }

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        List<String> lines = FileService.readAllLines(filePath);
        for (String line : lines) {
            String[] parts = line.split("\\|");
            if (parts.length >= 5) {
                reviews.add(new Review(parts[0], parts[1], parts[2], Integer.parseInt(parts[3]), parts[4]));
            }
        }
        return reviews;
    }

    public List<Review> getReviewsByBookId(String bookId) {
        List<Review> bookReviews = new ArrayList<>();
        for (Review r : getAllReviews()) {
            if (r.getBookId().equals(bookId)) {
                bookReviews.add(r);
            }
        }
        return bookReviews;
    }

    public void deleteReview(String id) {
        List<Review> reviews = getAllReviews();
        List<String> lines = new ArrayList<>();
        for (Review r : reviews) {
            if (!r.getId().equals(id)) {
                lines.add(r.toString());
            }
        }
        FileService.writeAllLines(filePath, lines);
    }
}
