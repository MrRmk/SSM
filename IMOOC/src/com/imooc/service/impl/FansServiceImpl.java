package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.IFansDao;
import com.imooc.entity.Fans;
import com.imooc.service.FansService;


/*
 * @Service注解说明：
	@Service("fansService")注解是告诉Spring，
	当Spring要创建FansServiceImpl的的实例时，
	bean的名字必须叫做"fansService"，
	这样当Action需要使用FansServiceImpl的的实例时,
	就可以由Spring创建好的"fansService"，然后注入给Action。
*/
@Service("fansService")  
public class FansServiceImpl implements FansService{  
  
    @Resource(name = "fansDao")  
    private IFansDao fansDao;

    // 通过粉丝id 获得一个粉丝表 对象
	@Override
	public Fans getFans(int fansId) {
		return fansDao.getFans(fansId);
	}

	// 通过用户id 查询所有的粉丝记录
	@Override
	public List<Fans> getAllFansByUserId(String userId) {
		return fansDao.getAllFansByUserId(userId);
	}

	// 通过用户id 查询所有的粉丝总个数
	@Override
	public int getFansNumberByUserId(String userId) {
		return fansDao.getFansNumberByUserId(userId);
	}

	// 通过用户id 查询所有关注的用户的记录
	@Override
	public List<Fans> getAllFollowsByUserId(String userId) {
		return fansDao.getAllFollowsByUserId(userId);
	}

	// 通过用户id 查询所有关注用户的总个数
	@Override
	public int getFollowsNumberByUserId(String userId) {
		return fansDao.getFollowsNumberByUserId(userId);
	}

	// 添加粉丝
	@Override
	public int addFans(Fans fans) {
		return fansDao.addFans(fans);
	}

	// 删除粉丝
	@Override
	public int deleteFans(int fansId) {
		return fansDao.deleteFans(fansId);
	}

    
} 