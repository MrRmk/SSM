package com.imooc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.imooc.entity.Collect;
import com.sun.org.glassfish.gmbal.ParameterNames;

/*
	@Repository(value="collectDao")注解是告诉Spring，
	让Spring创建一个名字叫“collectDao”的CollectServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“collectDao”的CollectServiceImpl实例时，
	就可以使用@Resource(name = "collectDao")注解告诉Spring，
	Spring把创建好的collectDao注入给Service即可。
*/
@Repository("collectDao")  
public interface ICollectDao {
	
	// 通过收藏id 获得一个收藏表 对象
	public Collect getCollect(int collectId);
	
	// 通过用户id  查询所有的收藏表的数据
	public List<Collect> selectAllCollect(String userId);
	
	// 通过用户id  查询我的收藏课程总数
	public int getCollectNumberByUserId(String userId);
	
	// 通过课程id和用户id 从收藏表中判断是否有这条记录，若有则表示已收藏，否则未收藏
	public Collect isOrNotCollect(@Param("userId")String userId, @Param("courseId")int courseId);
		
	// 添加收藏
	public int addCollect(Collect collect);
	
	// 删除收藏
	public int deleteCollect(int collectId);
	
}
