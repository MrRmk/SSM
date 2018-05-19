package com.imooc.entity;

// 管理员表
public class Manager {
	private String managerAccount;		//账号
	
    private String managerName;  		//姓名	
    
    private String managerPassword;  	//密码
    	
    private String managerSex;			//性别  

	public String getManagerAccount() {
		return managerAccount;
	}

	public void setManagerAccount(String managerAccount) {
		this.managerAccount = managerAccount;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getManagerPassword() {
		return managerPassword;
	}

	public void setManagerPassword(String managerPassword) {
		this.managerPassword = managerPassword;
	}

	public String getManagerSex() {
		return managerSex;
	}

	public void setManagerSex(String managerSex) {
		this.managerSex = managerSex;
	}

	@Override
	public String toString() {
		return "Manager [managerAccount=" + managerAccount + ", managerName=" + managerName + ", managerPassword="
				+ managerPassword + ", managerSex=" + managerSex + "]";
	}

	
}
