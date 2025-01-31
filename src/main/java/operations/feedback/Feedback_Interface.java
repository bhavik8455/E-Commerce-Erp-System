package operations.feedback;

import java.util.List;
import model.FeedbackPojo;
import model.SalesPojo;

public interface Feedback_Interface {
    List<SalesPojo> getPurchasedProducts(int customerId);
    boolean submitFeedback(FeedbackPojo feedback);
}