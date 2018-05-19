package com.imooc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.imooc.entity.User;
import com.imooc.entity.UserDateNumber;

/*
	@Repository(value="userDao")注解是告诉Spring，
	让Spring创建一个名字叫“userDao”的UserServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“userDao”的UserServiceImpl实例时，
	就可以使用@Resource(name = "userDao")注解告诉Spring，
	Spring把创建好的userDao注入给Service即可。
*/
@Repository("userDao")  
public interface IUserDao {  
	
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
	
	
	//-------------------模糊查询-----分页------------------------------
	// 通过(登录名/职位/学校)其中之一  来模糊查询分页的用户表
	public List<User> getAllUserPageByUserId(@Param("userId")String userId, @Param("first")int first, @Param("pageSize")int pageSize); 
	
	// 通过(登录名/职位/学校)其中之一  来模糊查询分页的用户表的总个数
	public int getAllUserPageNumberByUserId(@Param("userId")String userId); 
	
	// 通过 用户状态+(登录名/职位/学校)其中之一  来模糊查询分页的用户表
	public List<User> getAllUserPageByUserStatusAndUserId(@Param("userStatus")String userStatus, @Param("userId")String userId, @Param("first")int first, @Param("pageSize")int pageSize); 
		
	// 通过 用户状态+(登录名/职位/学校)其中之一  来模糊查询分页的用户表的总个数
	public int getAllUserPageNumberByUserStatusAndUserId(@Param("userStatus")String userStatus, @Param("userId")String userId); 
	

	
}  
