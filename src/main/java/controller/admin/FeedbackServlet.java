package controller.admin;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.admin.FeedbackPojo;
@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<FeedbackPojo> feedbackList = FeedbackPojo.getAllFeedback();
        req.setAttribute("feedbackList", feedbackList);
        req.getRequestDispatcher("feedback2.jsp").forward(req, resp);
    }
}