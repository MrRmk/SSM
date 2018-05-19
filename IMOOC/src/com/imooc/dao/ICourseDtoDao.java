package com.imooc.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.imooc.dto.CourseDto;

/*
	@Repository(value="courseDtoDao")注解是告诉Spring，
	让Spring创建一个名字叫“courseDtoDao”的CourseDtoServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“courseDtoDao”的CourseDtoServiceImpl实例时，
	就可以使用@Resource(name = "courseDtoDao")注解告诉Spring，
	Spring把创建好的courseDtoDao注入给Service即可。
*/
@Repository("courseDtoDao")  
public interface ICourseDtoDao {
	
		// 查询所有的课程表封装好的数据
		public List<CourseDto> selectAllCourseDto();
		
}
