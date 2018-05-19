package com.imooc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.imooc.entity.Fans;

/*
	@Repository(value="fansDao")注解是告诉Spring，
	让Spring创建一个名字叫“fansDao”的FansServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“fansDao”的FansServiceImpl实例时，
	就可以使用@Resource(name = "fansDao")注解告诉Spring，
	Spring把创建好的fansDao注入给Service即可。
*/
@Repository("fansDao")  
public interface IFansDao {
	
	// 通过粉丝id 获得一个粉丝表 对象
	public Fans getFans(int fansId);
	
	// 通过用户id 查询该用户所有的粉丝记录
	public List<Fans> getAllFansByUserId(String userId);
	
	// 通过用户id 查询该用户所有的粉丝总个数
	public int getFansNumberByUserId(String userId);
	
	// 通过用户id 查询该用户所有关注的用户的记录
	public List<Fans> getAllFollowsByUserId(String userId);
	
	// 通过用户id 查询该用户所有关注的用户的总个数
	public int getFollowsNumberByUserId(String userId);
		
	// 添加粉丝
	public int addFans(Fans fans);
	
	// 删除粉丝
	public int deleteFans(int fansId);
	
	
}
