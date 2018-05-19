package com.imooc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.imooc.entity.SmallChapter;

/*
	@Repository(value="smallChapterDao")注解是告诉Spring，
	让Spring创建一个名字叫“smallChapterDao”的SmallChapterServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“smallChapterDao”的SmallChapterServiceImpl实例时，
	就可以使用@Resource(name = "smallChapterDao")注解告诉Spring，
	Spring把创建好的smallChapterDao注入给Service即可。
*/
@Repository("smallChapterDao")  
public interface ISmallChapterDao {
	
	// 通过小节id 获得一个小节表 对象
	public SmallChapter getSmallChapter(int smallChapterId);
	
	// 查询所有的小节表的数据
	public List<SmallChapter> selectAllSmallChapter();
	
	// 通过章节id查找   小节表的集合   
	public List<SmallChapter> getAllSmallChapterByChapterId(int chapterId);
	
	// 通过章节id和小节顺序(传入的还是小节id)   得到下一小节视频的小节记录 
	public SmallChapter getNextSmallChapByChapIdAndSmallChapId(@Param("chapterId")int chapterId, @Param("smallChapterId")int smallChapterId);
	
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
