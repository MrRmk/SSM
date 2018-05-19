package com.imooc.service;

import java.util.List;

import com.imooc.entity.Manager;


public interface ManagerService {
	
	// 获得一个管理员对象 -->(用于登录验证)
	public Manager getManager(String account);
	
	//查询所有管理员表数据
	public List<Manager> selectAllManager();  
	
	
	//增加管理员
	
	//删除管理员
	
	// 修改管理员信息
	public int updateManagerSelective(Manager manager);
}
