package com.imooc.entity;

// 课程小节表
public class SmallChapter {
	private int smallChapterId;			//小节id
	
	private int chapterId;				//章节id
	
	private int smallChapterOrder; 		//小节顺序
	
	private String smallChapterTitle;	//小节名称
	
	private String videoPath;			//视频路径
	
	private String videoTotalTime;		//视频总时长(字符串：如: 12:30)
	
	private int videoTotalTimeSecond;	//视频总时长(秒)

	public int getSmallChapterId() {
		return smallChapterId;
	}

	public void setSmallChapterId(int smallChapterId) {
		this.smallChapterId = smallChapterId;
	}

	public int getChapterId() {
		return chapterId;
	}

	public void setChapterId(int chapterId) {
		this.chapterId = chapterId;
	}

	public int getSmallChapterOrder() {
		return smallChapterOrder;
	}

	public void setSmallChapterOrder(int smallChapterOrder) {
		this.smallChapterOrder = smallChapterOrder;
	}

	public String getSmallChapterTitle() {
		return smallChapterTitle;
	}

	public void setSmallChapterTitle(String smallChapterTitle) {
		this.smallChapterTitle = smallChapterTitle;
	}

	public String getVideoPath() {
		return videoPath;
	}

	public void setVideoPath(String videoPath) {
		this.videoPath = videoPath;
	}

	
	public String getVideoTotalTime() {
		return videoTotalTime;
	}

	public void setVideoTotalTime(String videoTotalTime) {
		this.videoTotalTime = videoTotalTime;
	}

	public int getVideoTotalTimeSecond() {
		return videoTotalTimeSecond;
	}

	public void setVideoTotalTimeSecond(int videoTotalTimeSecond) {
		this.videoTotalTimeSecond = videoTotalTimeSecond;
	}

	@Override
	public String toString() {
		return "SmallChapter [smallChapterId=" + smallChapterId + ", chapterId=" + chapterId + ", smallChapterOrder="
				+ smallChapterOrder + ", smallChapterTitle=" + smallChapterTitle + ", videoPath=" + videoPath
				+ ", videoTotalTime=" + videoTotalTime + ", videoTotalTimeSecond=" + videoTotalTimeSecond + "]";
	}

}
