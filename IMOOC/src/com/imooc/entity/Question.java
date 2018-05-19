package com.imooc.entity;

import java.sql.Timestamp;

// 提问表
public class Question {
	private int questionId;				// 提问id
	
	private String userId;				// 用户id
	
	private int courseId;				// 课程id
	
	private int smallChapterId;			// 小节id
	
	private String questionTitle;		// 问题标题
	
	private String questionContent;		// 问题内容
	
	private Timestamp questionTime;		// 提问时间
	
	private int questionReplyNumber;	// 回答量
	
	private int questionScanNumber;		// 浏览量
	
	private User user;					// 用户对象
	
	private SmallChapter smallChapter;	// 小节列表对象
	
	private Chapter chapter;			// 章节列表对象

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
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

	public int getSmallChapterId() {
		return smallChapterId;
	}

	public void setSmallChapterId(int smallChapterId) {
		this.smallChapterId = smallChapterId;
	}

	public String getQuestionTitle() {
		return questionTitle;
	}

	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public Timestamp getQuestionTime() {
		return questionTime;
	}

	public void setQuestionTime(Timestamp questionTime) {
		this.questionTime = questionTime;
	}

	public int getQuestionReplyNumber() {
		return questionReplyNumber;
	}

	public void setQuestionReplyNumber(int questionReplyNumber) {
		this.questionReplyNumber = questionReplyNumber;
	}

	public int getQuestionScanNumber() {
		return questionScanNumber;
	}

	public void setQuestionScanNumber(int questionScanNumber) {
		this.questionScanNumber = questionScanNumber;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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

	@Override
	public String toString() {
		return "Question [questionId=" + questionId + ", userId=" + userId + ", courseId=" + courseId
				+ ", smallChapterId=" + smallChapterId + ", questionTitle=" + questionTitle + ", questionContent="
				+ questionContent + ", questionTime=" + questionTime + ", questionReplyNumber=" + questionReplyNumber
				+ ", questionScanNumber=" + questionScanNumber + ", user=" + user + ", smallChapter=" + smallChapter
				+ ", chapter=" + chapter + "]";
	}

	
}
