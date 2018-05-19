package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.ISmallChapterDao;
import com.imooc.entity.SmallChapter;
import com.imooc.service.SmallChapterService;

/*
 * @Service注解说明：
	@Service("smallChapterService")注解是告诉Spring，
	当Spring要创建SmallChapterServiceImpl的的实例时，
	bean的名字必须叫做"smallChapterService"，
	这样当Action需要使用SmallChapterServiceImpl的的实例时,
	就可以由Spring创建好的"smallChapterService"，然后注入给Action。
*/
@Service("smallChapterService") 
public class SmallChapterServiceImpl implements SmallChapterService {
	@Resource(name = "smallChapterDao")  
    private ISmallChapterDao smallChapterDao;
	
	// 通过小节id 获得一个小节表 对象
	@Override
	public SmallChapter getSmallChapter(int smallChapterId) {
		return smallChapterDao.getSmallChapter(smallChapterId);
	}

	// 查询所有的小节表的数据
	@Override
	public List<SmallChapter> selectAllSmallChapter() {
		return smallChapterDao.selectAllSmallChapter();
	}

	// 通过章节id查找   小节表的集合   
	@Override
	public List<SmallChapter> getAllSmallChapterByChapterId(int chapterId) {
		return smallChapterDao.getAllSmallChapterByChapterId(chapterId);
	}

	// 通过章节id和小节顺序(传入的还是小节id)   得到下一小节视频的小节记录 
	@Override
	public SmallChapter getNextSmallChapByChapIdAndSmallChapId(int chapterId, int smallChapterId){
		return smallChapterDao.getNextSmallChapByChapIdAndSmallChapId(chapterId, smallChapterId);
	}
	
	// 通过下一章节id(传入的还是小节id)+小节顺序为1   得到下一章节的第一节的小节记录
	@Override
	public SmallChapter getNextChapFirstSmallChapIdBySmallChapId(int smallChapterId){
		return smallChapterDao.getNextChapFirstSmallChapIdBySmallChapId(smallChapterId);
	}
	
	// 添加小节
	@Override
	public int addSmallChapter(SmallChapter smallChapter){
		return smallChapterDao.addSmallChapter(smallChapter);
	}
	
	// 通过小节id--删除小节
	@Override
	public int deleteSmallChapter(int smallChapterId){
		return smallChapterDao.deleteSmallChapter(smallChapterId);
	}
	
	// 通过章id--删除所有小节记录
	@Override
	public int deleteSmallChapterByChapterId(int chapterId){
		return smallChapterDao.deleteSmallChapterByChapterId(chapterId);
	}
	
	// 修改小节
	@Override
	public int updateSmallChapter(SmallChapter smallChapter){
		return smallChapterDao.updateSmallChapter(smallChapter);
	}

}
