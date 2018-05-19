package com.imooc.entity;

import java.sql.Timestamp;

// 笔记表
public class Note {
	private int noteId;					// 笔记id
	
	private String userId;				// 用户id
	
	private int courseId;				// 课程id
	
	private int smallChapterId;			// 小节id
	
	private String noteTitle;			// 笔记标题
	
	private String noteContent;			// 笔记内容
	
	private Timestamp noteTime;			// 笔记时间
	
	private int noteThumbsNumber;		// 点赞量
	
	private User user;					// 用户对象
	
	private SmallChapter smallChapter;	// 小节列表对象
	
	private Chapter chapter;			// 章节列表对象

	public int getNoteId() {
		return noteId;
	}

	public void setNoteId(int noteId) {
		this.noteId = noteId;
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

	public String getNoteTitle() {
		return noteTitle;
	}

	public void setNoteTitle(String noteTitle) {
		this.noteTitle = noteTitle;
	}

	public String getNoteContent() {
		return noteContent;
	}

	public void setNoteContent(String noteContent) {
		this.noteContent = noteContent;
	}

	public Timestamp getNoteTime() {
		return noteTime;
	}

	public void setNoteTime(Timestamp noteTime) {
		this.noteTime = noteTime;
	}

	public int getNoteThumbsNumber() {
		return noteThumbsNumber;
	}

	public void setNoteThumbsNumber(int noteThumbsNumber) {
		this.noteThumbsNumber = noteThumbsNumber;
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
		return "Note [noteId=" + noteId + ", userId=" + userId + ", courseId=" + courseId + ", smallChapterId="
				+ smallChapterId + ", noteTitle=" + noteTitle + ", noteContent=" + noteContent + ", noteTime="
				+ noteTime + ", noteThumbsNumber=" + noteThumbsNumber + ", user=" + user + ", smallChapter="
				+ smallChapter + ", chapter=" + chapter + "]";
	}

	
}
