package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.ICourseDao;
import com.imooc.entity.Course;
import com.imooc.service.CourseService;


/*
 * @Service注解说明：
	@Service("courseService")注解是告诉Spring，
	当Spring要创建CourseServiceImpl的的实例时，
	bean的名字必须叫做"courseService"，
	这样当Action需要使用CourseServiceImpl的的实例时,
	就可以由Spring创建好的"courseService"，然后注入给Action。
*/
@Service("courseService")  
public class CourseServiceImpl implements CourseService{  
  
    @Resource(name = "courseDao")  
    private ICourseDao courseDao;

    // 通过课程id 获得一个课程表 对象
	@Override
	public Course getCourse(int courseId) {
		return courseDao.getCourse(courseId);
	}

	// 查询所有的课程表的数据
	@Override
	public List<Course> selectAllCourse() {
		return courseDao.selectAllCourse();
	}
	
	// 查询所有的课程表(在架)的数据
	@Override
	public List<Course> selectAllOnlineCourse(){
		return courseDao.selectAllOnlineCourse();
	}
	
	// 查询所有的课程表(在架)的分页数据
	@Override
	public List<Course> selectAllOnlineCoursePage(int first, int pageSize){
		return courseDao.selectAllOnlineCoursePage(first, pageSize);
	}
	
	// 查询所有的课程表(在架)数据分页的总个数
	@Override
	public int selectAllOnlineCourseNumber(){
		return courseDao.selectAllOnlineCourseNumber();
	}

	// 通过二级分类id查找   课程表的集合   
	@Override
	public List<Course> getAllCourseByTwoId(int twoId, int first, int pageSize) {
		return courseDao.getAllCourseByTwoId(twoId, first, pageSize);
	}
	
	// 通过二级分类id查找   课程表分页的集合的总个数   
	@Override
	public int getAllCourseNumberByTwoId(int twoId){
		return courseDao.getAllCourseNumberByTwoId(twoId);
	}
	
	// 通过一级分类编码查询  分页的课程表的集合
	@Override
	public List<Course> getAllCoursePageByOneCode(String oneCode, int first, int pageSize){
		return courseDao.getAllCoursePageByOneCode(oneCode, first, pageSize);
	}
	
	// 通过一级分类编码查询  分页的课程表集合的总个数 
	@Override
	public int getAllCoursePageNumberByOneCode(String oneCode){
		return courseDao.getAllCoursePageNumberByOneCode(oneCode);
	}
	
	// 查询--课程列表中实战的前五条(在架)数据----实战推荐
	@Override
	public List<Course> selectAllCourseProjectFirstFive(){
		return courseDao.selectAllCourseProjectFirstFive();
	}

	// 查询--课程列表中免费的前五条数据---免费好课
	@Override
	public List<Course> selectAllCourseFirstFive(){
		return courseDao.selectAllCourseFirstFive();
	}

	// 查询--课程列表中有关Java的(免费)课程---Java开发工程师
	@Override
	public List<Course> selectAllJavaCourse(){
		return courseDao.selectAllJavaCourse();
	}
	
	// 添加
	@Override
	public int addCourse(Course course){
		return courseDao.addCourse(course);
	}
	
	// 删除
	@Override
	public int deleteCourse(int courseId){
		return courseDao.deleteCourse(courseId);
	}
	
	// 修改
	@Override
	public int updateCourse(Course course){
		return courseDao.updateCourse(course);
	}
	
	//-------------------模糊查询-----分页------------------------------
	// 通过课程名   来模糊查询   分页的课程表的集合
	@Override
	public List<Course> getAllCourseByCourseName(String courseName, int first, int pageSize){
		return courseDao.getAllCourseByCourseName(courseName, first, pageSize);
	}
	
	// 通过课程名   来模糊查询   课程表集合的总个数
	@Override
	public int getAllCourseNumberByCourseName(String courseName){
		return courseDao.getAllCourseNumberByCourseName(courseName);
	}
	
	// 通过一级分类+ 课程名模糊查询  分页的课程表的集合
	@Override
	public List<Course> getAllCourseByOneCodeAndCourseName(String oneCode, String courseName, int first, int pageSize){
		return courseDao.getAllCourseByOneCodeAndCourseName(oneCode, courseName, first, pageSize);
	}
	
	// 通过一级分类+ 课程名模糊查询 课程表集合的总个数
	@Override
	public int getAllCourseNumberByOneCodeAndCourseName(String oneCode, String courseName){
		return courseDao.getAllCourseNumberByOneCodeAndCourseName(oneCode, courseName);
	}
	
	// 通过课程id 查询课程总时长
	@Override
	public int selectCourseTotalTimeSecond(int courseId){
		return courseDao.selectCourseTotalTimeSecond(courseId);
	}
	
 
} 