package com.imooc.entity;

//课程表
public class Course {
	private int courseId;			//账号
	
    private int twoId;  			//二级分类id	
    
    private String courseName;  	//课程名
    	
    private String courseSummary;	//课程简介
    
    private String courseGrade;  	//难度级别	
    
    private int courseTotalTime;  	//课程总时长
    
    private int courseIsProject;	//是否实战  0:否，1:是
    	
    private int coursePrice;		//价格 (实战时才有价格，不是实战价格为0)
    
    private String userId;			//讲师
    
    private int courseStatus;		//课程状态(0:未在架; 1:在架)

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public int getTwoId() {
		return twoId;
	}

	public void setTwoId(int twoId) {
		this.twoId = twoId;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCourseSummary() {
		return courseSummary;
	}

	public void setCourseSummary(String courseSummary) {
		this.courseSummary = courseSummary;
	}

	public String getCourseGrade() {
		return courseGrade;
	}

	public void setCourseGrade(String courseGrade) {
		this.courseGrade = courseGrade;
	}

	public int getCourseTotalTime() {
		return courseTotalTime;
	}

	public void setCourseTotalTime(int courseTotalTime) {
		this.courseTotalTime = courseTotalTime;
	}

	public int getCourseIsProject() {
		return courseIsProject;
	}

	public void setCourseIsProject(int courseIsProject) {
		this.courseIsProject = courseIsProject;
	}

	public int getCoursePrice() {
		return coursePrice;
	}

	public void setCoursePrice(int coursePrice) {
		this.coursePrice = coursePrice;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public int getCourseStatus() {
		return courseStatus;
	}

	public void setCourseStatus(int courseStatus) {
		this.courseStatus = courseStatus;
	}

	@Override
	public String toString() {
		return "Course [courseId=" + courseId + ", twoId=" + twoId + ", courseName=" + courseName + ", courseSummary="
				+ courseSummary + ", courseGrade=" + courseGrade + ", courseTotalTime=" + courseTotalTime
				+ ", courseIsProject=" + courseIsProject + ", coursePrice=" + coursePrice + ", userId=" + userId
				+ ", courseStatus=" + courseStatus + "]";
	}
	
    
}
