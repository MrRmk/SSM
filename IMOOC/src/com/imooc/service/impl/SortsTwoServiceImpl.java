package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.ISortsTwoDao;
import com.imooc.entity.SortsTwo;
import com.imooc.service.SortsTwoService;


/*
 * @Service注解说明：
	@Service("sortsTwoService")注解是告诉Spring，
	当Spring要创建SortsTwoServiceImpl的的实例时，
	bean的名字必须叫做"sortsTwoService"，
	这样当Action需要使用SortsTwoServiceImpl的的实例时,
	就可以由Spring创建好的"sortsTwoService"，然后注入给Action。
*/
@Service("sortsTwoService")  
public class SortsTwoServiceImpl implements SortsTwoService{  
  
    @Resource(name = "sortsTwoDao")  
    private ISortsTwoDao sortsTwoDao;

    // 获得一个二级分类表 对象
	@Override
	public SortsTwo getSortsTwo(int twoId) {
		return sortsTwoDao.getSortsTwo(twoId);
	}

	// 查询所有的二级分类表的数据
	@Override
	public List<SortsTwo> selectAllSortsTwo() {
		return sortsTwoDao.selectAllSortsTwo();
	}

	// 通过二级分类编码查找   二级分类表 对象      (来获得二级分类名字)
	@Override
	public SortsTwo getSortsTwoByTwoCode(String twoCode) {
		return sortsTwoDao.getSortsTwoByTwoCode(twoCode);
	}

	// 通过一级分类id查找   二级分类表的集合   
	@Override
	public List<SortsTwo> getAllSortsTwoByOneId(int OneId) {
		return sortsTwoDao.getAllSortsTwoByOneId(OneId);
	}

	// 添加
	@Override
	public int addSortsTwo(SortsTwo sortsTwo){
		return sortsTwoDao.addSortsTwo(sortsTwo);
	}
	
	// 删除
	@Override
	public int deleteSortsTwo(int twoId){
		return sortsTwoDao.deleteSortsTwo(twoId);
	}
	
	// 修改
	@Override
	public int updateSortsTwo(SortsTwo sortsTwo){
		return sortsTwoDao.updateSortsTwo(sortsTwo);
	}
 
} 