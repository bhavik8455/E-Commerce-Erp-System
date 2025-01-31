package model.admin;

import operations.admindash.*;

public class Admin_Dashoboard_Pojo {

	//	private String jsonResult;
	//
	//	public String getJsonResult() {
	//		return jsonResult;
	//	}
	//
	//	public void setJsonResult(String jsonResult) {
	//		this.jsonResult = jsonResult;
	//	}

	public String getsalestrendata(Admin_Dashoboard_Pojo pojo) {

		Admin_Dashboard_Operations_Implement implement = new Admin_Dashboard_Operations_Implement();
		return implement.getsalestrendata(pojo);
	}

	public String getdemandforecastdata(Admin_Dashoboard_Pojo pojo) {

		Admin_Dashboard_Operations_Implement implement = new Admin_Dashboard_Operations_Implement();
		return implement.getdemandforecastdata(pojo);

	}

	public String getabclassificationdata(Admin_Dashoboard_Pojo pojo) {

		Admin_Dashboard_Operations_Implement implement = new Admin_Dashboard_Operations_Implement();
		return implement.getabclassificationdata(pojo);

	}

	public String getinventoryratio(Admin_Dashoboard_Pojo pojo) {

		Admin_Dashboard_Operations_Implement implement = new Admin_Dashboard_Operations_Implement();
		return implement.getinvenotoryratio(pojo);

	}

	public String getproductprofitability(Admin_Dashoboard_Pojo pojo) {

		Admin_Dashboard_Operations_Implement implement = new Admin_Dashboard_Operations_Implement();
		return implement.getproductprfotability(pojo);

	}

	public int gettoalrevenue(Admin_Dashoboard_Pojo pojo) {

		Admin_Dashboard_Operations_Implement implement = new Admin_Dashboard_Operations_Implement();
		return implement.gettotalrevenue(pojo);

	}
	
	public int gettoalusers(Admin_Dashoboard_Pojo pojo) {

		Admin_Dashboard_Operations_Implement implement = new Admin_Dashboard_Operations_Implement();
		return implement.gettotalusers(pojo);

	}
	
	public int gettoalproducts(Admin_Dashoboard_Pojo pojo) {

		Admin_Dashboard_Operations_Implement implement = new Admin_Dashboard_Operations_Implement();
		return implement.gettotalproducts(pojo);

	}


}

