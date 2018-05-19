package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.ICourseDtoDao;
import com.imooc.dto.CourseDto;
import com.imooc.service.CourseDtoService;

@Service("courseDtoService")  
public class CourseDtoServiceImpl implements CourseDtoService{  
  
    @Resource(name = "courseDtoDao")  
    private ICourseDtoDao courseDtoDao;

    // 查询所有的课程表封装好的数据
	@Override
	public List<CourseDto> selectAllCourseDto() {
		return courseDtoDao.selectAllCourseDto();
	}
 
} 