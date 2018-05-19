package com.imooc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.imooc.entity.Manager;

/*
	@Repository(value="managerDao")注解是告诉Spring，
	让Spring创建一个名字叫“managerDao”的ManagerServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“managerDao”的ManagerServiceImpl实例时，
	就可以使用@Resource(name = "managerDao")注解告诉Spring，
	Spring把创建好的managerDao注入给Service即可。
*/
@Repository("managerDao")  
public interface IManagerDao {
	
		//*********登录用到的方法*************************************
		// 获得一个管理员对象 -->(用于登录验证)
		public Manager getManager(String account);
		
		// 查询所有的管理员表数据
		public List<Manager> selectAllManager();
		
		// 修改管理员信息
		public int updateManagerSelective(Manager manager);
}
