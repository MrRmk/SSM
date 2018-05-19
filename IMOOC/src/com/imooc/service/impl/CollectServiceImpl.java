package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.ICollectDao;
import com.imooc.entity.Collect;
import com.imooc.service.CollectService;


/*
 * @Service注解说明：
	@Service("collectService")注解是告诉Spring，
	当Spring要创建CollectServiceImpl的的实例时，
	bean的名字必须叫做"collectService"，
	这样当Action需要使用CollectServiceImpl的的实例时,
	就可以由Spring创建好的"collectService"，然后注入给Action。
*/
@Service("collectService")  
public class CollectServiceImpl implements CollectService{  
  
    @Resource(name = "collectDao")  
    private ICollectDao collectDao;

    // 通过收藏id 获得一个收藏表 对象
	@Override
	public Collect getCollect(int collectId) {
		return collectDao.getCollect(collectId);
	}

	// 通过用户id  查询所有的收藏表的数据
	@Override
	public List<Collect> selectAllCollect(String userId) {
		return collectDao.selectAllCollect(userId);
	}
	
	// 通过用户id  查询我的收藏课程总数
	@Override
	public int getCollectNumberByUserId(String userId){
		return collectDao.getCollectNumberByUserId(userId);
	}
	
	// 通过课程id和用户id 从收藏表中判断是否有这条记录，若有则表示已收藏，否则未收藏
	@Override
	public Collect isOrNotCollect(String userId, int courseId){
		return collectDao.isOrNotCollect(userId, courseId);
	}

	// 添加收藏
	@Override
	public int addCollect(Collect collect) {
		return collectDao.addCollect(collect);
	}

	// 删除收藏
	@Override
	public int deleteCollect(int collectId) {
		return collectDao.deleteCollect(collectId);
	}

} 