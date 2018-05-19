package com.imooc.service;

import java.util.List;

import com.imooc.entity.User;
import com.imooc.entity.UserDateNumber;

public interface UserService {
	
	// 查询用户表所有数据
	public List<User> getAllUser();
	
	// 查询用户表所有数据的--总条数
	public int getAllUserTotal();
		
	// 通过用户账号 查询用户表 
	public User getUser(String userId);  
	
    // 增加一个用户
	public int addUser(User user); 
  
    // 增加一个用户  (字段可以为空)
	public int addUserSelective(User user);  
  
	// 通过用户账号 删除用户表
	public int deleteUserByUserId(String userId);  
  
	// 更新用户 (字段可以为空)
	public int updateUserSelective(User user);  
  
    // 更新用户
	public int updateUser(User user);   
    
	// 查询最近一周内的用户注册人数
	public List<UserDateNumber> getUserDateNumber();  
	
	// 通过(登录名/职位/学校)其中之一  来模糊查询分页的用户表
	public List<User> getAllUserPageByUserId(String userId, int first, int pageSize); 
	
	// 通过(登录名/职位/学校)其中之一  来模糊查询分页的用户表的总个数
	public int getAllUserPageNumberByUserId(String userId); 
	
	// 通过 用户状态+(登录名/职位/学校)其中之一  来模糊查询分页的用户表
	public List<User> getAllUserPageByUserStatusAndUserId(String userStatus, String userId, int first, int pageSize); 
		
	// 通过 用户状态+(登录名/职位/学校)其中之一  来模糊查询分页的用户表的总个数
	public int getAllUserPageNumberByUserStatusAndUserId(String userStatus, String userId); 
	
	
	
}
