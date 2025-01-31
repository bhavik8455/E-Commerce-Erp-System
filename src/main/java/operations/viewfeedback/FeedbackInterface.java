package operations.viewfeedback;

import java.util.List;
import model.FeedbackPojo;

public interface FeedbackInterface {
    List<FeedbackPojo> getFeedbacksByCustomerId(int customerId);
    boolean updateFeedback(int feedbackId, String comments, int ratings);
    boolean deleteFeedback(int feedbackId);
}