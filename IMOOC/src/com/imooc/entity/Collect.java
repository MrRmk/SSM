package com.imooc.entity;

import java.sql.Timestamp;

/**
 * 收藏表
 */
public class Collect {
	
	private int collectId;				// 收藏id
	
	private String userId;				// 用户id
	
	private int courseId;				// 课程id
	
	private String courseName;			// 课程名
	
	private Timestamp collectTime;		// 收藏时间
	
	private int classId;				// 二级分类id
	
	private String classCode;			// 二级分类编码
	
	private String className;			// 二级分类名字

	public int getCollectId() {
		return collectId;
	}

	public void setCollectId(int collectId) {
		this.collectId = collectId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public Timestamp getCollectTime() {
		return collectTime;
	}

	public void setCollectTime(Timestamp collectTime) {
		this.collectTime = collectTime;
	}

	public int getClassId() {
		return classId;
	}

	public void setClassId(int classId) {
		this.classId = classId;
	}

	public String getClassCode() {
		return classCode;
	}

	public void setClassCode(String classCode) {
		this.classCode = classCode;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	@Override
	public String toString() {
		return "Collect [collectId=" + collectId + ", userId=" + userId + ", courseId=" + courseId + ", courseName="
				+ courseName + ", collectTime=" + collectTime + ", classId=" + classId + ", classCode=" + classCode
				+ ", className=" + className + "]";
	}
	
}
