package com.imooc.entity;

import java.util.List;

import org.springframework.stereotype.Component;

import com.imooc.dto.CourseDto;
@Component
public class Page {
	
	private String sql;
	private int size;		//每页显示的条数
	private int totalSize;	//总条数
	private int page;		//当前页
	private int totalPage;	//总页数
	
	private List<Question> questionList;	// 猿问分页的list
	private List<Note> noteList; 			// 手记分页的list
	private List<User> userList; 			// 用户分页的list
	private List<Course> CourseList; 		// 课程分页的list
	private List<CourseDto> courseDtoList; 	// 课程分页的list

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public int getTotalSize() {
		return totalSize;
	}

	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public List<Question> getQuestionList() {
		return questionList;
	}

	public void setQuestionList(List<Question> questionList) {
		this.questionList = questionList;
	}

	public List<Note> getNoteList() {
		return noteList;
	}

	public void setNoteList(List<Note> noteList) {
		this.noteList = noteList;
	}

	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	public List<Course> getCourseList() {
		return CourseList;
	}

	public void setCourseList(List<Course> courseList) {
		CourseList = courseList;
	}

	public List<CourseDto> getCourseDtoList() {
		return courseDtoList;
	}

	public void setCourseDtoList(List<CourseDto> courseDtoList) {
		this.courseDtoList = courseDtoList;
	}

	@Override
	public String toString() {
		return "Page [sql=" + sql + ", size=" + size + ", totalSize=" + totalSize + ", page=" + page + ", totalPage="
				+ totalPage + ", questionList=" + questionList + ", noteList=" + noteList + ", userList=" + userList
				+ ", CourseList=" + CourseList + ", courseDtoList=" + courseDtoList + "]";
	}

	
}
