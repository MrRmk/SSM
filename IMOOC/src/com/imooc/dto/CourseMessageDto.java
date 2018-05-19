package com.imooc.dto;

public class CourseMessageDto {
	
	// 该课程的评论数量
	private int commentsNumber;
	
	// 该课程的问题数量
	private int questionNumber;
	
	// 该课程的回答数量
	private int replyNumber;
	
	// 该课程的笔记数量
	private int noteNumber;

	public int getCommentsNumber() {
		return commentsNumber;
	}

	public void setCommentsNumber(int commentsNumber) {
		this.commentsNumber = commentsNumber;
	}

	public int getQuestionNumber() {
		return questionNumber;
	}

	public void setQuestionNumber(int questionNumber) {
		this.questionNumber = questionNumber;
	}

	public int getNoteNumber() {
		return noteNumber;
	}

	public void setNoteNumber(int noteNumber) {
		this.noteNumber = noteNumber;
	}

	public int getReplyNumber() {
		return replyNumber;
	}

	public void setReplyNumber(int replyNumber) {
		this.replyNumber = replyNumber;
	}

	@Override
	public String toString() {
		return "CourseMessageDto [commentsNumber=" + commentsNumber + ", questionNumber=" + questionNumber
				+ ", replyNumber=" + replyNumber + ", noteNumber=" + noteNumber + "]";
	}
	
	
}
