package com.imooc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.imooc.entity.SortsTwo;

/*
	@Repository(value="sortsTwoDao")注解是告诉Spring，
	让Spring创建一个名字叫“sortsTwoDao”的SortsTwoServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“sortsTwoDao”的SortsTwoServiceImpl实例时，
	就可以使用@Resource(name = "sortsTwoDao")注解告诉Spring，
	Spring把创建好的sortsTwoDao注入给Service即可。
*/
@Repository("sortsTwoDao")  
public interface ISortsTwoDao {
	
		// 获得一个二级分类表 对象
		public SortsTwo getSortsTwo(int twoId);
		
		// 查询所有的二级分类表的数据
		public List<SortsTwo> selectAllSortsTwo();
		
		// 通过二级分类编码查找   二级分类表 对象      (来获得二级分类名字)
		public SortsTwo getSortsTwoByTwoCode(String twoCode);
		
		// 通过一级分类id查找   二级分类表的集合   
		public List<SortsTwo> getAllSortsTwoByOneId(int OneId);
		
		// 添加
		public int addSortsTwo(SortsTwo sortsTwo);
		
		// 删除
		public int deleteSortsTwo(int twoId);
		
		// 修改
		public int updateSortsTwo(SortsTwo sortsTwo);
}
