package com.imooc.dto;

/**
 * 	个人信息封装类----->me-home.jsp用户主页页面显示数据
 */
public class MessageDto {
	
	// 我的学习时长
	private int learnTime;
	
	// 我的学习--课程个数
	private int courseNumber;
		
	// 我的收藏--课程个数
	private int collectNumber;
	
	// 我的提问--个数
	private int questionNumber;
	
	// 我的问答--个数
	private int replyNumber;
	
	// 我的笔记--个数
	private int noteNumber;
		
	// 我关注的--人数
	private int followsNumber;
	
	// 我的粉丝--人数
	private int fansNumber;

	public int getLearnTime() {
		return learnTime;
	}

	public void setLearnTime(int learnTime) {
		this.learnTime = learnTime;
	}

	public int getCourseNumber() {
		return courseNumber;
	}

	public void setCourseNumber(int courseNumber) {
		this.courseNumber = courseNumber;
	}

	public int getCollectNumber() {
		return collectNumber;
	}

	public void setCollectNumber(int collectNumber) {
		this.collectNumber = collectNumber;
	}

	public int getQuestionNumber() {
		return questionNumber;
	}

	public void setQuestionNumber(int questionNumber) {
		this.questionNumber = questionNumber;
	}

	public int getReplyNumber() {
		return replyNumber;
	}

	public void setReplyNumber(int replyNumber) {
		this.replyNumber = replyNumber;
	}

	public int getNoteNumber() {
		return noteNumber;
	}

	public void setNoteNumber(int noteNumber) {
		this.noteNumber = noteNumber;
	}

	public int getFollowsNumber() {
		return followsNumber;
	}

	public void setFollowsNumber(int followsNumber) {
		this.followsNumber = followsNumber;
	}

	public int getFansNumber() {
		return fansNumber;
	}

	public void setFansNumber(int fansNumber) {
		this.fansNumber = fansNumber;
	}

	@Override
	public String toString() {
		return "messageDto [learnTime=" + learnTime + ", courseNumber=" + courseNumber + ", collectNumber="
				+ collectNumber + ", questionNumber=" + questionNumber + ", replyNumber=" + replyNumber
				+ ", noteNumber=" + noteNumber + ", followsNumber=" + followsNumber + ", fansNumber=" + fansNumber
				+ "]";
	}
	
	
}
