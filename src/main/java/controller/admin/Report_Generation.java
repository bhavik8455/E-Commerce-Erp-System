package controller.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.admin.report_generation_pojo;

import java.io.IOException;

/**
 * Servlet implementation class Report_Generation
 */
@WebServlet("/Report_Generation")
public class Report_Generation extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		report_generation_pojo pojo = new report_generation_pojo();
	     
	     
	     
	     String salesTrendData = pojo.getsalestrendata(pojo);
	     request.setAttribute("salesTrendData", salesTrendData);
	     
	     String abc_classificationData = pojo.getabclassificationdata(pojo);
	     request.setAttribute("abc_classificationData", abc_classificationData);
	     
	     String demandForecast = pojo.getdemandforecastdata(pojo);
	     System.out.println(demandForecast);
	     request.setAttribute("demandForecast", demandForecast);
	     
	     String inventoryratio = pojo.getinventoryratio(pojo);
	     request.setAttribute("inventoryratio", inventoryratio);
	     
	     String profitability = pojo.getproductprofitability(pojo);
	     System.out.println(profitability);
	     request.setAttribute("profitability", profitability);
	     
	     request.getRequestDispatcher("report.jsp").forward(request, response);
	}

}
