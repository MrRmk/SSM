package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.IUserDao;
import com.imooc.entity.User;
import com.imooc.entity.UserDateNumber;
import com.imooc.service.UserService;
/*
 * @Repository与@Resource注解说明：
	@Repository(value="userDao")注解是告诉Spring，
	让Spring创建一个名字叫“userDao”的UserServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“userDao”的UserServiceImpl实例时，
	就可以使用@Resource(name = "userDao")注解告诉Spring，
	Spring把创建好的userDao注入给Service即可。
*/

/*
 * @Service注解说明：
	@Service("userService")注解是告诉Spring，
	当Spring要创建UserServiceImpl的的实例时，
	bean的名字必须叫做"userService"，
	这样当Action需要使用UserServiceImpl的的实例时,
	就可以由Spring创建好的"userService"，然后注入给Action。
*/
@Service("userService")  
public class UserServiceImpl implements UserService{  
  
    @Resource(name = "userDao")  
    private IUserDao userDao;  
    
    //查询所有用户
   	@Override
   	public List<User> getAllUser() {
   		return userDao.getAllUser();  
   	}
   	
   	// 查询用户表所有数据的--总条数
   	@Override
 	public int getAllUserTotal(){
   		return userDao.getAllUserTotal();
   	}
		
   	//通过用户账号查询 此用户
   	@Override
   	public User getUser(String userId) {
   		return userDao.getUser(userId);
   	}
    
    // 增加一个用户
	@Override
	public int addUser(User user){
		return userDao.addUser(user);  
	}  
  
    // 增加一个用户  (字段可以为空)
	@Override
	public int addUserSelective(User user){
		return userDao.addUserSelective(user);  
	}  
	
	// 通过用户账号 删除用户表
	@Override
	public int deleteUserByUserId(String userId){
		return userDao.deleteUserByUserId(userId);  
	}
  
    // 更新用户 (字段可以为空)
	@Override
	public int updateUserSelective(User user){
		return userDao.updateUserSelective(user);  
	}  
  
    // 更新用户
	@Override
	public int updateUser(User user){
		return userDao.updateUser(user);  
	}  
    
	// 查询最近一周内的用户注册人数
	@Override
	public List<UserDateNumber> getUserDateNumber(){
		return userDao.getUserDateNumber();
	}
	
	// 通过(登录名/职位/学校)其中之一  来模糊查询分页的用户表
	@Override
	public List<User> getAllUserPageByUserId(String userId, int first, int pageSize){
		return userDao.getAllUserPageByUserId(userId, first, pageSize);
	}
	
	// 通过(登录名/职位/学校)其中之一  来模糊查询分页的用户表的总个数
	@Override
	public int getAllUserPageNumberByUserId(String userId){
		return userDao.getAllUserPageNumberByUserId(userId);
	}
	
	// 通过 用户状态+(登录名/职位/学校)其中之一  来模糊查询分页的用户表
	@Override
	public List<User> getAllUserPageByUserStatusAndUserId(String userStatus, String userId, int first, int pageSize){
		return userDao.getAllUserPageByUserStatusAndUserId(userStatus, userId, first, pageSize);
	}
		
	// 通过 用户状态+(登录名/职位/学校)其中之一  来模糊查询分页的用户表的总个数
	@Override
	public int getAllUserPageNumberByUserStatusAndUserId(String userStatus, String userId){
		return userDao.getAllUserPageNumberByUserStatusAndUserId(userStatus, userId);
	}
	
	
	
} 