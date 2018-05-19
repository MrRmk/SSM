package com.imooc.service;

import java.util.List;

import com.imooc.entity.Collect;

public interface CollectService {
	
	// 通过收藏id 获得一个收藏表 对象
	public Collect getCollect(int collectId);
	
	// 通过用户id  查询所有的收藏表的数据
	public List<Collect> selectAllCollect(String userId);
	
	// 通过用户id  查询我的收藏课程总数
	public int getCollectNumberByUserId(String userId);
	
	// 通过课程id和用户id 从收藏表中判断是否有这条记录，若有则表示已收藏，否则未收藏
	public Collect isOrNotCollect(String userId, int courseId);
		
	// 添加收藏
	public int addCollect(Collect collect);
	
	// 删除收藏
	public int deleteCollect(int collectId);
}
