package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.IManagerDao;
import com.imooc.entity.Manager;
import com.imooc.service.ManagerService;

/*
 * @Repository与@Resource注解说明：
	@Repository(value="managerDao")注解是告诉Spring，
	让Spring创建一个名字叫“managerDao”的ManagerServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“managerDao”的ManagerServiceImpl实例时，
	就可以使用@Resource(name = "managerDao")注解告诉Spring，
	Spring把创建好的managerDao注入给Service即可。
*/

/*
 * @Service注解说明：
	@Service("managerService")注解是告诉Spring，
	当Spring要创建ManagerServiceImpl的的实例时，
	bean的名字必须叫做"managerService"，
	这样当Action需要使用ManagerServiceImpl的的实例时,
	就可以由Spring创建好的"managerService"，然后注入给Action。
*/
@Service("managerService")  
public class ManagerServiceImpl implements ManagerService{  
  
    @Resource(name = "managerDao")  
    private IManagerDao managerDao;  

    // 获得一个管理员对象 -->(用于登录验证)
	@Override
	public Manager getManager(String account) {
		return managerDao.getManager(account);
	}

	//查询所有管理员表数据
	@Override
	public List<Manager> selectAllManager() {
		return managerDao.selectAllManager();
	} 
	
	// 修改管理员信息
	@Override
	public int updateManagerSelective(Manager manager){
		return managerDao.updateManagerSelective(manager);
	}
} 