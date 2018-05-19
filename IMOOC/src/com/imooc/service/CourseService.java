package com.imooc.service;

import java.util.List;

import com.imooc.entity.Course;

public interface CourseService {
	
	// 通过课程id 获得一个课程表 对象
	public Course getCourse(int courseId);
	
	// 查询所有的课程表的数据
	public List<Course> selectAllCourse();
	
	// 查询所有的课程表(在架)的数据
	public List<Course> selectAllOnlineCourse();
	
	// 查询所有的课程表(在架)数据分页的总个数
	public int selectAllOnlineCourseNumber();
	
	// 查询所有的课程表(在架)的分页数据
	public List<Course> selectAllOnlineCoursePage(int first, int pageSize);
	
	// 通过二级分类id查找   课程表的集合   
	public List<Course> getAllCourseByTwoId(int twoId, int first, int pageSize);
	
	// 通过二级分类id查找   课程表分页的集合的总个数   
	public int getAllCourseNumberByTwoId(int twoId);
	
	// 通过一级分类编码查询  分页的课程表的集合
	public List<Course> getAllCoursePageByOneCode(String oneCode, int first, int pageSize);
	
	// 通过一级分类编码查询  分页的课程表集合的总个数 
	public int getAllCoursePageNumberByOneCode(String oneCode);
	
	// 查询--课程列表中实战的前五条(在架)数据----实战推荐
	public List<Course> selectAllCourseProjectFirstFive();
	
	// 查询--课程列表中免费的前五条数据---免费好课
	public List<Course> selectAllCourseFirstFive();
	
	// 查询--课程列表中有关Java的(免费)课程---Java开发工程师
	public List<Course> selectAllJavaCourse();
	
	// 添加
	public int addCourse(Course course);
	
	// 删除
	public int deleteCourse(int courseId);
	
	// 修改
	public int updateCourse(Course course);
	
	
	//-------------------模糊查询-----分页------------------------------
	// 通过课程名   来模糊查询   分页的课程表的集合
	public List<Course> getAllCourseByCourseName(String courseName, int first, int pageSize);
	
	// 通过课程名   来模糊查询   课程表集合的总个数
	public int getAllCourseNumberByCourseName(String courseName);
	
	// 通过一级分类+ 课程名模糊查询  分页的课程表的集合
	public List<Course> getAllCourseByOneCodeAndCourseName(String oneCode, String courseName, int first, int pageSize);
	
	// 通过一级分类+ 课程名模糊查询 课程表集合的总个数
	public int getAllCourseNumberByOneCodeAndCourseName(String oneCode, String courseName);
	
	// 通过课程id 查询课程总时长
	public int selectCourseTotalTimeSecond(int courseId);	
		
}
