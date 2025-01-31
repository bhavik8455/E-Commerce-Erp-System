package model.admin;

import operations.adminalgo.*;


public class Algorithm_Pojo {
	
public String getsalestrendata(Algorithm_Pojo pojo) {
		
		Algorithm_Implement implement = new Algorithm_Implement();
		return implement.getsalestrendata(pojo);
	}
	
	public String getdemandforecastdata(Algorithm_Pojo pojo) {
		
		Algorithm_Implement implement = new Algorithm_Implement();
		return implement.getdemandforecastdata(pojo);
		
	}
	
	public String getabclassificationdata(Algorithm_Pojo pojo) {

		Algorithm_Implement implement = new Algorithm_Implement();
		return implement.getabclassificationdata(pojo);

	}

	public String getinventoryratio(Algorithm_Pojo pojo) {

		Algorithm_Implement implement = new Algorithm_Implement();
		return implement.getinvenotoryratio(pojo);

	}

	public String getproductprofitability(Algorithm_Pojo pojo) {

		Algorithm_Implement implement = new Algorithm_Implement();
		return implement.getproductprfotability(pojo);

}

}
