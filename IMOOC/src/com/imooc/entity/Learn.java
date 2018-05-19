package com.imooc.entity;

import java.sql.Timestamp;

// 课程学习记录表
public class Learn {
	private int learnId;		// 学习记录表id
	
	private String userId;		// 用户id
	
	private int courseId;		// 课程id
	
	private int chapterId;		//章节id
	
	private int smallChapterId;	// 小节id
	
	private Timestamp learnTime;// 学习时间
	
	private int learnStatus;	// 学习状态  0:正在学习,1:完成学习
	
	private int learnUseTime;	// 学习用时(记录用户已经观看该小节的用时)
	
	private SmallChapter smallChapter;	// 小节对象
	
	private Chapter chapter;	// 章节对象
	
	private Course course;		// 课程对象
	
	private User user;			// 用户对象
	
	public int getLearnId() {
		return learnId;
	}

	public void setLearnId(int learnId) {
		this.learnId = learnId;
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

	public int getChapterId() {
		return chapterId;
	}

	public void setChapterId(int chapterId) {
		this.chapterId = chapterId;
	}

	public int getSmallChapterId() {
		return smallChapterId;
	}

	public void setSmallChapterId(int smallChapterId) {
		this.smallChapterId = smallChapterId;
	}

	public Timestamp getLearnTime() {
		return learnTime;
	}

	public void setLearnTime(Timestamp learnTime) {
		this.learnTime = learnTime;
	}

	public int getLearnStatus() {
		return learnStatus;
	}

	public void setLearnStatus(int learnStatus) {
		this.learnStatus = learnStatus;
	}

	public int getLearnUseTime() {
		return learnUseTime;
	}

	public void setLearnUseTime(int learnUseTime) {
		this.learnUseTime = learnUseTime;
	}

	public SmallChapter getSmallChapter() {
		return smallChapter;
	}

	public void setSmallChapter(SmallChapter smallChapter) {
		this.smallChapter = smallChapter;
	}

	public Chapter getChapter() {
		return chapter;
	}

	public void setChapter(Chapter chapter) {
		this.chapter = chapter;
	}

	public Course getCourse() {
		return course;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Learn [learnId=" + learnId + ", userId=" + userId + ", courseId=" + courseId + ", chapterId="
				+ chapterId + ", smallChapterId=" + smallChapterId + ", learnTime=" + learnTime + ", learnStatus="
				+ learnStatus + ", learnUseTime=" + learnUseTime + ", smallChapter=" + smallChapter + ", chapter="
				+ chapter + ", course=" + course + ", user=" + user + "]";
	}

}
