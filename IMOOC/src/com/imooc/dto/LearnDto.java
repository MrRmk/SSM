package com.imooc.dto;


/**
 * 	学习记录表封装类----->用户页面显示数据
 */
public class LearnDto {
	
	private int learnId;		// 学习记录表id
	
	private String userId;		// 用户id
	
	private int courseId;		// 课程id
	
	private int smallChapterId;	// 小节id
	
	private int learnStatus;	// 学习状态  0:正在学习,1:完成学习
	
	private int smallChapterOrder; 		//小节顺序
	
	private int chapterId;			//章节id
	
	private int chapterOrder; 		//章节顺序

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

	public int getSmallChapterId() {
		return smallChapterId;
	}

	public void setSmallChapterId(int smallChapterId) {
		this.smallChapterId = smallChapterId;
	}

	public int getLearnStatus() {
		return learnStatus;
	}

	public void setLearnStatus(int learnStatus) {
		this.learnStatus = learnStatus;
	}

	public int getSmallChapterOrder() {
		return smallChapterOrder;
	}

	public void setSmallChapterOrder(int smallChapterOrder) {
		this.smallChapterOrder = smallChapterOrder;
	}

	public int getChapterId() {
		return chapterId;
	}

	public void setChapterId(int chapterId) {
		this.chapterId = chapterId;
	}

	public int getChapterOrder() {
		return chapterOrder;
	}

	public void setChapterOrder(int chapterOrder) {
		this.chapterOrder = chapterOrder;
	}

	@Override
	public String toString() {
		return "LearnDto [learnId=" + learnId + ", userId=" + userId + ", courseId=" + courseId + ", smallChapterId="
				+ smallChapterId + ", learnStatus=" + learnStatus + ", smallChapterOrder=" + smallChapterOrder
				+ ", chapterId=" + chapterId + ", chapterOrder=" + chapterOrder + "]";
	}
	
}
