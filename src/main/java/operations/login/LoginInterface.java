package operations.login;

import model.LoginPojo;

public interface LoginInterface {
	
	String loginuser(LoginPojo pojo);

	String adminuser(LoginPojo pojo);
	
	int getCustomerID( String MailID);

}
