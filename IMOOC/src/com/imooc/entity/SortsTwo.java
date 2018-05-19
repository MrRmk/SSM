package com.imooc.entity;

// 课程二级方向表
public class SortsTwo {
	private int twoId;			//二级分类id
	
    private String twoName;  	//二级分类名字
    
    private String twoCode;  	//二级分类编码
    
    private int oneId;			//一级分类id
    
    private SortsOne sortsOne;	//一级分类对象

	public int getTwoId() {
		return twoId;
	}

	public void setTwoId(int twoId) {
		this.twoId = twoId;
	}

	public String getTwoName() {
		return twoName;
	}

	public void setTwoName(String twoName) {
		this.twoName = twoName;
	}

	public String getTwoCode() {
		return twoCode;
	}

	public void setTwoCode(String twoCode) {
		this.twoCode = twoCode;
	}

	public int getOneId() {
		return oneId;
	}

	public void setOneId(int oneId) {
		this.oneId = oneId;
	}

	public SortsOne getSortsOne() {
		return sortsOne;
	}

	public void setSortsOne(SortsOne sortsOne) {
		this.sortsOne = sortsOne;
	}

	@Override
	public String toString() {
		return "SortsTwo [twoId=" + twoId + ", twoName=" + twoName + ", twoCode=" + twoCode + ", oneId=" + oneId
				+ ", sortsOne=" + sortsOne + "]";
	}

}
