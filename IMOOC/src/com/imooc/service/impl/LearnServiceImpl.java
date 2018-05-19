package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.ILearnDao;
import com.imooc.entity.Learn;
import com.imooc.service.LearnService;


/*
 * @Service注解说明：
	@Service("learnService")注解是告诉Spring，
	当Spring要创建LearnServiceImpl的的实例时，
	bean的名字必须叫做"learnService"，
	这样当Action需要使用LearnServiceImpl的的实例时,
	就可以由Spring创建好的"learnService"，然后注入给Action。
*/
@Service("learnService")  
public class LearnServiceImpl implements LearnService{  
  
    @Resource(name = "learnDao")  
    private ILearnDao learnDao;

    // 通过学习记录表id 获得一个学习记录表 对象
	@Override
	public Learn getLearn(int learnId) {
		return learnDao.getLearn(learnId);
	}

	// 查询所有的学习记录表的数据
	@Override
	public List<Learn> selectAllLearn() {
		return learnDao.selectAllLearn();
	}

	// 通过课程id查找   学习该课程的人数   
	@Override
	public int getLearnNumberByCourseId(int courseId) {
		return learnDao.getLearnNumberByCourseId(courseId);
	}

	// 通过 用户id+课程id 查找   用户最近学习的该课程的视频是 那个小节(的一条学习记录)
	@Override
	public Learn getLearnOneByUserIdAndCourseId(String userId, int courseId) {
		return learnDao.getLearnOneByUserIdAndCourseId(userId, courseId);
	}

	// 通过 用户id+课程id 查找   用户已经学习过的该课程的视频(的学习记录)
	@Override
	public List<Learn> getAllLearnByUserIdAndCourseId(String userId, int courseId) {
		return learnDao.getAllLearnByUserIdAndCourseId(userId, courseId);
	}

	// 通过用户id 查找学习记录表(关联章节表+小节表+课程表)的集合
	@Override
	public List<Learn> getAllLearnByUserId(String userId){
		return learnDao.getAllLearnByUserId(userId);
	}
	
	// 通过用户id 查找我学习的课程总数
	@Override
	public int getCourseNumberByUserId(String userId){
		return learnDao.getCourseNumberByUserId(userId);
	}
	
	// 通过 用户id+小节id  查找学习记录表中是否有这条数据，如果有则返回这天数据 
	@Override
	public Learn getLearnByUserIdAndSmallChapterId(String userId, int smallChapterId){
		return learnDao.getLearnByUserIdAndSmallChapterId(userId, smallChapterId);
	}

	// 添加一个学习记录
	@Override
	public int addLearn(Learn learn) {
		return learnDao.addLearn(learn);
	}
	
	// 更新一个学习记录
	@Override
	public int updateLearn(Learn learn) {
		return learnDao.updateLearn(learn);
	}
	
	//查询sql: 通过用户id 查找 用户已经学习的时间(单位：秒)
	@Override
	public int selectUserLearnTime(String userId){
		return learnDao.selectUserLearnTime(userId);
	}

	
} 