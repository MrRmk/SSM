package com.imooc.service;

import java.util.List;

import com.imooc.entity.SortsTwo;


public interface SortsTwoService {
	
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
