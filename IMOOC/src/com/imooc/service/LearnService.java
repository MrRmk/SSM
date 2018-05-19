package com.imooc.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.imooc.entity.Learn;

public interface LearnService {
	
	// 通过学习记录表id 获得一个学习记录表 对象
	public Learn getLearn(int learnId);
	
	// 查询所有的学习记录表的数据
	public List<Learn> selectAllLearn();
	
	// 通过课程id查找   学习该课程的人数   
	public int getLearnNumberByCourseId(int courseId);
	
	// 通过 用户id+课程id 查找   用户最近学习的该课程的视频是 那个小节(的一条学习记录)
	public Learn getLearnOneByUserIdAndCourseId(@Param("userId")String userId, @Param("courseId")int courseId);

	// 通过 用户id+课程id 查找   用户已经学习过的该课程的视频(的学习记录)
	public List<Learn> getAllLearnByUserIdAndCourseId(@Param("userId")String userId, @Param("courseId")int courseId);
		
	// 通过用户id 查找学习记录表(关联章节表+小节表+课程表)的集合
	public List<Learn> getAllLearnByUserId(String userId);
	
	// 通过用户id 查找我学习的课程总数
	public int getCourseNumberByUserId(String userId);

	// 通过 用户id+小节id  查找学习记录表中是否有这条数据，如果有则返回这天数据 
	public Learn getLearnByUserIdAndSmallChapterId(String userId, int smallChapterId);
	
	// 添加一个学习记录
	public int addLearn(Learn learn);
	
	// 更新一个学习记录
	public int updateLearn(Learn learn);
	
	//查询sql: 通过用户id 查找 用户已经学习的时间(单位：秒)
	public int selectUserLearnTime(String userId);

}
