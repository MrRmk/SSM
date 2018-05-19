package com.imooc.service;

import java.util.List;

import com.imooc.entity.SortsOne;


public interface SortsOneService {
	
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
