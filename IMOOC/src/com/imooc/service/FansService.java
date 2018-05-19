package com.imooc.service;

import java.util.List;

import com.imooc.entity.Fans;

public interface FansService {
	
	// 通过粉丝id 获得一个粉丝表 对象
	public Fans getFans(int fansId);
	
	// 通过用户id 查询所有的粉丝记录
	public List<Fans> getAllFansByUserId(String userId);
	
	// 通过用户id 查询所有的粉丝总个数
	public int getFansNumberByUserId(String userId);
	
	// 通过用户id 查询所有关注的用户的记录
	public List<Fans> getAllFollowsByUserId(String userId);
	
	// 通过用户id 查询所有关注用户的总个数
	public int getFollowsNumberByUserId(String userId);
		
	// 添加粉丝
	public int addFans(Fans fans);
	
	// 删除粉丝
	public int deleteFans(int fansId);
	
}
