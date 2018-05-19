package com.imooc.entity;

import java.sql.Timestamp;

// 回复表
public class Reply {
	private int replyId;				// 回复id
	
	private String userId;				// 用户id
	
	private int questionId;				// 问题表id
	
	private String replyContent;		// 回复内容
	
	private Timestamp replyTime;		// 回复时间
	
	private int replyAgreeNumber;		// 赞成量

	private int replyAgainstNumber;		// 反对量
	
	private User user;					// 用户对象

	public int getReplyId() {
		return replyId;
	}

	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Timestamp getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Timestamp replyTime) {
		this.replyTime = replyTime;
	}

	public int getReplyAgreeNumber() {
		return replyAgreeNumber;
	}

	public void setReplyAgreeNumber(int replyAgreeNumber) {
		this.replyAgreeNumber = replyAgreeNumber;
	}

	public int getReplyAgainstNumber() {
		return replyAgainstNumber;
	}

	public void setReplyAgainstNumber(int replyAgainstNumber) {
		this.replyAgainstNumber = replyAgainstNumber;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Reply [replyId=" + replyId + ", userId=" + userId + ", questionId=" + questionId + ", replyContent="
				+ replyContent + ", replyTime=" + replyTime + ", replyAgreeNumber=" + replyAgreeNumber
				+ ", replyAgainstNumber=" + replyAgainstNumber + ", user=" + user + "]";
	}
	
}
