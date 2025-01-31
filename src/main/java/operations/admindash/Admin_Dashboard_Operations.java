package operations.admindash;

import model.admin.Admin_Dashoboard_Pojo;

public interface Admin_Dashboard_Operations {
	
	String getsalestrendata(Admin_Dashoboard_Pojo pojo);
	String getdemandforecastdata(Admin_Dashoboard_Pojo pojo);
	String getabclassificationdata(Admin_Dashoboard_Pojo pojo);
	String getinvenotoryratio(Admin_Dashoboard_Pojo pojo);
	String getproductprfotability(Admin_Dashoboard_Pojo pojo);
	int gettotalrevenue(Admin_Dashoboard_Pojo pojo);
	int gettotalusers(Admin_Dashoboard_Pojo pojo);
	int gettotalproducts(Admin_Dashoboard_Pojo pojo);

}
