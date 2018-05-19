package com.imooc.entity;

import java.sql.Timestamp;

// 评论表 
public class Comments {
	private int commentsId;				// 评论id
	
	private String userId;				// 用户id
	
	private int courseId;				// 课程id
	
	private int smallChapterId;			// 小节id
	
	private String commentsContent;		// 评论内容
	
	private Timestamp commentsTime;		// 评论时间
	
	private int commentsThumbsNumber;	// 点赞量
	
	private User user;					// 用户对象
	
	private SmallChapter smallChapter;	// 小节列表对象

	private Chapter chapter;			// 章节列表对象
	
	public int getCommentsId() {
		return commentsId;
	}

	public void setCommentsId(int commentsId) {
		this.commentsId = commentsId;
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

	public String getCommentsContent() {
		return commentsContent;
	}

	public void setCommentsContent(String commentsContent) {
		this.commentsContent = commentsContent;
	}

	public Timestamp getCommentsTime() {
		return commentsTime;
	}

	public void setCommentsTime(Timestamp commentsTime) {
		this.commentsTime = commentsTime;
	}

	public int getCommentsThumbsNumber() {
		return commentsThumbsNumber;
	}

	public void setCommentsThumbsNumber(int commentsThumbsNumber) {
		this.commentsThumbsNumber = commentsThumbsNumber;
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
		return "Comments [commentsId=" + commentsId + ", userId=" + userId + ", courseId=" + courseId
				+ ", smallChapterId=" + smallChapterId + ", commentsContent=" + commentsContent + ", commentsTime="
				+ commentsTime + ", commentsThumbsNumber=" + commentsThumbsNumber + ", user=" + user + ", smallChapter="
				+ smallChapter + ", chapter=" + chapter + "]\n";
	}

}
