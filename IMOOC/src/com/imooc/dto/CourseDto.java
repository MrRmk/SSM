package com.imooc.dto;

import com.imooc.entity.Course;
import com.imooc.entity.SortsOne;
import com.imooc.entity.SortsTwo;

/**
 * 	课程表封装类----->用户页面显示数据
 */
public class CourseDto {
	// 课程表封装类id
	private int courseDtoId;
	
	// 一级分类id
	private int oneId;
	
	// 一级分类名字
	private String oneName;
	
	// 二级分类名字
	private String sortsTwoName;
	
	// 课程对象
	private Course course;
	
	// 讲师
	private String teacher;
	
	// 课程学习人数
	private int number;
	
	// 一级分类对象
	private SortsOne sortsOne;	
	
	// 二级分类对象
	private SortsTwo sortsTwo;

	public int getCourseDtoId() {
		return courseDtoId;
	}

	public void setCourseDtoId(int courseDtoId) {
		this.courseDtoId = courseDtoId;
	}

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

	public String getSortsTwoName() {
		return sortsTwoName;
	}

	public void setSortsTwoName(String sortsTwoName) {
		this.sortsTwoName = sortsTwoName;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public SortsOne getSortsOne() {
		return sortsOne;
	}

	public void setSortsOne(SortsOne sortsOne) {
		this.sortsOne = sortsOne;
	}

	public SortsTwo getSortsTwo() {
		return sortsTwo;
	}

	public void setSortsTwo(SortsTwo sortsTwo) {
		this.sortsTwo = sortsTwo;
	}

	@Override
	public String toString() {
		return "CourseDto [courseDtoId=" + courseDtoId + ", oneId=" + oneId + ", oneName=" + oneName + ", sortsTwoName="
				+ sortsTwoName + ", course=" + course + ", teacher=" + teacher + ", number=" + number + ", sortsOne="
				+ sortsOne + ", sortsTwo=" + sortsTwo + "]";
	}


}
