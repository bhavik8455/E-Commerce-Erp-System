package operations.adminreport;

import model.admin.report_generation_pojo;

public interface Report_Generation {
	
	String getsalestrendata(report_generation_pojo pojo);
	String getdemandforecastdata(report_generation_pojo pojo );
	String getabclassificationdata(report_generation_pojo pojo );
	String getinvenotoryratio(report_generation_pojo pojo );
	String getproductprfotability(report_generation_pojo pojo );

}
