package operations.adminalgo;


import model.admin.Algorithm_Pojo;

public interface Algorithms {
	
	String getsalestrendata(Algorithm_Pojo pojo);
	String getdemandforecastdata(Algorithm_Pojo pojo);
	String getabclassificationdata(Algorithm_Pojo pojo);
	String getinvenotoryratio(Algorithm_Pojo pojo);
	String getproductprfotability(Algorithm_Pojo pojo);

}
