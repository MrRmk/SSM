package com.imooc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.imooc.entity.SortsOne;

/*
	@Repository(value="sortsOneDao")注解是告诉Spring，
	让Spring创建一个名字叫“sortsOneDao”的SortsOneServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“sortsOneDao”的SortsOneServiceImpl实例时，
	就可以使用@Resource(name = "sortsOneDao")注解告诉Spring，
	Spring把创建好的sortsOneDao注入给Service即可。
*/
@Repository("sortsOneDao")  
public interface ISortsOneDao {
	
		// 获得一个一级分类表 对象
		public SortsOne getSortsOne(int oneId);
		
		// 查询所有的一级分类表的数据
		public List<SortsOne> selectAllSortsOne();
		
		// 通过一级分类编码查找   一级分类表 对象      (来获得一级分类名字)
		public SortsOne getSortsOneByOneCode(String oneCode);
		
		// 查询一级分类表的前七条数据  用于主页显示
		public List<SortsOne> selectAllSortsOneFirstSeven();
		
		// 添加
		public int addSortsOne(SortsOne sortsOne);
		
		// 删除
		public int deleteSortsOne(int oneId);
		
		// 修改
		public int updateSortsOne(SortsOne sortsOne);
		
		
}
