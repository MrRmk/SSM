package com.imooc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.imooc.common.DateUtil;
import com.imooc.dto.CourseDto;
import com.imooc.dto.MessageDto;
import com.imooc.entity.*;
import com.imooc.service.*;

@Controller  
@RequestMapping(value = "")  
public class UserController {  
    @Resource(name = "userService")  
    UserService userService; 
    @Resource(name = "sortsOneService")  
    SortsOneService sortsOneService;  
    @Resource(name = "sortsTwoService")  
    SortsTwoService sortsTwoService; 
    @Resource(name = "courseService")  
    CourseService courseService; 
    @Resource(name = "learnService")  
    LearnService learnService; 
    @Resource(name = "chapterService")  
    ChapterService chapterService; 
    @Resource(name = "smallChapterService")  
    SmallChapterService smallChapterService; 
    @Resource(name = "commentsService")  
    CommentsService commentsService; 
    @Resource(name = "questionService")  
    QuestionService questionService; 
    @Resource(name = "noteService")  
    NoteService noteService; 
    @Resource(name = "replyService")  
    ReplyService replyService; 
    @Resource(name = "collectService")  
    CollectService collectService; 
    @Resource(name = "fansService")  
    FansService fansService; 

    int pageSize = 10;	// 默认定义分页条数
    int pageFirst = 0;	// 当前页
    
    
    /**
	 * 	请求主页页面
	 */
    @RequestMapping(value = "/")  
    public String home(HttpServletRequest request, HttpSession session){
    	System.out.println("\n");
    	// 查询一级分类表的前七条数据  用于主页显示    
    	List<SortsOne> sortsOneList = sortsOneService.selectAllSortsOneFirstSeven();
    	if( sortsOneList != null ){
    		request.setAttribute("sortsOneList", sortsOneList);
    		for(SortsOne s : sortsOneList) {
    			System.out.println("\n/---请求主页页面---------课程主页--一级分类列表--id:" + s.getOneId() + ", 一级分类名字:" + s.getOneName() + ", 一级分类编码:" + s.getOneCode());
    		}
    	}
    	
    	// 获取二级分类的数据 返回给页面    
    	List<SortsTwo> sortsTwoList = sortsTwoService.selectAllSortsTwo();
    	if( sortsTwoList != null ){
    		request.setAttribute("sortsTwoList", sortsTwoList);
    		for(SortsTwo s : sortsTwoList) {
    			System.out.println("\n/---请求主页页面---------课程主页--二级分类列表--id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ ",一级分类id"+s.getOneId());
    		}
    	}
    	
    	// 获取 课程列表
		List<Course> courseList = courseService.selectAllOnlineCourse();
		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
		// 创建 courseDtoList 用来存储包装后的集合数据, 来返回给页面
		List<CourseDto> courseDtoList = new ArrayList<CourseDto>();
		int count = 0;	// 学习人数
		for(Course c1: courseList){ 
			// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
			c1.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
			String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			count = learnService.getLearnNumberByCourseId(c1.getCourseId());
			CourseDto courseDto = new CourseDto();
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(c1);
			courseDto.setOneId(sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId());
			courseDto.setNumber(count);
			courseDtoList.add(courseDto);
		}
		// 把包装的数据返回给页面
		request.setAttribute("courseDtoList", courseDtoList);
		System.out.println("\n/---请求主页页面----获取 课程列表包装类-----courseDtoList：" + courseDtoList);
    	
		// 查询--课程列表中实战的前五条(在架)数据----实战推荐
		List<Course> courseProjectFirstFiveList = courseService.selectAllCourseProjectFirstFive();
		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
		// 创建 courseDtoList 用来存储包装后的集合数据, 来返回给页面
		List<CourseDto> courseProjectFirstFiveDtoList = new ArrayList<CourseDto>();
		for(Course c1: courseProjectFirstFiveList){ 
			// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
			c1.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
			String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			int count1 = 0;	// 学习人数
			count1 = learnService.getLearnNumberByCourseId(c1.getCourseId());
			CourseDto courseDto = new CourseDto();
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(c1);
			courseDto.setOneId(sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId());
			courseDto.setNumber(count1);
			courseProjectFirstFiveDtoList.add(courseDto);
		}
		// 把包装的数据返回给页面
		request.setAttribute("courseProjectFirstFiveDtoList", courseProjectFirstFiveDtoList);
		System.out.println("\n/----请求主页页面--查询--课程列表中实战的前五条(在架)数据----实战推荐-----courseProjectFirstFiveDtoList：" + courseProjectFirstFiveDtoList);
				
		
		// 查询--课程列表中免费的前五条数据---免费好课
		List<Course> courseFirstFiveList = courseService.selectAllCourseFirstFive();
		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
		// 创建 courseDtoList 用来存储包装后的集合数据, 来返回给页面
		List<CourseDto> courseFirstFiveDtoList = new ArrayList<CourseDto>();
		
		for(Course c1: courseFirstFiveList){ 
			// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
			c1.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
			String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			int count1 = 0;	// 学习人数
			count1 = learnService.getLearnNumberByCourseId(c1.getCourseId());
			CourseDto courseDto = new CourseDto();
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(c1);
			courseDto.setOneId(sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId());
			courseDto.setNumber(count1);
			courseFirstFiveDtoList.add(courseDto);
		}
		// 把包装的数据返回给页面
		request.setAttribute("courseFirstFiveDtoList", courseFirstFiveDtoList);
		System.out.println("\n/----请求主页页面--查询--课程列表中免费的前五条数据---免费好课-----courseFirstFiveDtoList：" + courseFirstFiveDtoList);
		
		// 查询--课程列表中有关Java的(免费)课程---Java开发工程师
		List<Course> javaCourseList = courseService.selectAllJavaCourse();
		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
		// 创建 javaCourseDtoList 用来存储包装后的集合数据, 来返回给页面
		List<CourseDto> javaCourseLowDtoList = new ArrayList<CourseDto>();	// 入门课程
		List<CourseDto> javaCourseMidDtoList = new ArrayList<CourseDto>();	// 初级+中级课程
		List<CourseDto> javaCourseHighDtoList = new ArrayList<CourseDto>();	// 高级课程
		for(Course c1: javaCourseList){ 
			// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
			c1.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
			String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			int count1 = 0;	// 学习人数
			count1 = learnService.getLearnNumberByCourseId(c1.getCourseId());
			CourseDto courseDto = new CourseDto();
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(c1);
			courseDto.setOneId(sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId());
			courseDto.setNumber(count1);
			if( c1.getCourseGrade().equals("入门") ){
				javaCourseLowDtoList.add(courseDto);
			}else if( c1.getCourseGrade().equals("高级") ){
				javaCourseHighDtoList.add(courseDto);
			}else{
				javaCourseMidDtoList.add(courseDto);
			}
		}
		// 把包装的数据返回给页面
		request.setAttribute("javaCourseLowDtoList", javaCourseLowDtoList);
		request.setAttribute("javaCourseMidDtoList", javaCourseMidDtoList);
		request.setAttribute("javaCourseHighDtoList", javaCourseHighDtoList);
		System.out.println("\n/----请求主页页面--查询--课程列表中有关Java的(免费)课程--入门课程---Java开发工程师-----javaCourseLowDtoList：" + javaCourseLowDtoList);
		System.out.println("\n/----请求主页页面--查询--课程列表中有关Java的(免费)课程--初级+中级课程---Java开发工程师-----javaCourseLowDtoList：" + javaCourseLowDtoList);
		System.out.println("\n/----请求主页页面--查询--课程列表中有关Java的(免费)课程--高级课程---Java开发工程师-----javaCourseLowDtoList：" + javaCourseLowDtoList);
				
		
        return "home";
    }
    
    /**
	 * 	-->主页页面
	 */
    @RequestMapping(value = "/home")  
    public String homepage(HttpServletRequest request, HttpSession session){
    	System.out.println("home---"+session.getAttribute("user"));
    	System.out.println("\n");
    	// 查询一级分类表的前七条数据  用于主页显示    
    	List<SortsOne> sortsOneList = sortsOneService.selectAllSortsOneFirstSeven();
    	if( sortsOneList != null ){
    		request.setAttribute("sortsOneList", sortsOneList);
    		for(SortsOne s : sortsOneList) {
    			System.out.println("\n/home---------课程主页--一级分类列表--id:" + s.getOneId() + ", 一级分类名字:" + s.getOneName() + ", 一级分类编码:" + s.getOneCode());
    		}
    	}
    	
    	// 获取二级分类的数据 返回给页面    
    	List<SortsTwo> sortsTwoList = sortsTwoService.selectAllSortsTwo();
    	if( sortsTwoList != null ){
    		request.setAttribute("sortsTwoList", sortsTwoList);
    		for(SortsTwo s : sortsTwoList) {
    			System.out.println("\n/home---------课程主页--二级分类列表--id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ ",一级分类id"+s.getOneId());
    		}
    	}
    	
    	// 获取 课程列表
		List<Course> courseList = courseService.selectAllOnlineCourse();
		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
		// 创建 courseDtoList 用来存储包装后的集合数据, 来返回给页面
		List<CourseDto> courseDtoList = new ArrayList<CourseDto>();
		int count = 0;	// 学习人数
		for(Course c1: courseList){ 
			// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
			c1.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
			String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			count = learnService.getLearnNumberByCourseId(c1.getCourseId());
			CourseDto courseDto = new CourseDto();
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(c1);
			courseDto.setOneId(sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId());
			courseDto.setNumber(count);
			courseDtoList.add(courseDto);
		}
		// 把包装的数据返回给页面
		request.setAttribute("courseDtoList", courseDtoList);
		System.out.println("\n/home---------一级分类编码选的是全部，二级分类选的是全部-----courseDtoList：" + courseDtoList);
    	
		// 查询--课程列表中实战的前五条(在架)数据----实战推荐
		List<Course> courseProjectFirstFiveList = courseService.selectAllCourseProjectFirstFive();
		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
		// 创建 courseDtoList 用来存储包装后的集合数据, 来返回给页面
		List<CourseDto> courseProjectFirstFiveDtoList = new ArrayList<CourseDto>();
		for(Course c1: courseProjectFirstFiveList){ 
			// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
			c1.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
			String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			int count1 = 0;	// 学习人数
			count1 = learnService.getLearnNumberByCourseId(c1.getCourseId());
			CourseDto courseDto = new CourseDto();
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(c1);
			courseDto.setOneId(sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId());
			courseDto.setNumber(count1);
			courseProjectFirstFiveDtoList.add(courseDto);
		}
		// 把包装的数据返回给页面
		request.setAttribute("courseProjectFirstFiveDtoList", courseProjectFirstFiveDtoList);
		System.out.println("\n/home----请求主页页面--查询--课程列表中实战的前五条(在架)数据----实战推荐-----courseProjectFirstFiveDtoList：" + courseProjectFirstFiveDtoList);
		
		// 查询--课程列表中免费的前五条数据---免费好课
		List<Course> courseFirstFiveList = courseService.selectAllCourseFirstFive();
		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
		// 创建 courseDtoList 用来存储包装后的集合数据, 来返回给页面
		List<CourseDto> courseFirstFiveDtoList = new ArrayList<CourseDto>();
		for(Course c1: courseFirstFiveList){ 
			// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
			c1.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
			String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			int count1 = 0;	// 学习人数
			count1 = learnService.getLearnNumberByCourseId(c1.getCourseId());
			CourseDto courseDto = new CourseDto();
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(c1);
			courseDto.setOneId(sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId());
			courseDto.setNumber(count1);
			courseFirstFiveDtoList.add(courseDto);
		}
		// 把包装的数据返回给页面
		request.setAttribute("courseFirstFiveDtoList", courseFirstFiveDtoList);
		System.out.println("\n/home----请求主页页面--查询--课程列表中免费的前五条数据---免费好课-----courseFirstFiveDtoList：" + courseFirstFiveDtoList);
			
		
		// 查询--课程列表中有关Java的(免费)课程---Java开发工程师
		List<Course> javaCourseList = courseService.selectAllJavaCourse();
		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
		// 创建 javaCourseDtoList 用来存储包装后的集合数据, 来返回给页面
		List<CourseDto> javaCourseLowDtoList = new ArrayList<CourseDto>();	// 入门课程
		List<CourseDto> javaCourseMidDtoList = new ArrayList<CourseDto>();	// 初级+中级课程
		List<CourseDto> javaCourseHighDtoList = new ArrayList<CourseDto>();	// 高级课程
		for(Course c1: javaCourseList){ 
			// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
			c1.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
			String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			int count1 = 0;	// 学习人数
			count1 = learnService.getLearnNumberByCourseId(c1.getCourseId());
			CourseDto courseDto = new CourseDto();
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(c1);
			courseDto.setOneId(sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId());
			courseDto.setNumber(count1);
			if( c1.getCourseGrade().equals("入门") ){
				javaCourseLowDtoList.add(courseDto);
			}else if( c1.getCourseGrade().equals("高级") ){
				javaCourseHighDtoList.add(courseDto);
			}else{
				javaCourseMidDtoList.add(courseDto);
			}
		}
		// 把包装的数据返回给页面
		request.setAttribute("javaCourseLowDtoList", javaCourseLowDtoList);
		request.setAttribute("javaCourseMidDtoList", javaCourseMidDtoList);
		request.setAttribute("javaCourseHighDtoList", javaCourseHighDtoList);
		System.out.println("\n/home----请求主页页面--查询--课程列表中有关Java的(免费)课程--入门课程---Java开发工程师-----javaCourseLowDtoList：" + javaCourseLowDtoList);
		System.out.println("\n/home----请求主页页面--查询--课程列表中有关Java的(免费)课程--初级+中级课程---Java开发工程师-----javaCourseLowDtoList：" + javaCourseLowDtoList);
		System.out.println("\n/home----请求主页页面--查询--课程列表中有关Java的(免费)课程--高级课程---Java开发工程师-----javaCourseLowDtoList：" + javaCourseLowDtoList);
							
		
		
        return "home";
    }
    
    
    
    /**
   	 * 	在课程主页--点击分类之后---重新返回课程主页
   	 */
    @RequestMapping(value = "/course/total")  
    public String courseTotal( @RequestParam("c")String c, HttpServletRequest request, HttpSession session){
    	
    	String page = request.getParameter("pageNum");//传入要跳转的页码，若没有则为1
    	System.out.println("\n/course/total-------pageNum:"+page+", c: " + c);
    	//分页
    	List<Course> courseList = new ArrayList<Course>();
    	Page pageModel = new Page();
    	if( page == null || page == "" || page.equals("") ){
    		pageFirst = 1;
    	}else{
    		pageFirst = Integer.parseInt(page);
    	}
    	pageModel.setPage(pageFirst);	//当前页
    	pageModel.setSize(pageSize);	//每页的条数
    	int first = (pageFirst-1)*pageSize;	// limit第一个参数 
    	int total = 0;
    	
    	
    	
    	// 获取一级分类的数据 返回给页面----所有情况的一级分类数据都一样    
    	List<SortsOne> sortsOneList = sortsOneService.selectAllSortsOne();
    	if( sortsOneList != null ){
    		request.setAttribute("sortsOneList", sortsOneList);
    		for(SortsOne s : sortsOneList) {
    			System.out.println("\n/course/total-------课程主页--一级分类列表--id:" + s.getOneId() + ", 一级分类名字:" + s.getOneName() + ", 一级分类编码:" + s.getOneCode());
    		}
    	}
    	
    	// 1、判断c是否等于-1，若等于，说明鼠标点击了一级分类的"全部"按钮；
    	// 2、若不是，则判断c是否等于一级分类的编码，
    	// 3、否则就是二级分类的编码，
    	// 4、二级分类的"全部"按钮，已经在前两种情况中包含
    	if( c.equals("-1") ){
    		// 在session中存储 一级分类和二级分类的编码值，用于页面设置样式
    		session.setAttribute("direction", -1);
        	session.setAttribute("classify", -2);
        	// 获取二级分类的数据 返回给页面    
        	List<SortsTwo> sortsTwoList = sortsTwoService.selectAllSortsTwo();
        	if( sortsTwoList != null && sortsTwoList.size() > 0 ){
        		request.setAttribute("sortsTwoList", sortsTwoList);
        		for(SortsTwo s : sortsTwoList) {
        			System.out.println("\n/course/total-------课程主页--二级分类列表--id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ ",一级分类id"+s.getOneId());
        		}
        	}
        	// 获取 课程列表
			courseList = courseService.selectAllOnlineCoursePage(first, pageSize);
			// 设置分页属性
			total = courseService.selectAllOnlineCourseNumber();
			if( total == 0 ){
    			pageModel.setPage(0);			// 当前页--用于页面显示
    		}
    		pageModel.setTotalSize(total);		// 总条数--用于页面显示
    		int totalPage = 0;	// 定义总页数
    		if( total%pageSize == 0 ){
    			totalPage = total/pageSize;	
    		}else{
    			totalPage = total/pageSize+1;
    		}
    		pageModel.setTotalPage(totalPage);	//总页数--用于页面显示
    		
    	}else{
    		// 判断编码是否在一级分类中；先通过此编码查找一级分类对象，判断是否存在，若存在，则是一级分类编码；若不存在，则是二级分类编码。
    		SortsOne sortsOne = new SortsOne();
    		sortsOne = sortsOneService.getSortsOneByOneCode(c);
    		if( sortsOne != null ){	// 若一级分类对象不为空，说明该编码时一级分类编码
    			String oneCode = sortsOne.getOneCode();
    			// 在session中存储 一级分类和二级分类的编码值，用于页面设置样式
        		session.setAttribute("direction", c);
            	session.setAttribute("classify", -2);
            	
            	// 根据一级分类编码获得一级分类id, 然后根据一级分类id，获得二级分类数据； 返回给页面    
            	List<SortsTwo> sortsTwoList = new ArrayList<SortsTwo>();
            	sortsTwoList = sortsTwoService.getAllSortsTwoByOneId(sortsOne.getOneId());
            	if( sortsTwoList != null && sortsTwoList.size() > 0 ){
            		request.setAttribute("sortsTwoList", sortsTwoList);
            		for(SortsTwo s : sortsTwoList) {
            			System.out.println("\n/course/total-------课程主页--二级分类列表--id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ ",一级分类id"+s.getOneId());
            		}
            	}
            	courseList = courseService.getAllCoursePageByOneCode(oneCode, first, pageSize);
            	// 设置分页属性
    			total = courseService.getAllCoursePageNumberByOneCode(oneCode);
    			if( total == 0 ){
        			pageModel.setPage(0);			// 当前页--用于页面显示
        		}
        		pageModel.setTotalSize(total);		// 总条数--用于页面显示
        		int totalPage = 0;	// 定义总页数
        		if( total%pageSize == 0 ){
        			totalPage = total/pageSize;	
        		}else{
        			totalPage = total/pageSize+1;
        		}
        		pageModel.setTotalPage(totalPage);	//总页数--用于页面显示
            	/*// 根据二级分类数据获得课程信息，返回给页面
            	// 遍历二级分类列表
            	for (SortsTwo sortsTwo : sortsTwoList) {
            		List<Course> courseListTest = new ArrayList<Course>();
            		// 通过二级分类id获得 课程列表
            		courseListTest = courseService.getAllCourseByTwoId(sortsTwo.getTwoId(), first, pageSize);
            		for (Course course : courseListTest) {
            			courseList.add(course);
					}
				}*/
            	
            	
            	
            	
    		}else{	// 否则就是二级分类的编码
    			// 通过二级分类编码-- 获取二级分类对象，--进而获得一级分类id+对象+编码
    			int oneId = sortsTwoService.getSortsTwoByTwoCode(c).getOneId();
    			System.out.println("-----------------一级分类id------oneId:" + oneId);
    			SortsOne sortsOne1 = new SortsOne();
    			sortsOne1 = sortsOneService.getSortsOne(oneId);
    			System.out.println("------------------一级分类编码-----sortsOne1:" + sortsOne1.getOneCode());
    			
    			// 在session中存储 一级分类和二级分类的编码值，用于页面设置样式
        		session.setAttribute("direction", sortsOne1.getOneCode());
            	session.setAttribute("classify", c);
            	
            	// 根据一级分类编码获得一级分类id, 然后根据一级分类id，获得二级分类数据； 返回给页面    
            	List<SortsTwo> sortsTwoList = new ArrayList<SortsTwo>();
            	sortsTwoList = sortsTwoService.getAllSortsTwoByOneId(oneId);
            	if( sortsTwoList != null && sortsTwoList.size() > 0 ){
            		request.setAttribute("sortsTwoList", sortsTwoList);
            		for(SortsTwo s : sortsTwoList) {
            			System.out.println("\n/course/total-------课程主页--二级分类列表--id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ ",一级分类id"+s.getOneId());
            		}
            	}
            	
            	// 通过二级分类编码-- 获取二级分类对象---进而获得二级分类id
            	SortsTwo sortsTwo = new SortsTwo();
            	sortsTwo = sortsTwoService.getSortsTwoByTwoCode(c);
            	// 根据二级分类id--获取课程列表信息，返回给页面
            	courseList = courseService.getAllCourseByTwoId(sortsTwo.getTwoId(), first, pageSize);
            	// 设置分页属性
    			total = courseService.getAllCourseNumberByTwoId(sortsTwo.getTwoId());
    			if( total == 0 ){
        			pageModel.setPage(0);			// 当前页--用于页面显示
        		}
        		pageModel.setTotalSize(total);		// 总条数--用于页面显示
        		int totalPage = 0;	// 定义总页数
        		if( total%pageSize == 0 ){
        			totalPage = total/pageSize;	
        		}else{
        			totalPage = total/pageSize+1;
        		}
        		pageModel.setTotalPage(totalPage);	//总页数--用于页面显示
    		}
    	}
    	
    	if( courseList != null && courseList.size() > 0 ){
    		// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
			// 创建 courseDtoList 用来存储包装后的集合数据, 来返回给页面
			List<CourseDto> courseDtoList = new ArrayList<CourseDto>();
			int count = 0;	// 学习人数
			for(Course c1: courseList){ 
				// 通过课程id 查询课程总时长
				int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
				c1.setCourseTotalTime(videoTime);
				
				// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
				String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
				// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
				count = learnService.getLearnNumberByCourseId(c1.getCourseId());
				CourseDto courseDto = new CourseDto();
				courseDto.setSortsTwoName(sortsTwoName);
				courseDto.setCourse(c1);
				courseDto.setNumber(count);
				courseDtoList.add(courseDto);
			}
			// 把包装的数据返回给页面
    		pageModel.setCourseDtoList(courseDtoList);
			System.out.println("\n/course/total-------一级分类编码选的是全部，二级分类选的是全部-----courseDtoList：" + courseDtoList);
    	}
    	request.setAttribute("pageModel", pageModel);
    	
    	return "course";
    }
    
    /**
   	 * 	课程主页
   	 */
    @RequestMapping(value = "/course")  
    public String course(HttpServletRequest request, HttpSession session){
    	System.out.println("\n");
    	
    	String page = "";
    	//分页
    	List<Course> courseList = new ArrayList<Course>();
    	Page pageModel = new Page();
    	if( page == null || page == "" || page.equals("") ){
    		pageFirst = 1;
    	}else{
    		pageFirst = Integer.parseInt(page);
    	}
    	pageModel.setPage(pageFirst);	//当前页
    	pageModel.setSize(pageSize);	//每页的条数
    	int first = (pageFirst-1)*pageSize;	// limit第一个参数 
    	int total = 0;
    	
    	// 获取一级分类的数据 返回给页面    
    	List<SortsOne> sortsOneList = sortsOneService.selectAllSortsOne();
    	if( sortsOneList != null ){
    		request.setAttribute("sortsOneList", sortsOneList);
    		for(SortsOne s : sortsOneList) {
    			System.out.println("\n/course---------课程主页--一级分类列表--id:" + s.getOneId() + ", 一级分类名字:" + s.getOneName() + ", 一级分类编码:" + s.getOneCode());
    		}
    	}
    	// 获取二级分类的数据 返回给页面    
    	List<SortsTwo> sortsTwoList = sortsTwoService.selectAllSortsTwo();
    	if( sortsTwoList != null ){
    		request.setAttribute("sortsTwoList", sortsTwoList);
    		for(SortsTwo s : sortsTwoList) {
    			System.out.println("\n/course---------课程主页--二级分类列表--id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ ",一级分类id"+s.getOneId());
    		}
    	}
    	
    	// 获取 课程列表
		courseList = courseService.selectAllOnlineCoursePage(first, pageSize);
		if( courseList != null && courseList.size() > 0 ){
			// ----------------------包装数据(添加  二级分类名字+课程学习人数)------------------------------------
			// 创建 courseDtoList 用来存储包装后的集合数据, 来返回给页面
			List<CourseDto> courseDtoList = new ArrayList<CourseDto>();
			int count = 0;	// 学习人数
			for(Course c1: courseList){ 
				// 通过课程id 查询课程总时长
				int videoTime = courseService.selectCourseTotalTimeSecond(c1.getCourseId());
				c1.setCourseTotalTime(videoTime);
				
				// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
				String sortsTwoName = sortsTwoService.getSortsTwo(c1.getTwoId()).getTwoName();
				// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
				count = learnService.getLearnNumberByCourseId(c1.getCourseId());
				CourseDto courseDto = new CourseDto();
				courseDto.setSortsTwoName(sortsTwoName);
				courseDto.setCourse(c1);
				courseDto.setNumber(count);
				courseDtoList.add(courseDto);
			}
			// 设置分页属性
			total = courseService.selectAllOnlineCourseNumber();
			if( total == 0 ){
				pageModel.setPage(0);			// 当前页--用于页面显示
			}
			pageModel.setTotalSize(total);		// 总条数--用于页面显示
			int totalPage = 0;	// 定义总页数
			if( total%pageSize == 0 ){
				totalPage = total/pageSize;	
			}else{
				totalPage = total/pageSize+1;
			}
			pageModel.setTotalPage(totalPage);	//总页数
			// 设置属性
			pageModel.setCourseDtoList(courseDtoList);
			System.out.println("\n/course---------一级分类编码选的是全部，二级分类选的是全部-----courseDtoList：" + courseDtoList);
		}
		// 把包装的数据返回给页面
		request.setAttribute("pageModel", pageModel);
		
    	
    	// 在session中存储 一级分类和二级分类的编码值，用于页面设置样式
    	session.setAttribute("direction", -1);
    	session.setAttribute("classify", -2);
        return "course";
    }
    
    
    /**
     * 课程学习页面
     */
    @RequestMapping(value = "/course/learn")  
    public String courseLearn(@RequestParam(value="courseId", defaultValue="0") int courseId, HttpServletRequest request, HttpSession session){
    	System.out.println("\n/course/learn-->课程学习页面----courseId:" + courseId );
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
    	int number = 0;	// 学习人数
    	number = learnService.getLearnNumberByCourseId(courseId);
    	
    	// 封装课程包装类--用于页面显示课程相关数据
    	Course course = new Course();
		course = courseService.getCourse(courseId);
		// 通过课程id 查询课程总时长
		int videoTime = courseService.selectCourseTotalTimeSecond(course.getCourseId());
		course.setCourseTotalTime(videoTime);
		
		System.out.println("/course/learn-->课程学习页面--course:"+course);
		CourseDto courseDto = new CourseDto();
		courseDto.setCourse(course);
		courseDto.setNumber(number);
		// 返回课程包装类的数据--用于页面显示
		request.setAttribute("courseDto", courseDto);
    	
    	// 通过课程id--获取章节表数据+小节表数据-->返回给页面
		List<Chapter> chapterList = new ArrayList<Chapter>();
		chapterList = chapterService.getChapterAndSmallChapter(courseId);	
		System.out.println("/course/learn-->课程学习页面--章节(包括小节)列表数据--chapterList:" + chapterList);
		// 返回---章节表和小节表的数据--用于页面显示
		request.setAttribute("chapterList", chapterList);
		if( chapterList.size() > 0 ){
			// 返回课程的第一章第一小节的对象，用于页面上显示--课程的第一章第一小节id
			request.setAttribute("smallChapterFirst", chapterList.get(0).getSmallChapterList().get(0)); 
		}
    	
    	// 通过课程id--获取评论表数据+提问表数据库+笔记表数据 -->返回给页面
		List<Comments> commentsList = new ArrayList<Comments>();
		List<Question> questionList = new ArrayList<Question>();
		List<Note> noteList = new ArrayList<Note>();
		System.out.println("/course/learn-->课程学习页面------courseId:" + courseId);
		commentsList = commentsService.getCommentsByCourseId(courseId);
		questionList = questionService.getQuestionByCourseId(courseId);
		noteList = noteService.getNoteByCourseId(courseId);
		System.out.println("/course/learn-->课程学习页面--评论列表数据--commentsList:" + commentsList);
		System.out.println("/course/learn-->课程学习页面--问题列表数据--questionList:" + questionList);
		System.out.println("/course/learn-->课程学习页面--笔记列表数据--noteList:" + noteList);
		// 返回---评论表数据+提问表数据库+笔记表数据--用于页面显示
		request.setAttribute("commentsList", commentsList);
		request.setAttribute("questionList", questionList);
		request.setAttribute("noteList", noteList);
    	
    	// 判断用户是否登录
    	if( user != null ){	// 用户已登录
    		if( courseId != 0){
        		// 通过 用户id+课程id 查找 存放用户已经学习过的该课程的视频(的学习记录)---包含小节表对象+章节表对象---用于显示每个小节对应的学习状态
        		// 因为是通过时间逆序排的，所以第一条记录是 用户最近一次学习的该课程的视频是 那个小节(的一条学习记录)
        		List<Learn> learnList = new ArrayList<Learn>();
        		learnList = learnService.getAllLearnByUserIdAndCourseId(user.getUserId(), courseId);
        		System.out.println("/course/learn-->课程学习页面--学习记录(包括小节+章节)列表数据--learnList:" + learnList);
        		// 返回---章节表和小节表的数据--用于页面显示
        		request.setAttribute("learnList", learnList);
        		if( learnList.size() > 0 ){
        			request.setAttribute("learnFirst", learnList.get(0));	// 用户最近一次学习的该课程的视频是 那个小节(的一条学习记录)
        		}
        			
        		// 当用户登录后--判断用户是否收藏了该课程(通过课程id和用户id 从收藏表中判断是否有这条记录，若有则表示已收藏，否则未收藏)
        		Collect collect = collectService.isOrNotCollect(user.getUserId(), courseId);
        		if( collect != null ){	//该用户已收藏此课程
        			request.setAttribute("collect", collect);
        		}
        		
        		return "course-learn";
        	}else{
        		return "error";
        	}
    	}else{	//用户未登录
    		if( courseId != 0){
        		return "course-learn";
        	}else{
        		return "error";
        	}
    	}
    }
    
    /**
     * 收藏课程
     */
    @RequestMapping(value = "/isOrNotCollect", method = RequestMethod.POST)
    public void isOrNotCollect(Collect c, HttpServletResponse response, HttpServletRequest request){
    	System.out.println("/isOrNotCollect----是否收藏了该课程---collect：" + c);
    	
    	String result = "{\"result\":\"0\"}";
    	
    	Collect collect = new Collect();
    	collect = collectService.isOrNotCollect(c.getUserId(), c.getCourseId());
    	if( collect != null	 ){ //用户已收藏了该门课程-----应该把此课程取消收藏，即删除
    		int collectId = collect.getCollectId();
    		int deleteResult = collectService.deleteCollect(collectId);
    		if( deleteResult == 1 ){
    			System.out.println("/isOrNotCollect----收藏---该课程取消收藏成功！！！");
    			result = "{\"result\":\"1\"}";
    		}else{
    			System.out.println("/isOrNotCollect----收藏---该课程取消收藏失败。。");
    			result = "{\"result\":\"2\"}";
    		}
    	}else{	//用户未收藏了该门课程-----应该把此课程收藏，即添加
    		// 通过课程id获取课程信息和二级分类信息
    		int courseId = c.getCourseId();
    		Course course = new Course();
    		course = courseService.getCourse(courseId);
    		int twoId = course.getTwoId();
    		SortsTwo sortsTwo = new SortsTwo();
    		sortsTwo = sortsTwoService.getSortsTwo(twoId);
    		
    		// 通过用户id获取用户信息
    		User user = new User();
    		user = userService.getUser(c.getUserId());
    		
    		// 将该用户 对应的该门课程信息  添加到收藏表中
    		DateUtil date = new DateUtil();
    		Collect collection = new Collect();
    		collection.setUserId(user.getUserId());
    		collection.setCourseId(course.getCourseId());
    		collection.setCourseName(course.getCourseName());
    		collection.setCollectTime(date.getCurrentTime());
    		collection.setClassId(sortsTwo.getTwoId());
    		collection.setClassCode(sortsTwo.getTwoCode());
    		collection.setClassName(sortsTwo.getTwoName());
    		
    		int addResult = collectService.addCollect(collection);
    		if( addResult == 1 ){
    			System.out.println("/isOrNotCollect----收藏---该课程收藏成功！！！");
    			result = "{\"result\":\"3\"}";
    		}else{
    			System.out.println("/isOrNotCollect----收藏---该课程收藏失败。。");
    			result = "{\"result\":\"4\"}";
    		}
    	}
    	
    	// request.setAttribute("collect", collect);
    	
    	// 定义输出流，返回结果
    	response.setContentType("application/json");
    	PrintWriter out = null;
    	try {
			out = response.getWriter();
			out.write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    
    /**
     * 视频学习页面----说明：到达此请求时，用户已登录
     */
    @RequestMapping(value = "/course/video")  
    public String courseVideo(@RequestParam("courseId") int courseId, @RequestParam("smallChapterId") int smallChapterId, HttpServletRequest request, HttpSession session){
    	System.out.println("\n/course/video-->视频学习页面----courseId:" + courseId + ", smallChapterId:" + smallChapterId);
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){	// 用户已登录
    		Course course = new Course();
    		course = courseService.getCourse(courseId);
    		// 通过课程id 查询课程总时长
    		int videoTime = courseService.selectCourseTotalTimeSecond(course.getCourseId());
    		course.setCourseTotalTime(videoTime);
    		
        	// -->返回给页面--课程表 (用于课程名显示和课程id在url中传参数)
        	request.setAttribute("course", course);
    		
    		// 通过用户id和小节id,查找学习记录表中是否有这条数据。如果没有,添加这条学习记录，学习状态为0，时间点为0，从头开始播放
    		// 如果有，判断学习状态是0还是1，若是0则取出已经观看到的时间点，若是1则从头开始播放；
    		Learn learn = new Learn();
    		learn = learnService.getLearnByUserIdAndSmallChapterId(user.getUserId(), smallChapterId);
    		System.out.println("/course/video-->视频学习页面------learn：" + learn);
    		int chapterId = smallChapterService.getSmallChapter(smallChapterId).getChapterId();	// 通过小节id获取章节id
    		DateUtil date = new DateUtil();
    		if( learn != null ){
    			// 如果数据库有当前小节记录， 不管学习状态是0还是1，点进去播放的都是上次播放的记录
    			/*// ---判断学习状态是0还是1。若是1，表示已看完，则重置 已看时间为0   */    			
    			// 更新学习记录表中的时间
    			learn.setLearnTime(date.getCurrentTime());
    			int updateResult = learnService.updateLearn(learn);
    			if( updateResult == 1 ){
    				System.out.println("/course/video-->视频学习页面------更新学习记录表中的时间成功！！！");
    			}else{
    				System.out.println("/course/video-->视频学习页面------更新学习记录表中的时间失败。。。");
    			}
    		}else{
    			learn = new Learn();
    			learn.setUserId(user.getUserId());
    			learn.setCourseId(courseId);
    			learn.setChapterId(chapterId);
    			learn.setSmallChapterId(smallChapterId);
    			learn.setLearnTime(date.getCurrentTime());
    			learn.setLearnStatus(0);
    			learn.setLearnUseTime(0);
    			int addResult = learnService.addLearn(learn);
    			if( addResult == 1 ){
    				System.out.println("/course/video-->视频学习页面------添加新的学习记录成功！！！");
    			}else{
    				System.out.println("/course/video-->视频学习页面------添加新的学习记录失败。。。");
    			}
    		}
    		
    		// 通过小节id,获取当前选中观看的这一条小节记录
    		SmallChapter smallChapter = new SmallChapter();
    		smallChapter = smallChapterService.getSmallChapter(smallChapterId);
    		// 返回当前选中观看的这一条小节记录----用于显示当前视频的路径+这节视频结束时的记录
    		request.setAttribute("smallChapter", smallChapter);
    		// 得到下一小节视频的小节记录-----通过章节id和小节顺序(传入的还是小节id)
    		SmallChapter nextSmallChapter = new SmallChapter();
    		// 通过章节id和小节顺序(传入的还是小节id)----即得到的是当前章的下一节记录
    		nextSmallChapter = smallChapterService.getNextSmallChapByChapIdAndSmallChapId(chapterId, smallChapterId);
    		if( nextSmallChapter != null ){	// 如果当前章的下一节记录不为空
    			request.setAttribute("nextSmallChapter", nextSmallChapter);
    		}else{	// 如果当前章的下一节记录为空，则查找下一章节的第一节
    			
    			nextSmallChapter = new SmallChapter();
    			System.out.println("/course/video-->视频学习页面------下一章节的第一节1-----nextSmallChapter:" + nextSmallChapter);
    			nextSmallChapter = smallChapterService.getNextChapFirstSmallChapIdBySmallChapId(smallChapterId);
    			System.out.println("/course/video-->视频学习页面------下一章节的第一节2-----nextSmallChapter:" + nextSmallChapter);
    			if( nextSmallChapter != null ){
    				request.setAttribute("nextSmallChapter", nextSmallChapter);
    			}
    		}
    		
    		// 通过课程id--获取章节表数据+小节表数据-->返回给页面
    		List<Chapter> chapterList = new ArrayList<Chapter>();
    		chapterList = chapterService.getChapterAndSmallChapter(courseId);	
    		System.out.println("/course/video-->视频学习页面--章节(包括小节)列表数据--chapterList:" + chapterList);
    		// 返回---章节表和小节表的数据--用于页面显示
    		request.setAttribute("chapterList", chapterList);
    		
    		// 通过 用户id+课程id 查找 存放用户已经学习过的该课程的视频(的学习记录)---包含小节表对象+章节表对象---用于显示每个小节对应的学习状态
    		// 因为是通过时间逆序排的，所以第一条记录是  用户最近一次学习的该课程的视频是 那个小节(的一条学习记录)
    		List<Learn> learnList = new ArrayList<Learn>();
    		learnList = learnService.getAllLearnByUserIdAndCourseId(user.getUserId(), courseId);
    		System.out.println("/course/video-->课程学习页面--学习记录(包括小节+章节)列表数据--learnList:" + learnList);
    		// 返回---学习记录表记录的 章节表和小节表的数据--用于页面显示
    		request.setAttribute("learnList", learnList);
    		if( learnList.size() > 0 ){
    			request.setAttribute("learnFirst", learnList.get(0));	// 用户最近一次学习的该课程的视频是 那个小节(的一条学习记录)
    		}
    		
    		
    		// 通过课程id--获取评论表数据+提问表数据库+笔记表数据 -->返回给页面
    		List<Comments> commentsList = new ArrayList<Comments>();
    		List<Question> questionList = new ArrayList<Question>();
    		List<Note> noteList = new ArrayList<Note>();
    		System.out.println("/course/video-->视频学习页面------courseId:" + courseId);
    		commentsList = commentsService.getAllCommentsByCourseId(courseId);
    		questionList = questionService.getAllQuestionByCourseId(courseId);
    		noteList = noteService.getAllNoteByCourseId(courseId);
    		System.out.println("/course/video-->视频学习页面--评论列表数据--commentsList:" + commentsList);
    		System.out.println("/course/video-->视频学习页面--问题列表数据--questionList:" + questionList);
    		System.out.println("/course/video-->视频学习页面--笔记列表数据--noteList:" + noteList);
    		// 返回---评论表数据+提问表数据库+笔记表数据--用于页面显示
    		request.setAttribute("commentsList", commentsList);
    		request.setAttribute("questionList", questionList);
    		request.setAttribute("noteList", noteList);
    		
            return "course-video";
    	}else{
    		request.setAttribute("errorMsg", "请先登陆");
    		return "error";
    	}
    }
    
    /**
     * 视频学习页面----ajax请求，当视频看完时，更新数据库中学习记录表中的状态为1
     */
    @RequestMapping(value = "/course/video/updateLearnStatus")  
    @ResponseBody //必须加的注解
    public String courseVideoUpdateLearnStatus(int learnId, HttpSession session){
    	String res = "{\"result\": 0}";
    	
    	DateUtil date = new DateUtil();
    	Learn learn = new Learn();
    	learn = learnService.getLearn(learnId);
    	learn.setLearnStatus(1);
    	learn.setLearnTime(date.getCurrentTime());
    	int updateResult = learnService.updateLearn(learn);
    	if( updateResult == 1 ){
    		res = "{\"result\": 1}";
    	}
    	
    	return res;
    }
    
    /**
     * 视频学习页面----ajax请求，更新--视频观看的进度
     */
    @RequestMapping(value = "/course/video/updateLearnUseTime")  
    @ResponseBody //必须加的注解
    public String courseVideoUpdateLearnUseTime(int learnId, int learnUseTime, HttpSession session){
    	System.out.println("\n/course/video/updateLearnUseTime-------learnId: " + learnId + ", learnUseTime: " + learnUseTime);
    	String res = "{\"result\": 0}";
    	
    	Learn learn = new Learn();
    	learn = learnService.getLearn(learnId);
    	learn.setLearnUseTime(learnUseTime);
    	int updateResult = learnService.updateLearn(learn);
    	if( updateResult == 1 ){
    		res = "{\"result\": 1}";
    	}
    	
    	return res;
    }
    
    
    /**
     * 	course-learn课程学习页面--点击评论--到评论面板
     */
    @RequestMapping(value = "/course/learn/comment")
    public String courseLearnComment(@Param("courseId") int courseId, HttpServletRequest request, HttpSession session){
    	System.out.println("\n/course/learn/comment-----课程学习页面--点击评论--到评论面板-----courseId:" + courseId);
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	// 通过课程id--获取评论表数据 -->返回给页面
		List<Comments> commentsList = new ArrayList<Comments>();
		commentsList = commentsService.getCommentsByCourseId(courseId);
		System.out.println("/course/learn/comment-->到评论面板--评论列表数据--commentsList:" + commentsList);
		// 返回---评论表数据--用于页面显示
		request.setAttribute("commentsList", commentsList);
		request.setAttribute("courseId", courseId);
		request.setAttribute("user", user);
    	return "course-learnComment";
    }
    
    /**
     * 	发表评论--commentsAdd添加评论
     */
    @RequestMapping(value = "/comments/add")
    public String commentsAdd(HttpServletRequest request, HttpSession session){
    	String commentsContent = request.getParameter("commentsContent");
    	System.out.println("\n/comments/add---------添加评论---------commentsContent:" + commentsContent);
    	int courseId = Integer.parseInt(request.getParameter("courseId"));
    	
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	DateUtil date = new DateUtil();
    	// 获取评论记录数据--添加评论----(没有小节,使小节id=0)
    	Comments comment = new Comments();
    	comment.setUserId(user.getUserId());			// 用户id
    	comment.setCourseId(courseId);					// 课程id
    	comment.setSmallChapterId(0);					// 小节id-----默认为0
    	comment.setCommentsContent(commentsContent);	// 评论内容
    	comment.setCommentsTime(date.getCurrentTime());	// 评论时间
    	comment.setCommentsThumbsNumber(0);				// 点赞量-----默认为0
    	int addResult = commentsService.addComments(comment);
    	if( addResult == 1 ){
    		System.out.println("/comments/add---------添加评论成功!!!");
    	}else{
    		System.out.println("/comments/add---------添加评论失败........");
    	}
    	
    	// 通过课程id--获取评论表数据(关联了评论表+用户表) -->返回给页面
		List<Comments> commentsList = new ArrayList<Comments>();
		commentsList = commentsService.getCommentsByCourseId(courseId);
		System.out.println("/course/learn/comment-->到评论面板--评论列表数据--commentsList:" + commentsList);
		// 返回---评论表数据+提问表数据库+笔记表数据--用于页面显示
		request.setAttribute("commentsList", commentsList);
		request.setAttribute("courseId", courseId);
		request.setAttribute("user", user);
    	
    	return "course-learnComment";
    }
    
    /**
     * 	course-video课程视频学习页面--点击问答--到问答面板
     */
    @RequestMapping(value = "/course/video/question")
    public String courseLearnQuestion(@Param("courseId") int courseId, HttpServletRequest request, HttpSession session){
    	System.out.println("\n/course/video/question-----课程视频学习页面--点击问答--到问答面板-----courseId:" + courseId);
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	// 通过课程id--获取提问表数据(关联了问题表+用户表 ) -->返回给页面
		List<Question> questionList = new ArrayList<Question>();
		questionList = questionService.getQuestionByCourseId(courseId);
		System.out.println("/course/video/question-->到问答面板--问答列表数据--questionList:" + questionList);
		// 返回---提问表数据库--用于页面显示
		request.setAttribute("questionList", questionList);
		request.setAttribute("courseId", courseId);
		request.setAttribute("user", user);
    	return "course-videoQuestion";
    }
    
    /**
     * 	course-video课程视频学习页面--点击笔记--到笔记面板
     */
    @RequestMapping(value = "/course/video/note")
    public String courseLearnNote(@Param("courseId") int courseId, HttpServletRequest request, HttpSession session){
    	System.out.println("\n/course/video/note-----课程视频学习页面--点击笔记--到笔记面板-----courseId:" + courseId);
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	
    	// 通过课程id--获取提问表数据(关联了问题表+用户表 ) -->返回给页面
    	List<Note> noteList = new ArrayList<Note>();
    	noteList = noteService.getNoteByCourseId(courseId);
		System.out.println("/course/video/note-->到笔记面板--笔记列表数据--noteList:" + noteList);
		// 返回---提问表数据库--用于页面显示
		request.setAttribute("noteList", noteList);
		request.setAttribute("courseId", courseId);
		request.setAttribute("user", user);
    	
    	return "course-videoNote";
    }
   
    
    
    /**
     * 	course-video课程视频学习页面-添加问题/course/question/add
     */
    @RequestMapping(value = "/course/question/add")  
    public String courseQuestionAdd(Question q, HttpServletRequest request, HttpSession session){
    	System.out.println("/course/question/add---------添加提问----courseId:" + q.getCourseId()+", questionContent:"+q.getQuestionContent()+", questionTitle:"+q.getQuestionTitle()+", userId:"+q.getUserId());
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	DateUtil date = new DateUtil();
    	// 获取问题记录数据--添加问题----(没有小节,使小节id=0)
    	Question question = new Question();
    	question.setUserId(user.getUserId());				// 用户id
    	question.setCourseId(q.getCourseId());				// 课程id
    	question.setSmallChapterId(0);						// 小节id-----默认为0
    	question.setQuestionTitle(q.getQuestionTitle());	// 提问标题
    	question.setQuestionContent(q.getQuestionContent());// 提问内容
    	question.setQuestionTime(date.getCurrentTime());	// 提问时间
    	question.setQuestionScanNumber(0);					// 浏览量-----默认为0
    	int addResult = questionService.addQuestion(question);
    	if( addResult == 1 ){
    		System.out.println("/course/question/add---------添加提问记录成功!!!");
    	}else{
    		System.out.println("/course/question/add---------添加提问记录失败........");
    	}
    	
    	// 通过课程id--获取提问表数据(关联了问题表+用户表 ) -->返回给页面
		List<Question> questionList = new ArrayList<Question>();
		questionList = questionService.getQuestionByCourseId(q.getCourseId());
		System.out.println("/course/question/add--->添加完问答-->到问答面板--问答列表数据--questionList:" + questionList);
		// 返回---评论表数据+提问表数据库+笔记表数据--用于页面显示
		request.setAttribute("questionList", questionList);
		request.setAttribute("courseId", q.getCourseId());
		request.setAttribute("user", user);
    	
        return "course-videoQuestion";
    }
    
    /**
     * 	course-video课程视频学习页面-添加笔记/course/note/add
     */
    @RequestMapping(value = "/course/note/add")  
    public String courseNoteAdd(Note n, HttpServletRequest request, HttpSession session){
    	System.out.println("/course/note/add---------添加笔记----courseId:" + n.getCourseId()+", noteContent:"+n.getNoteContent()+", userId:"+n.getUserId());
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	DateUtil date = new DateUtil();
    	// 获取笔记记录数据--添加笔记----(没有小节,使小节id=0)
    	Note note = new Note();
    	note.setUserId(user.getUserId());				// 用户id
    	note.setCourseId(n.getCourseId());				// 课程id
    	note.setSmallChapterId(0);						// 小节id-----默认为0
    	note.setNoteTitle("");							// 笔记标题
    	note.setNoteContent(n.getNoteContent());		// 笔记内容
    	note.setNoteTime(date.getCurrentTime());		// 笔记时间
    	note.setNoteThumbsNumber(0);					// 点赞量-----默认为0
    	int addResult = noteService.addNote(note);
    	if( addResult == 1 ){
    		System.out.println("/course/note/add---------添加笔记成功!!!");
    	}else{
    		System.out.println("/course/note/add---------添加笔记失败........");
    	}
    	
    	// 通过课程id--获取笔记表数据(关联了笔记表+用户表 ) -->返回给页面
		List<Note> noteList = new ArrayList<Note>();
		noteList = noteService.getNoteByCourseId(n.getCourseId());
		System.out.println("/course/note/add--->添加完笔记-->到笔记面板--笔记列表数据--noteList:" + noteList);
		// 返回---评论表数据+提问表数据库+笔记表数据--用于页面显示
		request.setAttribute("noteList", noteList);
		request.setAttribute("courseId", n.getCourseId());
		request.setAttribute("user", user);
    	
        return "course-videoNote";
    }
    
//---------------------猿问-------------------------------------------------------------------------------------------------------    
    // 猿问页面
    @RequestMapping(value = "/question")  
    public String question(HttpServletRequest request){
    	String page1 = request.getParameter("page");
    	
    	if( page1 == null )
    		pageFirst = 1;
    	else{
    		pageFirst = Integer.parseInt(page1);
    	}
    	Page pageModel = new Page();
		pageModel.setPage(pageFirst);	// 当前页
		pageModel.setSize(pageSize);	// 每页显示的条数
		int total = questionService.selectAllQuestionAndUserTotal();
		
		int totalPage=0;	// 总页数
		if( total%pageSize == 0 ){
			totalPage=total/pageSize;	//总页数
		}else{
			totalPage=total/pageSize+1;
		}
		pageModel.setTotalPage(totalPage);
		
		int frist = (pageFirst-1)*pageSize;	// limit第一个参数
		List<Question> list = questionService.selectAllQuestionAndUser(frist,pageSize);
		
		//存储数据
		pageModel.setQuestionList(list);
		request.setAttribute("pageModel", pageModel);
		
		System.out.println("\n/question-->猿问页面--问题列表数据--frist:"+frist+"-pageSize:"+pageSize);
		if( pageModel.getQuestionList() != null ){
			System.out.println("\n/question-->猿问页面--问题列表数据----questionList:" + pageModel.getQuestionList());
		}
        return "question";
    }
    
    // 猿问--提问页面
    @RequestMapping(value = "/question/add")  
    public String questionAdd(HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){	// 用户已登录
	    	request.setAttribute("user", user);
	        return "question-add";
    	}else{
    		request.setAttribute("errorMsg", "请先登陆");
    		return "error";
    	}
    }
    
    // 猿问--添加提问记录
    @RequestMapping(value = "/question/add/success")  
    public String questionAddSuccess(Question q, HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){	// 用户已登录
	    	System.out.println("/question/add/success-------猿问--添加提问----userId:"+q.getUserId()+", questionContent:"+q.getQuestionContent()+", questionTitle:"+q.getQuestionTitle());
	    	DateUtil date = new DateUtil();
	    	// 获取问题记录数据--添加问题----(没有小节,使小节id=0)
	    	Question question = new Question();
	    	question.setUserId(q.getUserId());					// 用户id
	    	// question.setCourseId();							// 课程id-----猿问模块 没有课程
	    	question.setSmallChapterId(0);						// 小节id-----默认为0
	    	question.setQuestionTitle(q.getQuestionTitle());	// 提问标题
	    	question.setQuestionContent(q.getQuestionContent());// 提问内容
	    	question.setQuestionTime(date.getCurrentTime());	// 提问时间
	    	question.setQuestionReplyNumber(0);					// 回答量-----默认为0
	    	question.setQuestionScanNumber(0);					// 浏览量-----默认为0
	    	int addResult = questionService.addQuestion(question);
	    	if( addResult == 1 ){
	    		System.out.println("/question/add/success---------添加提问记录成功!!!");
	    	}else{
	    		System.out.println("/question/add/success---------添加提问记录失败........");
	    	}
	    	
	    	//重定向到猿问主页
	        return "redirect:/question";
	        
    	}else{
    		request.setAttribute("errorMsg", "请先登陆");
    		return "error";
    	}
    }
    
    // 猿问--回复页面
    @RequestMapping(value = "/question/reply")  
    public String questionReply(@Param("questionId") int questionId, HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){	// 用户已登录
	    	System.out.println("/question/reply----猿问--回复页面---questionId:" + questionId);
	    	
	    	// 用户从猿问主页--到-->猿问回复页面------>将问题的 浏览量+1
	    	int result = questionService.updateQuestionScanNumber(questionId);
	    	if( result == 1 ){
	    		System.out.println("/question/reply----猿问--回复页面---浏览量成功+1！！！");
	    	}else{
	    		System.out.println("/question/reply----猿问--回复页面---浏览量+1失败。。。");
	    	}
	    	
	    	Question question = new Question();
	    	// 通过提问id 获得一个提问表 对象(关联了提问表+用户表)
	    	question = questionService.getQuestionAndUser(questionId);
	    	
	    	// 获取此问题的回答记录list,先获取回答个数
	    	int replyNumber = replyService.getReplyCountByQuestionId(questionId);
	    	List<Reply> replyList = new ArrayList<Reply>();
	    	replyList = replyService.getAllReplyByQuestionId(questionId);
	    	System.out.println("/question/reply----猿问--回复页面---回答记录---replyList:" + replyList);
	    	
	    	request.setAttribute("question", question);
	    	request.setAttribute("user", user);
	    	request.setAttribute("replyNumber", replyNumber);
	    	request.setAttribute("replyList", replyList);
	        return "question-reply";
    	}else{
    		request.setAttribute("errorMsg", "请先登陆");
    		return "error";
    	}
    }
    
    // 猿问--添加回复
    @RequestMapping(value = "/question/reply/add")  
    public String questionReplyAdd(Reply r, HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){	// 用户已登录
	    	System.out.println("/question/reply/add-------猿问--添加回复----userId:"+r.getUserId()+", questionId:"+r.getQuestionId()+", replyContent:"+r.getReplyContent());
	    	DateUtil date = new DateUtil();
	    	// 获取回复记录数据--添加回复
	    	Reply reply = new Reply();
	    	reply.setUserId(r.getUserId());						// 用户id
	    	reply.setQuestionId(r.getQuestionId());				// 问题表id
	    	reply.setReplyContent(r.getReplyContent());			// 回复内容
	    	reply.setReplyTime(date.getCurrentTime());			// 提问时间
	    	reply.setReplyAgreeNumber(0);						// 赞成量-----默认为0
	    	reply.setReplyAgainstNumber(0);						// 反对量-----默认为0
	    	int addResult = replyService.addReply(reply);
	    	if( addResult == 1 ){
	    		System.out.println("/question/reply/add---------添加回复记录成功!!!");
	    	}else{
	    		System.out.println("/question/reply/add---------添加回复失败........");
	    	}
	    	
	    	// 更新 此问题的 回答量
	    	int replyNumberResult = questionService.updateQuestionReplyNumber(r.getQuestionId());
	    	if( replyNumberResult == 1 ){
	    		System.out.println("/question/reply/add---------添加此问题的 回答量成功!!!");
	    	}else{
	    		System.out.println("/question/reply/add---------添加此问题的 回答量失败........");
	    	}
	    	
	    	//重定向到猿问主页
	        return "redirect:/question/reply?questionId="+r.getQuestionId();
	        
    	}else{
    		request.setAttribute("errorMsg", "请先登陆");
    		return "error";
    	}
    }
    
//---------------------手记-------------------------------------------------------------------------------------------------------    
    /**
     * 手记页面
     */
    @RequestMapping(value = "/note")  
    public String note(HttpServletRequest request){
    	String page1 = request.getParameter("page");
    	
    	if( page1 == null )
    		pageFirst = 1;
    	else{
    		pageFirst = Integer.parseInt(page1);
    	}
    	Page pageModel = new Page();
		pageModel.setPage(pageFirst);	// 当前页
		pageModel.setSize(pageSize);	// 每页显示的条数
		int total = noteService.selectAllNoteAndUserTotal();
		
		int totalPage=0;	// 总页数
		if( total%pageSize == 0 ){
			totalPage=total/pageSize;	//总页数
		}else{
			totalPage=total/pageSize+1;
		}
		pageModel.setTotalPage(totalPage);
		
		int frist = (pageFirst-1)*pageSize;	// limit第一个参数
		List<Note> list = new ArrayList<Note>();
		list = noteService.selectAllNoteAndUser(frist,pageSize);
		
		//存储数据
		pageModel.setNoteList(list);
		request.setAttribute("pageModel", pageModel);
		
		if( pageModel.getNoteList() != null ){
			System.out.println("\n/note-->手记页面--笔记列表数据--noteList:" + pageModel.getNoteList());
		}
		System.out.println("\n/note-->手记页面--笔记列表数据--frist:"+frist+"-pageSize:"+pageSize);
    	
        return "note";
    }
    
    /**
   	 * 	手记--点赞功能
   	 */
    @RequestMapping(value = "/note/thumbsUp", method = RequestMethod.POST)  
    @ResponseBody
    public String noteThumbsUp(@RequestParam("noteId") int noteId, HttpServletRequest request, HttpSession session){
    	String res = "{\"res\": 0 }";
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	
    	// 该用户通过笔记id 来点赞
		if( user != null && noteId != 0 ){
			
    		int updateRseult = noteService.updateNoteThumbsUp(noteId);
    		if( updateRseult == 1 ){
    			res = "{\"res\": 1 }";
    			System.out.println("\n/manager/course/doSale-->后台管理--课程管理--更新课程上下架状态成功了！！！");
    		}else{
    			System.out.println("\n/manager/course/doSale-->后台管理--课程管理--更新课程上下架状态失败了。。。");
    		}
		}
		return res;
    }
    
    /**
     * 手记--添加手记
     */
    @RequestMapping(value = "/note/add")  
    public String noteAdd(Note n, HttpServletRequest request){
    	DateUtil date = new DateUtil();
    	// 获取笔记记录数据--添加笔记----(没有小节,使小节id=0)
    	Note note = new Note();
    	note.setUserId(n.getUserId());					// 用户id
    	note.setCourseId(0);							// 课程id-----默认为0
    	note.setSmallChapterId(0);						// 小节id-----默认为0
    	note.setNoteTitle("");							// 笔记标题
    	note.setNoteContent(n.getNoteContent());		// 笔记内容
    	note.setNoteTime(date.getCurrentTime());		// 笔记时间
    	note.setNoteThumbsNumber(0);					// 点赞量-----默认为0
    	int addResult = noteService.addNote(note);
    	if( addResult == 1 ){
    		System.out.println("/note/add--手记--添加手记-------添加手记成功!!!");
    	}else{
    		System.out.println("/note/add--手记--添加手记-------添加手记失败........");
    	}
    	
    	// 重定向到手记页面
        return "redirect:/note";
    }
   
//---------------------我的-------------------------------------------------------------------------------------------------------   
   
    /**
   	 * 	我的-->个人主页
   	 */
    @RequestMapping(value = "/me")  
    public String meHome(HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){
    		
    		// 获取我的学习时长
    		int learnTime = learnService.selectUserLearnTime(user.getUserId());	//单位秒
    		
    		// 获取我的学习--课程个数
    		int courseNumber = learnService.getCourseNumberByUserId(user.getUserId());
    		
    		// 获取我的收藏--课程个数
    		int collectNumber = collectService.getCollectNumberByUserId(user.getUserId());
    		
    		// 获取我的提问--个数
    		int questionNumber = questionService.getQuestionNumberByUserId(user.getUserId());
    		
    		// 获取我的回答--个数
    		int replyNumber = replyService.getReplyNumberByUserId(user.getUserId());
    		
    		// 获取我的笔记--个数
    		int noteNumber = noteService.getNoteNumberByUserId(user.getUserId());
    		
    		// 获取我关注的--人数
    		int followsNumber = fansService.getFollowsNumberByUserId(user.getUserId());
    		
    		// 获取我粉丝的--人数
    		int fansNumber = fansService.getFansNumberByUserId(user.getUserId());
    		
    		// 定义我的信息包装类----用于页面显示
    		MessageDto messageDto = new MessageDto();
    		messageDto.setLearnTime(learnTime);
    		messageDto.setCourseNumber(courseNumber);
    		messageDto.setCollectNumber(collectNumber);
    		messageDto.setQuestionNumber(questionNumber);
    		messageDto.setReplyNumber(replyNumber);
    		messageDto.setNoteNumber(noteNumber);
    		messageDto.setFollowsNumber(followsNumber);
    		messageDto.setFansNumber(fansNumber);
    		
    		//将包装的信息返回给页面
    		request.setAttribute("messageDto", messageDto);
    		System.out.println("\n/me-------我的-->个人主页------messageDto:"+messageDto);
    		
    		return "me/me";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "error";
    	}
    }
 
    /**
   	 * 	我的-->课程 页面
   	 */
    @RequestMapping(value = "/me/course")  
    public String meCourse(HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){
    		List<Learn> learnList = new ArrayList<Learn>();
        	learnList = learnService.getAllLearnByUserId(user.getUserId());
        	System.out.println("/me/course----我的-->课程 页面-----learnList：" + learnList);
        	request.setAttribute("learnList", learnList);
            return "me/me-course";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "error";
    	}
    }
 
    /**
   	 * 	我的-->收藏 页面
   	 */
    @RequestMapping(value = "/me/collect")  
    public String meCollect(HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){
    		List<Collect> collectList = new ArrayList<Collect>();
    		collectList = collectService.selectAllCollect(user.getUserId());
        	// System.out.println("/me/collect----我的-->收藏 页面-----collectList：" + collectList.get(0).toString());
        	request.setAttribute("collectList", collectList);
        	return "me/me-collect";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "error";
    	}
    }
 
    /**
   	 * 	我的-->个人信息
   	 */
    @RequestMapping(value = "/me/message")  
    public String meMessage(HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){
    		
    		// 通过用户账号  查询用户表 
    		User user1 = new User();
    		user1 = userService.getUser(user.getUserId());
        	System.out.println("\n/me/message-->我的个人信息---个人信息表数据----user1:" + user1);
        	request.setAttribute("user", user1);
    		
    		return "me/me-message";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "error";
    	}
    }
    
    /**
     *  我的-->个人信息修改
     */
    @RequestMapping(value = "/me/message/update")
    public String meMessageUpdate(User u, HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null && u != null ){
    		
    		System.out.println("\n/me/message/update-->我的个人信息修改------sex:" + u.getUserSex());
    		
    		// 通过用户修改信息--更新用户数据  
    		int updateRseult = userService.updateUserSelective(u);
    		if( updateRseult == 1 ){
    			System.out.println("\n/me/message/update-->我的个人信息修改成功了！！");
    		}else{
    			System.out.println("\n/me/message/update-->我的个人信息修改失败了。。。");
    		}
        	
    		return "redirect:/me/message";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "error";
    	}
    }
 
    /**
   	 * 	我的-->猿问 页面
   	 */
    @RequestMapping(value = "/me/answer")  
    public String meAnswer(HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){
    		
    		// 通过用户id  查询该用户提出的所有问题的记录(关联了评论表+用户表)
    		List<Question> questionList = new ArrayList<Question>();
        	questionList = questionService.selectAllQuestionByUserId(user.getUserId());
        	System.out.println("\n/me/answer-->我的猿问--我的问题-----我提出的所有问题---questionList:" + questionList);
        	request.setAttribute("questionList", questionList);
        	
        	
        	// 通过用户id  获取该用户所有的回答记录
	    	List<Reply> replyList = new ArrayList<Reply>();
	    	replyList = replyService.selectAllReplyByUserId(user.getUserId());
	    	System.out.println("/me/answer-->我的猿问--回答记录-----我回答的所有问题---replyList:" + replyList);
	    	request.setAttribute("replyList", replyList);
    		
    		return "me/me-answer";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "error";
    	}
    }
    
    /**
   	 * 	我的-->手记 页面
   	 */
    @RequestMapping(value = "/me/note")  
    public String meNote(HttpServletRequest request, HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){
    		
    		// 通过用户id  获取该用户所有的笔记
    		List<Note> noteList = new ArrayList<Note>();
        	noteList = noteService.selectAllNoteByUserId(user.getUserId());
        	System.out.println("\n/note-->手记页面--笔记列表数据--questionList:" + noteList);
        	request.setAttribute("noteList", noteList);
    		
    		return "me/me-note";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "error";
    	}
    }
    
  
}  