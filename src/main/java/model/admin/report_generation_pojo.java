package model.admin;

import operations.adminreport.*;

public class report_generation_pojo {
	
	
	public String getsalestrendata(report_generation_pojo pojo) {
		
		Report_Generation_Implementation implement = new Report_Generation_Implementation();
		return implement.getsalestrendata(pojo);
	}
	
	public String getdemandforecastdata(report_generation_pojo pojo) {
		
		Report_Generation_Implementation implement = new Report_Generation_Implementation();
		return implement.getdemandforecastdata(pojo);
		
	}
	
	public String getabclassificationdata(report_generation_pojo pojo) {

		Report_Generation_Implementation implement = new Report_Generation_Implementation();
		return implement.getabclassificationdata(pojo);

	}

	public String getinventoryratio(report_generation_pojo pojo) {

		Report_Generation_Implementation implement = new Report_Generation_Implementation();
		return implement.getinvenotoryratio(pojo);

	}

	public String getproductprofitability(report_generation_pojo pojo) {

		Report_Generation_Implementation implement = new Report_Generation_Implementation();
		return implement.getproductprfotability(pojo);

}
	
}
