package com.imooc.entity;

import java.util.List;

// 章节表
public class Chapter {
	private int chapterId;			//章节id
	
	private int courseId;			//课程id
	
	private int chapterOrder; 		//章节顺序
	
	private String chapterTitle;	//章节标题
	
	private List<SmallChapter> smallChapterList;	//小节对象

	public int getChapterId() {
		return chapterId;
	}

	public void setChapterId(int chapterId) {
		this.chapterId = chapterId;
	}

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public int getChapterOrder() {
		return chapterOrder;
	}

	public void setChapterOrder(int chapterOrder) {
		this.chapterOrder = chapterOrder;
	}

	public String getChapterTitle() {
		return chapterTitle;
	}

	public void setChapterTitle(String chapterTitle) {
		this.chapterTitle = chapterTitle;
	}

	public List<SmallChapter> getSmallChapterList() {
		return smallChapterList;
	}

	public void setSmallChapterList(List<SmallChapter> smallChapterList) {
		this.smallChapterList = smallChapterList;
	}

	@Override
	public String toString() {
		return "Chapter [chapterId=" + chapterId + ", courseId=" + courseId + ", chapterOrder=" + chapterOrder
				+ ", chapterTitle=" + chapterTitle + ", smallChapterList=" + smallChapterList + "]";
	}

	
}
