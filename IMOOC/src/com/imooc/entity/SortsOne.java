package com.imooc.entity;

// 课程一级方向表
public class SortsOne {
	private int oneId;			//一级分类id
	
    private String oneName;  	//一级分类名字
    
    private String oneCode;  	//一级分类编码

	public int getOneId() {
		return oneId;
	}

	public void setOneId(int oneId) {
		this.oneId = oneId;
	}

	public String getOneName() {
		return oneName;
	}

	public void setOneName(String oneName) {
		this.oneName = oneName;
	}

	public String getOneCode() {
		return oneCode;
	}

	public void setOneCode(String oneCode) {
		this.oneCode = oneCode;
	}

	@Override
	public String toString() {
		return "CourseSortsOne [oneId=" + oneId + ", oneName=" + oneName + ", oneCode=" + oneCode + "]";
	}
  
    
}
