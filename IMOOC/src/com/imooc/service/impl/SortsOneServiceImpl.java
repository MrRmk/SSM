package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.ISortsOneDao;
import com.imooc.entity.SortsOne;
import com.imooc.service.SortsOneService;


/*
 * @Service注解说明：
	@Service("sortsOneService")注解是告诉Spring，
	当Spring要创建SortsOneServiceImpl的的实例时，
	bean的名字必须叫做"sortsOneService"，
	这样当Action需要使用SortsOneServiceImpl的的实例时,
	就可以由Spring创建好的"sortsOneService"，然后注入给Action。
*/
@Service("sortsOneService")  
public class SortsOneServiceImpl implements SortsOneService{  
  
    @Resource(name = "sortsOneDao")  
    private ISortsOneDao sortsOneDao;
	
    // 获得一个一级分类表 对象
	@Override
	public SortsOne getSortsOne(int oneId) {
		return sortsOneDao.getSortsOne(oneId);
	}

	// 查询所有的一级分类表的数据
	@Override
	public List<SortsOne> selectAllSortsOne() {
		return sortsOneDao.selectAllSortsOne();
	}

	// 通过一级分类编码查找 一级分类名字
	@Override
	public SortsOne getSortsOneByOneCode(String oneCode) {
		return sortsOneDao.getSortsOneByOneCode(oneCode);
	}  

	// 查询一级分类表的前七条数据  用于主页显示
	@Override
	public List<SortsOne> selectAllSortsOneFirstSeven(){
		return sortsOneDao.selectAllSortsOneFirstSeven();
	}
	
	// 添加
	@Override
	public int addSortsOne(SortsOne sortsOne){
		return sortsOneDao.addSortsOne(sortsOne);
	}
	
	// 删除
	public int deleteSortsOne(int oneId){
		return sortsOneDao.deleteSortsOne(oneId);
	}
	
	// 修改
	public int updateSortsOne(SortsOne sortsOne){
		return sortsOneDao.updateSortsOne(sortsOne);
	}
 
} 