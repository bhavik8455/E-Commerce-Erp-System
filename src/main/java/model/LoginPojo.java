package model;

import operations.login.LoginImplementation;

public class LoginPojo {
	

	private String pname;
	private String pword;
	private String role;
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPword() {
		return pword;
	}
	public void setPword(String pword) {
		this.pword = pword;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	public String loginuser(LoginPojo pojo) {
		 LoginImplementation login_op_implement = new LoginImplementation();
		 try {
			return login_op_implement.loginuser(pojo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "Error during Authetication";
		}
	}


	public String adminuser(LoginPojo pojo) {
		LoginImplementation login_op_implement = new LoginImplementation();
		 try {
			return login_op_implement.adminuser(pojo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "Error during Authetication";
		}
	}
		 
		 public int getCustomerID(String MailID) {
			 LoginImplementation implementation = new LoginImplementation();
				return implementation.getCustomerID(MailID);
			
		 
	}

}
