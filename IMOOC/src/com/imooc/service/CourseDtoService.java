package com.imooc.service;

import java.util.List;

import com.imooc.dto.CourseDto;

public interface CourseDtoService {
	
	// 查询所有的课程表封装好的数据
	public List<CourseDto> selectAllCourseDto();
			
}
