package com.imooc.service;

import java.util.List;


import com.imooc.entity.SmallChapter;

public interface SmallChapterService {
	
	// 通过小节id 获得一个小节表 对象
	public SmallChapter getSmallChapter(int smallChapterId);
	
	// 查询所有的小节表的数据
	public List<SmallChapter> selectAllSmallChapter();
	
	// 通过章节id查找   小节表的集合   
	public List<SmallChapter> getAllSmallChapterByChapterId(int chapterId);
	
	// 通过章节id和小节顺序(传入的还是小节id)   得到下一小节视频的小节记录 
	public SmallChapter getNextSmallChapByChapIdAndSmallChapId(int chapterId, int smallChapterId);
		
	// 通过下一章节id(传入的还是小节id)+小节顺序为1   得到下一章节的第一节的小节记录
	public SmallChapter getNextChapFirstSmallChapIdBySmallChapId(int smallChapterId);
	
	// 添加小节
	public int addSmallChapter(SmallChapter smallChapter);
	
	// 通过小节id--删除小节
	public int deleteSmallChapter(int smallChapterId);
	
	// 通过章id--删除所有小节记录
	public int deleteSmallChapterByChapterId(int chapterId);
	
	// 修改小节
	public int updateSmallChapter(SmallChapter smallChapter);
}
