package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.IChapterDao;
import com.imooc.entity.Chapter;
import com.imooc.service.ChapterService;


/*
 * @Service注解说明：
	@Service("chapterService")注解是告诉Spring，
	当Spring要创建ChapterServiceImpl的的实例时，
	bean的名字必须叫做"chapterService"，
	这样当Action需要使用ChapterServiceImpl的的实例时,
	就可以由Spring创建好的"chapterService"，然后注入给Action。
*/
@Service("chapterService")  
public class ChapterServiceImpl implements ChapterService{  
  
    @Resource(name = "chapterDao")  
    private IChapterDao chapterDao;

    // 通过章节id 获得一个章节表 对象
	@Override
	public Chapter getChapter(int chapterId) {
		return chapterDao.getChapter(chapterId);
	}

	// 查询所有的章节表的数据
	@Override
	public List<Chapter> selectAllChapter() {
		return chapterDao.selectAllChapter();
	}

	// 通过课程id查找   章节表的集合 
	@Override
	public List<Chapter> getAllChapterByCourseId(int courseId) {
		return chapterDao.getAllChapterByCourseId(courseId);
	}

	// 通过课程id查找  包含小节列表的  章节表的数据
	@Override
	public List<Chapter> getChapterAndSmallChapter(int courseId) {
		return chapterDao.getChapterAndSmallChapter(courseId);
	}

	// 添加章节
	@Override
	public int addChapter(Chapter chapter){
		return chapterDao.addChapter(chapter);
	}
	
	// 删除章节
	@Override
	public int deleteChapter(int chapterId){
		return chapterDao.deleteChapter(chapterId);
	}
	
	// 修改章节
	@Override
	public int updateChapter(Chapter chapter){
		return chapterDao.updateChapter(chapter);
	}
} 