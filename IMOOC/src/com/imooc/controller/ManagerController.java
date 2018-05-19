package com.imooc.controller;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.imooc.common.DateUtil;
import com.imooc.dto.CourseDto;
import com.imooc.dto.CourseMessageDto;
import com.imooc.entity.*;
import com.imooc.service.*;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller  
@RequestMapping(value = "")  
public class ManagerController {  
    @Resource(name = "managerService")  
    ManagerService managerService;  
    @Resource(name = "sortsOneService")  
    SortsOneService sortsOneService;  
    @Resource(name = "sortsTwoService")  
    SortsTwoService sortsTwoService;
    @Resource(name = "userService")  
    UserService userService; 
    @Resource(name = "courseService")  
    CourseService courseService; 
    @Resource(name = "learnService")  
    LearnService learnService; 
    @Resource(name = "commentsService")  
    CommentsService commentsService; 
    @Resource(name = "questionService")  
    QuestionService questionService; 
    @Resource(name = "replyService")  
    ReplyService replyService; 
    @Resource(name = "noteService")  
    NoteService noteService;
    @Resource(name = "chapterService")  
    ChapterService chapterService; 
    @Resource(name = "smallChapterService")  
    SmallChapterService smallChapterService; 
    
    int pageSize = 10;	// 默认定义分页条数
    int pageFirst = 0;	// 当前页
    
    /**
   	 * 	-->后台管理登录页面
   	 */
    @RequestMapping(value = "/manager")  
    public String manager(HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		return "redirect:/manager/loginCheck";
    	}
        return "manager/manager-login";	
    }
    
    /**
   	 * 	-->后台管理登录页面
   	 */
    @RequestMapping(value = "/manager/login")  
    public String managerLogin(HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		return "redirect:/manager/loginCheck";
    	}
        return "manager/manager-login";	
    }
    
    /**
   	 * 	-->后台管理--退出-->到达登录页面
   	 */
    @RequestMapping(value = "/manager/layout")  
    public String managerLayout(HttpSession session){
    	System.out.println("\n/manager/layout---------管理员退出成功！！");
    	session.removeAttribute("manager");
    	session.invalidate();
        return "manager/manager-login";	
    }
    
    /**
	 * 	管理员登录验证成功-->后台管理页面
	 */
    @RequestMapping(value = "/manager/loginCheck")  
    public String manager(String account, String password, HttpServletRequest request, HttpSession session){
    	System.out.println("管理员登录---输入的账号和姓名："+account+","+password);
    	Manager manager = managerService.getManager(account);
    	if( manager != null ){	//如果不等于空说明账号正确
    		if( manager.getManagerPassword().equals(password) ){
				session.setAttribute("manager",manager);
				
				List<UserDateNumber> userDateNumberList = new ArrayList<UserDateNumber>();
		    	userDateNumberList = userService.getUserDateNumber();
		    	if( userDateNumberList != null && userDateNumberList.size() > 0 ){
		    		System.out.println("\n/manager/index----后台管理--主页-----最近一周内的用户注册人数---userDateNumberList:" + userDateNumberList);
		    		// 将list转成json用于页面js操作
		    		JSONArray json = JSONArray.fromObject(userDateNumberList);	//将java对象转换为json对象
		    		String userDateNumberListStr = json.toString();					//将json对象转换为字符串
		    		request.setAttribute("userDateNumberList", userDateNumberListStr);
		    	}
		    	
				return "manager/manager";
			}else{
				session.setAttribute("errMsg","密码错误！！");
				return "manager/manager-login";
			}
    	}else{
    		session.setAttribute("errMsg","账号不存在！！");	//账号不存在！
			return "manager/manager-login";
		}
    }
   
    /**
   	 * 	-->后台管理--主页
   	 */
    @RequestMapping(value = "/manager/index")  
    public String managerIndex(HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
    	List<UserDateNumber> userDateNumberList = new ArrayList<UserDateNumber>();
    	userDateNumberList = userService.getUserDateNumber();
    	if( userDateNumberList != null && userDateNumberList.size() > 0 ){
    		System.out.println("\n/manager/index----后台管理--主页-----最近一周内的用户注册人数---userDateNumberList:" + userDateNumberList);
    		// 将list转成json用于页面js操作
    		JSONArray json = JSONArray.fromObject(userDateNumberList);	//将java对象转换为json对象
    		String userDateNumberListStr = json.toString();					//将json对象转换为字符串
    		request.setAttribute("userDateNumberList", userDateNumberListStr);
    	}
    	
        return "manager/manager";
    }
    
    /**
   	 * 	-->后台管理--课程管理
   	 */
    @RequestMapping(value = "/manager/course", method = RequestMethod.GET)  
    public String managerCourse(HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
    	pageSize = 5;	// 每页显示的条数,设置为5条---页面看起来更好
    	
    	String oneCode = request.getParameter("oneCode");		//一级分类编码
    	String courseName = request.getParameter("courseName");	//课程名
    	String page = request.getParameter("page");				//传进来 要跳转的页数
    	// 搜索条件是否为空
    	if( courseName != null && courseName != "" ){ 
    		courseName = courseName.trim();			// 去除搜索的空格
    		// courseName = courseName.toUpperCase();	// 转成大写，实现大小写都能检索到
    		if( page == null || page == "" ){
    			System.out.println("\n/manager/course---oneCode:"+oneCode+", courseName:"+courseName+", page:1");
    		}else{
    			System.out.println("\n/manager/course---oneCode:"+oneCode+", courseName:"+courseName+", page:"+page);
    		}
    	}else{
    		if( page == null || page == "" ){
    			System.out.println("\n/manager/course---oneCode:"+oneCode+", courseName:"+courseName+", page:1");
    		}else{
    			System.out.println("\n/manager/course---oneCode:"+oneCode+", courseName:"+courseName+", page:"+page);
    		}
    	}
    	
    	// 分页
    	List<Course> courseList = new ArrayList<Course>();
    	Page pageModel = new Page();
    	if( page == null || page == "" ){
			pageFirst = 1;	// 当前页 设置为第一页
		}else{
			pageFirst = Integer.parseInt(page);// 当前页
		}
		pageModel.setPage(pageFirst);	// 当前页
		pageModel.setSize(pageSize);	// 每页显示的条数,默认10条
		int first = (pageFirst-1)*pageSize;	// limit第一个参数
		
		if( oneCode == null || oneCode == "" || oneCode.equals("-1") ){	// 此时，一级分类编码都不作为查询条件
			int total = 0;
    		total = courseService.getAllCourseNumberByCourseName(courseName);	// 总条数
    		if( total == 0 ){
    			pageModel.setPage(0);			// 当前页--用于页面显示
    		}
			pageModel.setTotalSize(total);		// 总条数
    		int totalPage = 0;	// 定义总页数
    		if( total%pageSize == 0 ){
    			totalPage = total/pageSize;	
    		}else{
    			totalPage=total/pageSize+1;
    		}
    		pageModel.setTotalPage(totalPage);	//总页数
    		
    		// 通过课程名   来模糊查询   分页的课程表的集合
    		courseList = courseService.getAllCourseByCourseName(courseName, first, pageSize);
    	}else{
    		int total = 0;
    		total = courseService.getAllCourseNumberByOneCodeAndCourseName(oneCode, courseName);	// 总条数
    		if( total == 0 ){
    			pageModel.setPage(0);			// 当前页--用于页面显示
    		}
    		pageModel.setTotalSize(total);		//总条数
    		int totalPage = 0;	// 定义总页数
    		if( total%pageSize == 0 ){
    			totalPage = total/pageSize;	
    		}else{
    			totalPage=total/pageSize+1;
    		}
    		pageModel.setTotalPage(totalPage);	//总页数
    		
    		// 通过一级分类+ 课程名模糊查询  分页的课程表的集合
    		courseList = courseService.getAllCourseByOneCodeAndCourseName(oneCode, courseName, first, pageSize);
    	}
		System.out.println("pageModel:---------limit第一个参数："+first+", 要跳转的页："+pageFirst+", 总页数："+pageModel.getTotalPage());
    	
		// 通过课程列表获取   封装之后的集合数据--->返回给页面
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
				int oneId = sortsTwoService.getSortsTwo(c1.getTwoId()).getOneId();
				SortsOne sortsOne = new SortsOne();
				sortsOne = sortsOneService.getSortsOne(oneId);
				User user = new User();
				user = userService.getUser(c1.getUserId());
				// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
				count = learnService.getLearnNumberByCourseId(c1.getCourseId());
				CourseDto courseDto = new CourseDto();
				courseDto.setOneId(oneId);
				courseDto.setOneName(sortsOne.getOneName());
				courseDto.setSortsTwoName(sortsTwoName);
				courseDto.setCourse(c1);
				courseDto.setNumber(count);
				if( user.getUserRealName() != null ){
					courseDto.setTeacher(user.getUserRealName());
				}
				courseDtoList.add(courseDto);
			}
			// 把包装的数据返回给页面
    		pageModel.setCourseDtoList(courseDtoList);
    		System.out.println("\n/manager/course-------课程列表全部---courseDtoList：" + courseDtoList);
		}
		request.setAttribute("pageModel", pageModel);
		
		// 获取一级分类的数据 返回给页面
    	List<SortsOne> sortsOneList = sortsOneService.selectAllSortsOne();
    	if( sortsOneList != null ){
    		request.setAttribute("sortsOneList", sortsOneList);
    		for(SortsOne s : sortsOneList) {
    			System.out.println("\n/manager/classify---->后台管理--课程分类页面--一级分类id:" + s.getOneId() + ", 一级分类名字:" + s.getOneName() + ", 一级分类编码:" + s.getOneCode());
    		}
    	}
    	
    	if( oneCode != null && oneCode != "" ){
			request.setAttribute("oneCode", oneCode);
		}
		if( courseName != null && courseName != "" ){
			request.setAttribute("courseName", courseName);
		}
    	
        return "manager/manager-course";
    }
    
    /**
   	 * 	-->后台管理--课程管理--到达添加课程页面
   	 */
    @RequestMapping(value = "/manager/course/addPage")  
    public String managerCourseAddPage(HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
    	// 获取一级分类的数据 返回给页面
    	List<SortsOne> sortsOneList = sortsOneService.selectAllSortsOne();
    	if( sortsOneList != null ){
    		request.setAttribute("sortsOneList", sortsOneList);
    		for(SortsOne s : sortsOneList) {
    			System.out.println("\n/manager/classify---->后台管理--课程分类页面--一级分类id:" + s.getOneId() + ", 一级分类名字:" + s.getOneName() + ", 一级分类编码:" + s.getOneCode());
    		}
    	}
    	
    	// 获取一级分类的数据 返回给页面
    	List<SortsTwo> sortsTwoList = sortsTwoService.selectAllSortsTwo();
    	if( sortsTwoList != null ){
    		request.setAttribute("sortsTwoList", sortsTwoList);
    		for(SortsTwo s : sortsTwoList) {
    			System.out.println("\n/manager/classify---->后台管理--课程分类页面--二级分类id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ "一级分类编码--id:" + s.getSortsOne().getOneCode());
    		}
    	}
    	
    	return "manager/manager-courseAdd";
    }
    
    /**
   	 * 	-->后台管理--课程管理--上下架改变
   	 */
    @RequestMapping(value = "/manager/course/doSale", method = RequestMethod.POST)  
    @ResponseBody
    public String managerCourseDoSale(@RequestParam("courseId") int courseId, @RequestParam("status") int status, HttpServletRequest request, HttpSession session){
    	String res = "{\"res\": 0 }";
    	// 通过课程id 更新课程上下架状态
		if( courseId != 0 ){
			// 通过课程信息--更新课程数据  
			Course course = new Course();
			course = courseService.getCourse(courseId);
			course.setCourseStatus(status);
			
    		int updateRseult = courseService.updateCourse(course);
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
   	 * 	-->后台管理--课程管理--添加/更新 课程之前校验
   	 */
    @RequestMapping(value = "/manager/course/addValidate", method = RequestMethod.POST)  
    @ResponseBody
    public String managerCourseAddValidate(@RequestParam("userId") String userId, HttpServletRequest request, HttpSession session){
    	String res = "{\"res\": 0 }";
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( userId != null && !userId.equals("") ){
    			User user = new User();
    			user = userService.getUser(userId);
    			if( user != null ){
    				res = "{\"res\": 1 }";
    				System.out.println("\n/manager/course/addValidate-->后台管理--课程管理--添加/更新 课程之前校验讲师登录名存在！！！");
    			}else{
        			System.out.println("\n/manager/course/addValidate-->后台管理--课程管理--添加/更新 课程之前校验讲师登录名不存在。。。");
        		}
    		}
    		return res;
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程管理--添加课程
   	 */
    @RequestMapping(value = "/manager/course/add", method = RequestMethod.POST)  
    public String managerCourseAdd(Course c, @RequestParam("twoCode")String twoCode, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( c != null ){
    			System.out.println("\n/manager/course/add---后台管理--课程管理--添加课程---Course:" + c);
    			
    			// 1、提交过来的是二级分类编码，需转换二级分类id(twoId)并赋值给要添加的课程对象
    			SortsTwo sortsTwo = new SortsTwo();
    			sortsTwo = sortsTwoService.getSortsTwoByTwoCode(twoCode);
    			int twoId = sortsTwo.getTwoId();
    			// 设置更新的  二级分类id
    			c.setTwoId(twoId);
    			
    			// 通过课程信息--删除课程数据  
        		int addRseult = courseService.addCourse(c);
        		if( addRseult == 1 ){
        			System.out.println("\n/manager/course/add-->后台管理--课程管理--添加课程信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/course/add-->后台管理--课程管理--添加课程信息修改失败了。。。");
        		}
    		}
    		return "redirect:/manager/course";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程管理--删除课程
   	 */
    @RequestMapping(value = "/manager/course/delete", method = RequestMethod.POST)  
    @ResponseBody
    public String managerCourseDelete(@RequestParam("courseId") int courseId, HttpServletRequest request, HttpSession session){
    	String res = "{\"res\": 0 }";
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( courseId != 0 ){
    			// 通过课程信息--删除课程数据  
        		int deleteRseult = courseService.deleteCourse(courseId);
        		if( deleteRseult == 1 ){
        			res = "{\"res\": 1 }";
        			System.out.println("\n/manager/course/delete-->后台管理--课程管理--删除课程信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/course/delete-->后台管理--课程管理--删除课程信息修改失败了。。。");
        		}
    		}
    		return res;
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程管理--更新课程
   	 */
    @RequestMapping(value = "/manager/course/update", method = RequestMethod.POST)  
    public String managerCourseUpdate(Course c, @RequestParam("twoCode")String twoCode, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( c != null ){
    			System.out.println("\n/manager/course/update---后台管理--课程管理--更新课程---Course:" + c);
    			
    			// 1、提交过来的是二级分类编码，需转换二级分类id(twoId)并赋值给要更新的课程对象
    			SortsTwo sortsTwo = new SortsTwo();
    			sortsTwo = sortsTwoService.getSortsTwoByTwoCode(twoCode);
    			int twoId = sortsTwo.getTwoId();
    			// 设置更新的  二级分类id
    			c.setTwoId(twoId);
    			
    			// 通过课程信息--删除课程数据  
        		int updateRseult = courseService.updateCourse(c);
        		if( updateRseult == 1 ){
        			System.out.println("\n/manager/course/update---后台管理--课程管理--更新课程信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/course/update---后台管理--课程管理--更新课程信息修改失败了。。。");
        		}
    		}
    		return "redirect:/manager/course/details?courseId="+c.getCourseId();
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程管理--到达课程详情页面
   	 */
    @RequestMapping(value = "/manager/course/details")  
    public String managerCourseDetails(@RequestParam("courseId") int courseId, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
    	Course course = new Course();
    	CourseDto courseDto = new CourseDto();
    	if( courseId != 0 ){
    		System.out.println("\n/manager/course/details-------课程详情---courseId：" + courseId);
    		course = courseService.getCourse(courseId);
    		// 通过课程id 查询课程总时长
			int videoTime = courseService.selectCourseTotalTimeSecond(course.getCourseId());
			course.setCourseTotalTime(videoTime);
			
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
    		SortsTwo sortsTwo = new SortsTwo();
    		sortsTwo = sortsTwoService.getSortsTwo(course.getTwoId());
			String sortsTwoName = sortsTwo.getTwoName();
			int oneId = sortsTwoService.getSortsTwo(course.getTwoId()).getOneId();
			SortsOne sortsOne = new SortsOne();
			sortsOne = sortsOneService.getSortsOne(oneId);
			User user = new User();
			user = userService.getUser(course.getUserId());
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			int count = learnService.getLearnNumberByCourseId(course.getCourseId());
			courseDto = new CourseDto();
			courseDto.setOneId(oneId);
			courseDto.setOneName(sortsOne.getOneName());
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(course);
			courseDto.setNumber(count);
			if( user != null ){
				courseDto.setTeacher(user.getUserRealName());
			}
			courseDto.setSortsOne(sortsOne);
			courseDto.setSortsTwo(sortsTwo);
			// 把包装的数据返回给页面
			request.setAttribute("courseDto", courseDto);
			System.out.println("\n/manager/course/details-------课程详情---courseDto：" + courseDto);
    	}
    	
    	// 获取一级分类的数据 返回给页面
    	List<SortsOne> sortsOneList = sortsOneService.selectAllSortsOne();
    	if( sortsOneList != null ){
    		request.setAttribute("sortsOneList", sortsOneList);
    		for(SortsOne s : sortsOneList) {
    			System.out.println("\n/manager/course/details-------课程详情页面--一级分类id:" + s.getOneId() + ", 一级分类名字:" + s.getOneName() + ", 一级分类编码:" + s.getOneCode());
    		}
    	}
    	
    	// 获取二级分类的数据 返回给页面
    	List<SortsTwo> sortsTwoList = sortsTwoService.selectAllSortsTwo();
    	if( sortsTwoList != null ){
    		request.setAttribute("sortsTwoList", sortsTwoList);
    		for(SortsTwo s : sortsTwoList) {
    			System.out.println("\n/manager/course/details-------课程详情页面--二级分类id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ "一级分类编码--id:" + s.getSortsOne().getOneCode());
    		}
    	}
    	
    	// 通过课程id--获取章节表数据+小节表数据-->返回给页面
		List<Chapter> chapterAndSmallChapterList = new ArrayList<Chapter>();
		chapterAndSmallChapterList = chapterService.getChapterAndSmallChapter(courseId);	
		System.out.println("\n/manager/course/details-------课程详情页面--章节(包括小节)列表数据--chapterAndSmallChapterList:" + chapterAndSmallChapterList);
		// 返回---章节表和小节表的数据--用于页面显示
		request.setAttribute("chapterAndSmallChapterList", chapterAndSmallChapterList);
		
		// 通过课程id查找   章节表的集合
		List<Chapter> chapterList = new ArrayList<Chapter>();
		chapterList = chapterService.getAllChapterByCourseId(courseId);	
		System.out.println("\n/manager/course/details-------课程详情页面--章节列表数据--chapterList:" + chapterList);
		// 返回---章节表和小节表的数据--用于页面显示
		request.setAttribute("chapterList", chapterList);
		
    	
    	// 通过课程id--获取评论表数据+提问表数据库+笔记表数据 -->返回给页面
		List<Comments> commentsList = new ArrayList<Comments>();
		List<Question> questionList = new ArrayList<Question>();
		List<Note> noteList = new ArrayList<Note>();
		commentsList = commentsService.getCommentsByCourseId(courseId);
		questionList = questionService.getQuestionByCourseId(courseId);
		noteList = noteService.getNoteByCourseId(courseId);
		System.out.println("\n/manager/course/details-------课程详情页面--评论列表数据--commentsList:" + commentsList);
		System.out.println("\n/manager/course/details-------课程详情页面--问题列表数据--questionList:" + questionList);
		System.out.println("\n/manager/course/details-------课程详情页面--笔记列表数据--noteList:" + noteList);
		// 返回---评论表数据+提问表数据库+笔记表数据--用于页面显示
		request.setAttribute("commentsList", commentsList);
		request.setAttribute("questionList", questionList);
		request.setAttribute("noteList", noteList);
		
		// 查找该课程的 评论数+问题数+笔记数量---->返回给页面 用于统计表显示
		CourseMessageDto courseMessageDto = new CourseMessageDto();
		int commentsNumber = commentsService.getCommentsNumberByCourseId(courseId);
		int questionNumber = questionService.getQuestionNumberByCourseId(courseId);
		int replyNumber = replyService.getReplyNumberByCourseId(courseId);
		int noteNumber = noteService.getNoteNumberByCourseId(courseId);
		courseMessageDto.setCommentsNumber(commentsNumber);
		courseMessageDto.setQuestionNumber(questionNumber);
		courseMessageDto.setReplyNumber(replyNumber);
		courseMessageDto.setNoteNumber(noteNumber);
		System.out.println("\n/manager/course/details-------课程详情页面--该课程的 评论数+问题数+笔记数量数据--courseMessageDto:" + courseMessageDto);
		request.setAttribute("courseMessageDto", courseMessageDto);
		
    	return "manager/manager-courseDetails";
    }
    
    /**
   	 * 	-->后台管理--课程管理--课程详情页面--章节--弹出框---通过章节id获取章节信息--返回显示在弹出框
   	 */
    @RequestMapping(value = "/manager/course/getChapterById", produces = "application/json; charset=utf-8")  
    @ResponseBody
    public String managerCourseDetailsGetChapterById(@RequestParam("id") int id, @RequestParam("type") int type,HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
    	// type=0:代表章； type=1:代表节；id：代表章节id
    	System.out.println("\n/manager/course/getChapterById------------id:"+id+", type:"+type);
    	String str = "";
    	if( type == 0 ){//章
    		Chapter chapter = new Chapter();
    		chapter = chapterService.getChapter(id);
    		JSONObject json = JSONObject.fromObject(chapter);//将java对象转换为json对象
    		str = json.toString();//将json对象转换为字符串
    		System.out.println("json:" + str);
    	}else if( type == 1 ){//节
    		SmallChapter smallChapter = new SmallChapter();
    		smallChapter = smallChapterService.getSmallChapter(id);
    		JSONObject json = JSONObject.fromObject(smallChapter);//将java对象转换为json对象
    		str = json.toString();//将json对象转换为字符串
    		System.out.println("json:" + str);
    	}
    	return str;
    }
    
    /**
   	 * 	-->后台管理--课程管理--课程详情页面--修改更新章节信息+(可能更新视频)
     * @throws IOException 
     * @throws IllegalStateException 
   	 */
    @RequestMapping(value = "/manager/course/updateChapter", method = RequestMethod.POST)  
    public String managerCourseUpdateChapter(HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException{
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
        	
    	String courseId = request.getParameter("courseId");
    	String chapterId = request.getParameter("chapterId");
    	String smallChapterId = request.getParameter("smallChapterId");
    	String name = request.getParameter("name");
    	// String videoName = request.getParameter("videoUrl");	// 文件名
    	// String time = request.getParameter("time");
    	
    	// 如果章id不为空，则更新章信息
    	if( chapterId != null && !chapterId.equals("") ){
    		Chapter chapter = new Chapter();
    		chapter = chapterService.getChapter(Integer.parseInt(chapterId));
    		chapter.setChapterTitle(name);
    		int updateResult = chapterService.updateChapter(chapter);
    		if( updateResult == 1 ){
    			System.out.println("\n/manager/course/updateChapter---章----更新章信息成功啦！！！");
    		}else{
    			System.out.println("\n/manager/course/updateChapter---章----更新章信息失败了。。。");
    		}
    	
    	// 否则，如果小节id不为空，则更新小节信息
    	}else if( smallChapterId != null && !smallChapterId.equals("") ){
    		
    		SmallChapter smallChapter = new SmallChapter();
    		// 获取要更新的小节表
    		smallChapter = smallChapterService.getSmallChapter(Integer.parseInt(smallChapterId));
    		//获取(旧的)文件名---用于删除旧的视频文件
    		String oldVideoName = smallChapter.getVideoPath();	
    		// 设置要更新的小节内容：小节名称+小节时间+上传视频文件名(见下面)
    		smallChapter.setSmallChapterTitle(name);
			// smallChapter.setVideoTotalTime(time);
    			
    		// 更新小节对应的视频---删除旧的视频文件(当有新视频的时候删除旧视频)
			String oldVideoPath = "D:\\imooc\\video\\" + oldVideoName;	// (旧的)文件上传的路径+文件名
			File oldVideoFile = new File(oldVideoPath);
    		
			DateUtil dateUtil = new DateUtil();
    		// 更新小节对应的视频---上传新的视频文件----当有的时候就会检测到，先上传新视频，然后删除旧视频
			//创建一个通用的多部分解析器--用于上传视频文件
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
			//设置编码  
			multipartResolver.setDefaultEncoding("utf-8");
			//判断 request 是否有文件上传,即多部分请求...
			if( multipartResolver.isMultipart(request) ){//获取文件解析器，判断是否是文件
				//转换成多部分request 
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) (request);
				Iterator<String> iter = multiRequest.getFileNames();//获取所有文件名字
				while( iter.hasNext() ){//遍历所有文件
					// file 是指 文件上传标签的 name=值  	
				    // 根据 name 获取上传的文件... 
					MultipartFile file = multiRequest.getFile((String)iter.next());// iter一次遍历所有文件
					if( file != null && file.getOriginalFilename() != null && file.getOriginalFilename() != "" ){
						//获取服务器当前时间 
						Date date = new Date(); 
				    	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd-HH.mm.ss"); 
				        String currentTime = simpleDateFormat.format(date); //当前提交时间 (做文件名的一部分)
				        System.out.println("---更新节信息:--提交时间(做文件名的一部分)="+currentTime);
				        
				        String fileName = currentTime + "_" + file.getOriginalFilename();	// 文件重命名
						System.out.println("---更新节信息:--上传的视频的文件名--fileName:"+fileName);
						String path = "D:\\imooc\\video\\" + fileName;		//提交路径(用于保存文件到磁盘)；		数据库中只存放文件名，页面显示通过 虚拟路径配置
						
						// 判断D盘是否有 imooc 文件夹，接着判断imooc文件夹下是否有video文件夹，没有就新建这两个文件夹，用于存储视频文件
						File folder = new File("D:\\imooc");
						if( !folder.exists() && folder.isDirectory() ){
							folder.mkdir();		// 创建文件夹D:\\imooc
						}
						File folder2 = new File("D:\\imooc\\video");
						if( !folder2.exists() && folder2.isDirectory() ){
							folder2.mkdirs();	// 创建文件夹D:\\imooc\\video
						}
						
						// 上传视频文件
						File localFile = new File(path);
						file.transferTo(localFile);//上传文件 
						System.out.println("----更新节信息:--视频上传成功!!");
						
						// 获取视频时间
						String videoTime = dateUtil.ReadVideoTime(localFile);
						int videoSecond = dateUtil.ReadVideoTimeSecond(localFile);
						System.out.println("\n视频时间(字符串)："+videoTime+", 视频时间(秒)：" +videoSecond);
						
						//设置要更新的小节内容：上传视频文件名+视频时间(见上面)
						smallChapter.setVideoPath(fileName);
						smallChapter.setVideoTotalTime(videoTime);
						smallChapter.setVideoTotalTimeSecond(videoSecond);
						
						// 新视频上传成功之后--如果(旧的)视频文件存在且不为空--则删除该(旧的)视频文件
			    		if ( !oldVideoFile.exists() ) {  
			    			System.out.println("旧的视频文件不存在！！");
				        }else {
				            // 判断是否为文件，若是则删除
				            if ( oldVideoFile.isFile() ) {
				            	// 删除文件
				            	oldVideoFile.delete();
				            	System.out.println("旧的小节视频文件删除成功！！");
				            } else {  
				            	System.out.println("当前旧的视频路径下不是文件！！");
				            }
				        }
					}
				}
			}
			
			
			// 更新小节记录
			int updateResult = smallChapterService.updateSmallChapter(smallChapter);
			if( updateResult == 1 ){
				System.out.println("\n/manager/course/updateChapter---小节----更新小节信息成功啦！！！");
			}else{
				System.out.println("\n/manager/course/updateChapter---小节----更新小节信息失败了。。。");
			}
    		
    	}
    	
    	return "redirect:/manager/course/details?courseId="+Integer.parseInt(courseId);
    }
    
    /**
   	 * 	-->后台管理--课程管理--课程详情页面--章节模块--添加节信息
     * @throws IOException 
     * @throws IllegalStateException 
   	 */
    @RequestMapping(value = "/manager/course/addSmallChapter", method = RequestMethod.POST)
    public String managerCourseAddSmallChapter(HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException{
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
    	String courseId = request.getParameter("courseId");
    	String chapterId = request.getParameter("chapterId");
    	String smallChapterTitle = request.getParameter("smallChapterTitle");
    	// String smallChapterTime = request.getParameter("smallChapterTime");
    	
    	
    	// 定义添加小节的对象
    	SmallChapter smallChapter = new SmallChapter();
    	smallChapter.setChapterId(Integer.parseInt(chapterId));
    	smallChapter.setSmallChapterTitle(smallChapterTitle);
    	// smallChapter.setVideoTotalTime(smallChapterTime);
    	// 通过章节id 查找该章节有多少个小节记录，然后找到最后一条小节记录，将其order顺序+1 ，即为添加此条小节记录的顺序
    	List<SmallChapter> smallChapterList = new ArrayList<SmallChapter>();
    	smallChapterList = smallChapterService.getAllSmallChapterByChapterId(Integer.parseInt(chapterId));
    	int smallChapterOrder = 0;
    	if( smallChapterList != null && smallChapterList.size() > 0 ){
    		smallChapterOrder = smallChapterList.get(smallChapterList.size()-1).getSmallChapterOrder() + 1;
    	}else{
    		smallChapterOrder = 1;
    	}
    	smallChapter.setSmallChapterOrder(smallChapterOrder);
    	
    	DateUtil dateUtil = new DateUtil();
    	//创建一个通用的多部分解析器--用于上传视频文件
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		//设置编码  
		multipartResolver.setDefaultEncoding("utf-8");
		//判断 request 是否有文件上传,即多部分请求...
		if( multipartResolver.isMultipart(request) ){//获取文件解析器，判断是否是文件
			//转换成多部分request 
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) (request);
			Iterator<String> iter = multiRequest.getFileNames();//获取所有文件名字
			while( iter.hasNext() ){//遍历所有文件
				// file 是指 文件上传标签的 name=值  	
			    // 根据 name 获取上传的文件... 
				MultipartFile file = multiRequest.getFile((String)iter.next());// iter一次遍历所有文件
				if( file != null && file.getOriginalFilename() != null && file.getOriginalFilename() != "" ){
					//获取服务器当前时间 
					Date date = new Date(); 
			    	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd-HH.mm.ss"); 
			        String currentTime = simpleDateFormat.format(date); //当前提交时间 (做文件名的一部分)
			        System.out.println("---添加节信息:--提交时间(做文件名的一部分)="+currentTime);
			        
			        String fileName = currentTime + "_" + file.getOriginalFilename();	// 文件重命名
					System.out.println("---添加节信息:--上传的视频的文件名--fileName:"+fileName);
					String path = "D:\\imooc\\video\\" + fileName;		//提交路径(用于保存文件到磁盘)；		数据库中只存放文件名，页面显示通过 虚拟路径配置
					
					// 判断D盘是否有 imooc 文件夹，接着判断imooc文件夹下是否有video文件夹，没有就新建这两个文件夹，用于存储视频文件
					File folder = new File("D:\\imooc");
					if( !folder.exists() && folder.isDirectory() ){
						folder.mkdir();		// 创建文件夹D:\\imooc
					}
					File folder2 = new File("D:\\imooc\\video");
					if( !folder2.exists() && folder2.isDirectory() ){
						folder2.mkdirs();	// 创建文件夹D:\\imooc\\video
					}
					
					// 上传视频文件
					File localFile = new File(path);
					file.transferTo(localFile);//上传文件 
					System.out.println("----视频上传成功，上传数据成功插入数据库表,---第1次上传");
					
					// 获取视频时间
					String videoTime = dateUtil.ReadVideoTime(localFile);
					int videoSecond = dateUtil.ReadVideoTimeSecond(localFile);
					System.out.println("\n视频时间(字符串)："+videoTime+", 视频时间(秒)：" +videoSecond);
					
					//设置要添加的小节内容：上传视频文件名(见上面)
					smallChapter.setVideoPath(fileName);
					smallChapter.setVideoTotalTime(videoTime);
					smallChapter.setVideoTotalTimeSecond(videoSecond);
					
				}
			}
		}
		
		// 添加小节记录
		int addResult = smallChapterService.addSmallChapter(smallChapter);
		if( addResult == 1 ){
			System.out.println("\n/manager/course/updateChapter---小节----添加小节信息成功啦！！！");
		}else{
			System.out.println("\n/manager/course/updateChapter---小节----添加小节信息失败了。。。");
		}
    	
    	return "redirect:/manager/course/details?courseId="+Integer.parseInt(courseId);
    }
    
    
    /**
   	 * 	-->后台管理--课程管理--课程详情页面--章节模块-----通过章节id删除章节信息+小节路径下的视频文件
   	 */
    @RequestMapping(value = "/manager/course/deleteChapterById", produces = "application/json; charset=utf-8", method = RequestMethod.POST)
    @ResponseBody
    public String managerCourseDeleteChapterById(@RequestParam("id")int id, @RequestParam("type")int type ){
    	// type=0:代表章； type=1:代表节；id：代表章节id
    	System.out.println("\n/manager/course/deleteChapterById------------id:"+id+", type:"+type);
    	
    	// 初始化返回的string
    	String str = "{\"res\": 0}";
    	
    	// 如果是章
    	if( type == 0 ){ // id是章id
    		
    		//删除章信息
    		int deleteResult = chapterService.deleteChapter(id);
    		if( deleteResult == 1 ){// 删除章成功
    			System.out.println("\n/manager/course/deleteChapterById-----后台管理--课程管理--课程详情页面--章节模块-----通过章id删除章信息成功啦！！！");
    			str = "{\"res\": 1}";
    			
    			// 通过章id----删除该章下的所有小节信息--并遍历删除所有的视频
    			List<SmallChapter> smallChapterList = smallChapterService.getAllSmallChapterByChapterId(id);
    			
    			// 删除所有的小节
    			int del = smallChapterService.deleteSmallChapterByChapterId(id);
    			if( del != 0 ){// 删除所有的小节成功
    				System.out.println("\n/manager/course/deleteChapterById-----后台管理--课程管理--课程详情页面--章节模块-----通过章id删除该章下的所有小节信息成功啦！！！");
    				
    				// 遍历删除---所有小节信息中的视频
    				for( SmallChapter smallChapter: smallChapterList ){
    					// 获取数据库中的视频文件全名字(包括后缀名)
        				String videoName = smallChapter.getVideoPath();
        	    		// 通过数据库存储的视频文件名--+磁盘路径--获得视频文件的全路径
        	    		String videoPath = "D:\\imooc\\video\\" + videoName;	// 文件上传的路径+文件名
        	    		File videoFile = new File(videoPath);
        	    		// 如果视频文件存在且不为空--则删除该视频文件
        	    		if ( !videoFile.exists() ) {  
        	    			System.out.println("当前视频文件不存在！！");
        		        }else {
        		            // 判断是否为文件，若是则删除
        		            if ( videoFile.isFile() ) {
        		            	// 删除文件
        		            	videoFile.delete();
        		            	System.out.println("当前章下---视频文件删除成功！！");
        		            } else {  
        		            	System.out.println("当前视频路径下不是文件！！");
        		            }
        		        }
        			}
    			}else{
    				System.out.println("\n/manager/course/deleteChapterById-----后台管理--课程管理--课程详情页面--章节模块-----通过章id删除该章下的所有小节信息失败了。。。");
    			}
    		}else{
    			System.out.println("\n/manager/course/deleteChapterById-----后台管理--课程管理--课程详情页面--章节模块-----通过章id删除章信息失败了。。。");
    		}
    	}else if( type == 1 ){//节   id是小节id
    		// 获取当前小节信息--为了删除视频文件时，来获取视频文件名
    		SmallChapter smallChapter = new SmallChapter();
    		smallChapter = smallChapterService.getSmallChapter(id);
    		
    		// 通过小节id--获取到该小节对应章节id,然后判断删除完该小节之后，该章节下是否还有小节？
    		// 1、如果没有则把该章信息也删除掉
    		int chapterId = smallChapter.getChapterId();
    		
    		// 删除该节的数据库记录
    		int deleteResult = smallChapterService.deleteSmallChapter(id);
    		if( deleteResult == 1 ){ // 删除该节成功
    			System.out.println("\n/manager/course/deleteChapterById-----后台管理--课程管理--课程详情页面--章节模块-----通过小节id删除小节信息成功啦！！！");
    			str = "{\"res\": 1}";
        		
    			// 获取数据库中的视频文件全名字(包括后缀名)
    			String videoName = smallChapter.getVideoPath();
    			// 通过数据库存储的视频文件名--+磁盘路径---删除视频文件
        		String videoPath = "D:\\imooc\\video\\" + videoName;	// 文件上传的路径+文件名
        		File videoFile = new File(videoPath);
        		// 如果视频文件存在且不为空--则删除该视频文件
        		if ( !videoFile.exists() ) {  
        			System.out.println("当前视频文件不存在！！");
    	        }else {
    	            // 判断是否为文件，若是则删除
    	            if ( videoFile.isFile() ) {
    	            	// 删除文件
    	            	videoFile.delete();
    	            	System.out.println("当前小节视频文件删除成功！！");
    	            } else {  
    	            	System.out.println("当前视频路径下不是文件！！");
    	            }
    	        }
        		
        		// 删除完该小节之后，判断该章节下是否还有小节？
        		// 1、如果没有则把该章信息也删除掉
        		List<SmallChapter> smallChapterList = smallChapterService.getAllSmallChapterByChapterId(chapterId);
        		if( smallChapterList.size() == 0 ){
        			// 该章下已经没有小节信息，删除该空章(没有小节的章)信息记录
        			int deleteChapterResult = chapterService.deleteChapter(chapterId);
            		if( deleteChapterResult == 1 ){// 删除空章(没有小节的章)成功
            			System.out.println("\n/manager/course/deleteChapterById-----后台管理--课程管理--课程详情页面--章节模块-----删除空章(没有小节的章)信息成功啦！！！");
            			str = "{\"res\": 2,\"chapterId\":"+chapterId+"}";
            		}
        		}
        		
        		
    		}else{
    			System.out.println("\n/manager/course/deleteChapterById-----后台管理--课程管理--课程详情页面--章节模块-----通过小节id删除小节信息失败了。。。");
    		}
    		
    	}
    	return str;
    }
    
    /**
   	 * 	-->后台管理--课程管理--到达添加课程章节页面
   	 */
    @RequestMapping(value = "/manager/course/chapterAddPage")  
    public String managerCourseChapterAddPage(@RequestParam("courseId") int courseId, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
    	Course course = new Course();
    	CourseDto courseDto = new CourseDto();
    	if( courseId != 0 ){
    		System.out.println("\n/manager/course/chapterAdd-------课程章节添加页面---courseId：" + courseId);
    		course = courseService.getCourse(courseId);
			// 通过二级分类id 获取二级分类对象, 进而获取二级分类名字
    		SortsTwo sortsTwo = new SortsTwo();
    		sortsTwo = sortsTwoService.getSortsTwo(course.getTwoId());
			String sortsTwoName = sortsTwo.getTwoName();
			int oneId = sortsTwoService.getSortsTwo(course.getTwoId()).getOneId();
			SortsOne sortsOne = new SortsOne();
			sortsOne = sortsOneService.getSortsOne(oneId);
			User user = new User();
			user = userService.getUser(course.getUserId());
			// 通过课程id, 在学习记录表里面, 查找 得出 学习人数
			int count = learnService.getLearnNumberByCourseId(course.getCourseId());
			courseDto = new CourseDto();
			courseDto.setOneId(oneId);
			courseDto.setOneName(sortsOne.getOneName());
			courseDto.setSortsTwoName(sortsTwoName);
			courseDto.setCourse(course);
			courseDto.setNumber(count);
			courseDto.setTeacher(user.getUserRealName());
			courseDto.setSortsOne(sortsOne);
			courseDto.setSortsTwo(sortsTwo);
			// 把包装的数据返回给页面
			request.setAttribute("courseDto", courseDto);
			System.out.println("\n/manager/course/chapterAdd-------课程章节添加页面---courseDto：" + courseDto);
    	}
    	return "manager/manager-courseChapterAdd";
    }
    
    /**
   	 * 	-->后台管理--课程管理--添加课程章节+上传视频
     * @throws IOException 
     * @throws IllegalStateException 
   	 */
    @RequestMapping(value = "/manager/course/chapterUpload", method=RequestMethod.POST)  
    //public String managerCourseChapterUpload( @RequestParam("subSectionName")String[] subSectionName, @RequestParam("time")String[] time,
    public String managerCourseChapterUpload( @RequestParam("subSectionName")String[] subSectionName,
    		HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException{
    	// sectionName: 章名称； subSectionName:节名称； time:节视频时间
    	// 每次只能添加一章+多个节和视频 
    	String courseId = request.getParameter("courseId");			// 课程id
    	String chapterTitle = request.getParameter("sectionName");	// 章名称
    	System.out.println("\n/manager/course/chapterUpload--课程管理--添加课程章节+视频-----courseId:"+courseId+", chapterTitle:"+chapterTitle);	
    	for( int i=0; i<subSectionName.length; i++ ){
    		/*System.out.println("\n/manager/course/chapterUpload--课程管理--添加课程章节+视频---courseId:"+courseId +", chapterTitle:" + chapterTitle +", subSectionName:"+subSectionName[i]+", time:"+time[i]);*/
    		System.out.println("\n/manager/course/chapterUpload--课程管理--添加课程章节+视频---courseId:"+courseId +", chapterTitle:" + chapterTitle +", subSectionName:"+subSectionName[i]);
    	}
    	
    	// 添加章信息：通过课程id 查找此课程的章节表数据，通过判断是否有数据，来确定添加的 章信息的order顺序；
    	// 如果有,order在顺序上+1；如果没有，order则为1
    	Chapter chapter = new Chapter();
    	// 通过课程id--获取章节表数据+小节表数据-->返回给页面
		List<Chapter> chapterList = new ArrayList<Chapter>();
		chapterList = chapterService.getAllChapterByCourseId(Integer.parseInt(courseId));// 通过课程id查出来该课程的章列表	
		System.out.println("\n------1---------chapterList.size():"+chapterList.size());
		if( chapterList != null && chapterList.size() > 0 ){
			System.out.println("\n/manager/course/chapterUpload--课程管理--添加课程章节+视频----章节(包括小节)列表数据--chapterList:" + chapterList);
			// 获取最后一条章节表数据的顺序
			int chapterOrder = chapterList.get(chapterList.size()-1).getChapterOrder();
			chapterOrder++;
			chapter.setCourseId(Integer.parseInt(courseId));
			chapter.setChapterOrder(chapterOrder);
			chapter.setChapterTitle(chapterTitle);
		}else{
			chapter.setCourseId(Integer.parseInt(courseId));
			chapter.setChapterOrder(1);
			chapter.setChapterTitle(chapterTitle);
		}
		// 通过章节信息--添加章节数据  
		int addChapterRseult = chapterService.addChapter(chapter);
		if( addChapterRseult == 1 ){
			System.out.println("\n/manager/course/chapterUpload--课程管理-----添加章节信息修改成功了！！\n chapter:" + chapter);
			
		}else{
			System.out.println("\n/manager/course/chapterUpload--课程管理-----添加章节信息修改失败了。。。");
		}
		
		// 获取刚刚添加进去的章节id--然后遍历小节+视频文件--来上传和插入数据库
		chapterList = chapterService.getAllChapterByCourseId(Integer.parseInt(courseId));	
		System.out.println("\n------2---------chapterList.size():"+chapterList.size());
		int chapterId = chapterList.get(chapterList.size()-1).getChapterId();
		
		DateUtil dateUtil = new DateUtil();
		// 处理视频文件，并添加进数据库
		//创建一个通用的多部分解析器
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
		//设置编码  
		multipartResolver.setDefaultEncoding("utf-8");
		//判断 request 是否有文件上传,即多部分请求...
		if( multipartResolver.isMultipart(request) ){//获取文件解析器，判断是否是文件
			//转换成多部分request 
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) (request);
			Iterator<String> iter = multiRequest.getFileNames();//获取所有文件名字
			int index = 0;
			
			while( iter.hasNext() ){//遍历所有文件
				// file 是指 文件上传标签的 name=值  	
			    // 根据 name 获取上传的文件... 
				List<MultipartFile> files = multiRequest.getFiles((String)iter.next());// iter一次遍历所有文件
				for( MultipartFile file: files ){
					if( file != null ){
						
						/**
						 * java中文件的常用方法：
						 * isDirectory():		是检查一个对象是否是文件夹
						 * isFile():			判断是否文件，也许可能是文件或者目录
						 * exists():			判断是否存在，可能不存在
						 * mkdir():				只能创建一级目录，且父目录必须存在，否则无法成功创建一个目录。
						 * mkdirs():			可以创建多级目录，父目录不一定存在。
						 * delete();			删除文件
						 * createNewFile();		创建新文件
						 */
						// 判断D盘是否有 imooc 文件夹，接着判断imooc文件夹下是否有video文件夹，没有就新建这两个文件夹，用于存储视频文件
						File folder = new File("D:\\imooc");
						if( !folder.exists() && folder.isDirectory() ){
							folder.mkdir();
						}
						File folder2 = new File("D:\\imooc\\video");
						if( !folder2.exists() && folder2.isDirectory() ){
							folder2.mkdirs();
						}
						
						//获取服务器当前时间 
						Date date = new Date(); 
				    	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd-HH.mm.ss"); 
				        String currentTime = simpleDateFormat.format(date); //当前提交时间 (做文件名的一部分)
				        System.out.println("---上传页面:提交时间(做文件名的一部分)="+currentTime);
				        
				        String fileName = currentTime + "_" + file.getOriginalFilename();	// 文件重命名
						System.out.println("---上传的视频的文件名--fileName:"+fileName);
						String path = "D:\\imooc\\video\\" + fileName;		//提交路径(用于保存文件到磁盘)；		数据库中只存放文件名，页面显示通过 虚拟路径配置
						// 上传视频文件
						File localFile = new File(path);
						file.transferTo(localFile);//上传文件 
						System.out.println("----视频上传成功，上传数据成功插入数据库表,---第"+(index+1)+"次上传");
						
						// 获取视频时间
						String videoTime = dateUtil.ReadVideoTime(localFile);
						int videoSecond = dateUtil.ReadVideoTimeSecond(localFile);
						System.out.println("\n视频时间(字符串)："+videoTime+", 视频时间(秒)：" +videoSecond);
						
						// 更新数据库数据---添加节信息，遍历小节名称
						SmallChapter smallChapter = new SmallChapter();
						smallChapter.setChapterId(chapterId);
			    		smallChapter.setSmallChapterOrder(index+1);
			    		smallChapter.setSmallChapterTitle(subSectionName[index]);
			    		smallChapter.setVideoPath(fileName);
			    		smallChapter.setVideoTotalTime(videoTime);
			    		smallChapter.setVideoTotalTimeSecond(videoSecond);
			    		// 通过节信息--添加节数据  
						int addSmallChapterRseult = smallChapterService.addSmallChapter(smallChapter);
						if( addSmallChapterRseult == 1 ){
							System.out.println("\n/manager/course/chapterUpload--课程管理-----添加第"+(index+1)+"小节信息修改成功了！！smallChapter:"+smallChapter);
						}else{
							System.out.println("\n/manager/course/chapterUpload--课程管理-----添加第"+(index+1)+"小节信息修改失败了。。。");
						}
						
					}
					index++;
				}
			}
		}
    	
    	// 重定向到课程详情页面
    	return "redirect:/manager/course/details?courseId="+Integer.parseInt(courseId);
    }
    
    /**
   	 * 	-->后台管理--课程管理--课程详情页面--删除课程评论
   	 */
    @RequestMapping(value = "/manager/course/commentsDelete")  
    @ResponseBody
    public String managerCourseCommentDelete(@RequestParam("commentsId") int commentsId, HttpServletRequest request, HttpSession session){
    	String res = "{\"res\": 0 }";
    	if( commentsId != 0 ){
			// 通过课程评论id信息--删除课程评论数据  
    		int deleteRseult = commentsService.deleteComments(commentsId);
    		if( deleteRseult == 1 ){
    			res = "{\"res\": 1 }";
    			System.out.println("\n/manager/course/commentDelete-->后台管理--课程管理--课程详情页面--删除课程comments评论信息修改成功了！！");
    		}else{
    			System.out.println("\n/manager/course/commentDelete-->后台管理--课程管理--课程详情页面--删除课程comments评论信息修改失败了。。。");
    		}
    		System.out.println("\n/manager/course/commentDelete-->后台管理--课程管理--课程详情页面--删除课程comments评论--------deleteRseult:" + deleteRseult);
		}
    	return res;
    }
    
    /**
   	 * 	-->后台管理--课程管理--课程详情页面--删除课程问答
   	 */
    @RequestMapping(value = "/manager/course/questionDelete")  
    @ResponseBody
    public String managerCourseQuestionDelete(@RequestParam("questionId") int questionId, HttpServletRequest request, HttpSession session){
    	String res = "{\"res\": 0 }";
    	if( questionId != 0 ){
			// 通过课程评论id信息--删除课程评论数据  
    		int deleteRseult = questionService.deleteQuestion(questionId);
    		if( deleteRseult == 1 ){
    			res = "{\"res\": 1 }";
    			System.out.println("\n/manager/course/questionDelete-->后台管理--课程管理--课程详情页面--删除课程question问答信息修改成功了！！");
    		}else{
    			System.out.println("\n/manager/course/questionDelete-->后台管理--课程管理--课程详情页面--删除课程question问答信息修改失败了。。。");
    		}
    		System.out.println("\n/manager/course/questionDelete-->后台管理--课程管理--课程详情页面--删除课程question问答--------deleteRseult:" + deleteRseult);
		}
    	return res;
    }
    
    /**
   	 * 	-->后台管理--课程管理--课程详情页面--删除课程笔记
   	 */
    @RequestMapping(value = "/manager/course/noteDelete")  
    @ResponseBody
    public String managerCourseNoteDelete(@RequestParam("noteId") int noteId, HttpServletRequest request, HttpSession session){
    	String res = "{\"res\": 0 }";
    	if( noteId != 0 ){
			// 通过课程评论id信息--删除课程评论数据  
    		int deleteRseult = noteService.deleteNote(noteId);
    		if( deleteRseult == 1 ){
    			res = "{\"res\": 1 }";
    			System.out.println("\n/manager/course/noteDelete-->后台管理--课程管理--课程详情页面--删除课程note笔记信息修改成功了！！");
    		}else{
    			System.out.println("\n/manager/course/noteDelete-->后台管理--课程管理--课程详情页面--删除课程note笔记信息修改失败了。。。");
    		}
    		System.out.println("\n/manager/course/noteDelete-->后台管理--课程管理--课程详情页面--删除课程note笔记--------deleteRseult:" + deleteRseult);
		}
    	return res;
    }
    
   
    
    /**
   	 * 	-->后台管理--轮播配置
   	 */
    @RequestMapping(value = "/manager/carousel")  
    public String managerCarousel(HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
        return "manager/manager-carousel";
    }
    
    /**
   	 * 	-->后台管理--课程分类
   	 */
    @RequestMapping(value = "/manager/classify")  
    public String managerClassify(HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager == null ){
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
    	// 获取一级分类的数据 返回给页面
    	List<SortsOne> sortsOneList = sortsOneService.selectAllSortsOne();
    	if( sortsOneList != null ){
    		request.setAttribute("sortsOneList", sortsOneList);
    		for(SortsOne s : sortsOneList) {
    			System.out.println("\n/manager/classify---->后台管理--课程分类页面--一级分类id:" + s.getOneId() + ", 一级分类名字:" + s.getOneName() + ", 一级分类编码:" + s.getOneCode());
    		}
    	}
    	
    	// 获取二级分类的数据 返回给页面
    	List<SortsTwo> sortsTwoList = sortsTwoService.selectAllSortsTwo();
    	if( sortsTwoList != null ){
    		request.setAttribute("sortsTwoList", sortsTwoList);
    		for(SortsTwo s : sortsTwoList) {
    			System.out.println("\n/manager/classify---->后台管理--课程分类页面--二级分类id:" + s.getTwoId() + ", 二级分类名字:" + s.getTwoName() + ", 二级分类编码:" + s.getTwoCode()+ "一级分类编码--id:" + s.getSortsOne().getOneCode());
    		}
    	}
    	
        return "manager/manager-classify";
    }
    
    /**
   	 * 	-->后台管理--课程分类页面--通过分类编码获取一级分类的信息
   	 */
    @RequestMapping(value = "/manager/classify/getSortsOneByCode",produces = "application/json; charset=utf-8", method = RequestMethod.POST) 
    @ResponseBody
    public String managerGetSortsOneByCode(@RequestParam("code") String code, HttpServletRequest request, HttpSession session){
    	if( code != null ){
    		System.out.println("\n/manager/classify/getSortsOneByCode-----后台管理--课程分类页面--通过分类编码获取一级分类的信息-------oneCode:" + code);
    		
    		// 通过code从一级分类里面找
    		SortsOne sortsOne = new SortsOne();
    		sortsOne = sortsOneService.getSortsOneByOneCode(code);
    		if( sortsOne != null ){
    			JSONObject json = JSONObject.fromObject(sortsOne);//将java对象转换为json对象
        		String str = json.toString();//将json对象转换为字符串
        		System.out.println("json" + str);
        		return str;
    		}else{
    			return "一级分类表中没有此编码,出错了！！";
    		}
    	}else{
    		System.out.println("userId is null ");
    		return "没有获得id,出错了！！";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程分类页面--通过分类编码获取二级分类的信息
   	 */
    @RequestMapping(value = "/manager/classify/getSortsTwoByCode",produces = "application/json; charset=utf-8", method = RequestMethod.POST) 
    @ResponseBody
    public String managerGetSortsTwoByCode(@RequestParam("code") String code, HttpServletRequest request, HttpSession session){
    	if( code != null ){
    		System.out.println("\n/manager/classify/getSortsTwoByCode-----后台管理--课程分类页面--通过分类编码获取二级分类的信息-------twoCode:" + code);
    		
    		// 通过code从二级分类里面找
    		SortsTwo sortsTwo = new SortsTwo();
    		sortsTwo = sortsTwoService.getSortsTwoByTwoCode(code);
    		if( sortsTwo != null ){
    			JSONObject json = JSONObject.fromObject(sortsTwo);//将java对象转换为json对象
        		String str = json.toString();//将json对象转换为字符串
        		System.out.println("json" + str);
        		return str;
    		}else{
    			return "二级分类表中没有此编码,出错了！！";
    		}
    	}else{
    		System.out.println("userId is null ");
    		return "没有获得id,出错了！！";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程分类页面--更新一级分类
   	 */
    @RequestMapping(value = "/manager/sortsone/update", method = RequestMethod.POST)  
    public String managerSortsOneUpdate(SortsOne s1, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( s1 != null ){
    			// 通过课程分类信息--更新一级分类数据  
        		int updateRseult = sortsOneService.updateSortsOne(s1);
        		if( updateRseult == 1 ){
        			System.out.println("\n/manager/sortsone/update-->后台管理--课程分类页面--更新一级分类信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/sortsone/update-->后台管理--课程分类页面--更新一级分类信息修改失败了。。。");
        		}
    		}
    		return "redirect:/manager/classify";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程分类页面--更新二级分类
   	 */
    @RequestMapping(value = "/manager/sortstwo/update", method = RequestMethod.POST)  
    public String managerSortsTwoUpdate(SortsTwo s2, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( s2 != null ){
    			// 通过课程分类信息--更新一级分类数据  
        		int updateRseult = sortsTwoService.updateSortsTwo(s2);
        		if( updateRseult == 1 ){
        			System.out.println("\n/manager/sortsone/update-->后台管理--课程分类页面--更新二级分类信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/sortsone/update-->后台管理--课程分类页面--更新二级分类信息修改失败了。。。");
        		}
    		}
    		return "redirect:/manager/classify";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程分类页面--添加分类之前校验
   	 */
    @RequestMapping(value = "/manager/classify/addValidate", method = RequestMethod.POST)  
    @ResponseBody
    public String managerClassifyAddValidate(@RequestParam("classCode") String classCode, HttpServletRequest request, HttpSession session){
    	String res = "{\"res\": 0 }";
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( classCode != null && !classCode.equals("") ){
    			// 通过classCode从一级分类和二级分类里面找 是否存在才编码
    			SortsOne sortsOne = new SortsOne();
        		SortsTwo sortsTwo = new SortsTwo();
        		sortsOne = sortsOneService.getSortsOneByOneCode(classCode);
        		sortsTwo = sortsTwoService.getSortsTwoByTwoCode(classCode);
        		System.out.println("\n/manager/classify/addValidate-->后台管理--课程分类页面--添加分类之前校验--sortsOne:"+sortsOne);
        		System.out.println("\n/manager/classify/addValidate-->后台管理--课程分类页面--添加分类之前校验--sortsTwo:"+sortsTwo);
    			if( sortsOne != null || sortsTwo != null ){
    				res = "{\"res\": 1 }";
    				System.out.println("\n/manager/classify/addValidate-->后台管理--课程分类页面--添加分类之前校验编码存在！！！");
    			}else{
        			System.out.println("\n/manager/classify/addValidate-->后台管理--课程分类页面--添加分类之前校验编码不存在。。。");
        		}
    		}
    		return res;
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--课程分类页面--添加分类
   	 */
    @RequestMapping(value = "/manager/classify/add", method = RequestMethod.POST)  
    // public String managerClassifyAdd(@RequestParam("classifyId") String classifyId, HttpServletRequest request){
    public String managerClassifyAdd( HttpServletRequest request){
    	System.out.println("---------ssss------------");
    	String classId = request.getParameter("classId");	// 实际是1或一级分类编码
    	String className = request.getParameter("className");
    	String classCode = request.getParameter("classCode");
    	if( classId != null ){
    		System.out.println("\n/manager/classify/add----后台管理--课程分类页面--添加分类---classId:" + classId + ", classCode:" + classCode + ", className:"+ className);
    		if( classId.equals("1") ){	// 选的是"总分类"，即添加一级分类
    			SortsOne sortsOne = new SortsOne();
    			sortsOne.setOneCode(classCode);
    			sortsOne.setOneName(className);
    			int addResult = sortsOneService.addSortsOne(sortsOne);
    			if( addResult == 1 ){
        			System.out.println("\n/manager/classify/add-->后台管理--课程分类页面--添加一级分类信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/classify/add-->后台管理--课程分类页面--添加一级分类信息修改失败了。。。");
        		}
    		}else{// 若选的不是"总分类"，即添加二级分类
    			// 通过一级分类编码--查找一级分类id
    			int oneId = sortsOneService.getSortsOneByOneCode(classId).getOneId();
    			SortsTwo sortsTwo = new SortsTwo();
    			sortsTwo.setOneId(oneId);
    			sortsTwo.setTwoCode(classCode);
    			sortsTwo.setTwoName(className);
    			int addResult = sortsTwoService.addSortsTwo(sortsTwo);
    			if( addResult == 1 ){
        			System.out.println("\n/manager/classify/add-->后台管理--课程分类页面--添加二级分类信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/classify/add-->后台管理--课程分类页面--添加二级分类信息修改失败了。。。");
        		}
    		}
    	}
        return "redirect:/manager/classify";
    }
    
    /**
   	 * 	-->后台管理--课程分类页面--删除一级分类
   	 */
    @RequestMapping(value = "/manager/sortsone/delete", method = RequestMethod.POST)  
    public String managerSortsOneDelete(@RequestParam("oneId") int oneId, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( oneId != 0 ){
    			// 通过课程分类信息--删除一级分类数据  
        		int deleteRseult = sortsOneService.deleteSortsOne(oneId);
        		if( deleteRseult == 1 ){
        			System.out.println("\n/manager/sortsone/update-->后台管理--课程分类页面--删除一级分类信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/sortsone/update-->后台管理--课程分类页面--删除一级分类信息修改失败了。。。");
        		}
    		}
    		return "redirect:/manager/classify";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }

    /**
   	 * 	-->后台管理--课程分类页面--删除二级分类
   	 */
    @RequestMapping(value = "/manager/sortstwo/delete", method = RequestMethod.POST)  
    public String managerSortsTwoDelete(@RequestParam("twoId") int twoId, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( twoId != 0 ){
    			// 通过课程分类信息--删除一级分类数据  
        		int deleteRseult = sortsTwoService.deleteSortsTwo(twoId);
        		if( deleteRseult == 1 ){
        			System.out.println("\n/manager/sortstwo/delete-->后台管理--课程分类页面--删除二级分类信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/sortstwo/delete-->后台管理--课程分类页面--删除二级分类信息修改失败了。。。");
        		}
    		}
    		return "redirect:/manager/classify";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--用户管理--通过用户id获取此用户的信息
   	 */
    @RequestMapping(value = "/manager/user/getUserById",produces = "application/json; charset=utf-8", method = RequestMethod.POST) 
    @ResponseBody
    public String managerGetUserById(User u, HttpServletRequest request, HttpSession session){
    	if( u.getUserId() != null ){
    		System.out.println("\n/manager/user/getUserById-----后台管理--用户管理--通过用户id获取此用户的信息-------userId:" + u.getUserId());
    		User user = new User();
    		
    		user = userService.getUser(u.getUserId());
    		System.out.println("user:" + user);
    		System.out.println("user:" + user.toString());
    		JSONObject json = JSONObject.fromObject(user);//将java对象转换为json对象
    		String str = json.toString();//将json对象转换为字符串
    		System.out.println("通过用户id获取此用户的信息----转成json：" + str);
    		return str;
    	}else{
    		System.out.println("userId is null ");
    		return "没有获得id,出错了！！";
    	}
    }
    
    /**
   	 * 	-->后台管理--用户管理---更新用户
   	 */
    @RequestMapping(value = "/manager/user/update", method = RequestMethod.POST)  
    public String managerUserUpdate(User u, HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null ){
    		if( u != null ){
    			// 通过用户修改信息--更新用户数据  
        		int updateRseult = userService.updateUserSelective(u);
        		if( updateRseult == 1 ){
        			System.out.println("\n/manager/user/update-->后台管理--用户管理--用户信息修改成功了！！");
        		}else{
        			System.out.println("\n/manager/user/update-->后台管理--用户管理--用户信息修改失败了。。。");
        		}
    		}
    		return "redirect:/manager/user";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    /**
   	 * 	-->后台管理--用户管理
   	 */
    @RequestMapping(value = "/manager/user", method = RequestMethod.GET)  
    public String managerUser(HttpServletRequest request, HttpSession session){
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	System.out.println("\n/manager/personal-->后台管理---用户管理页面----manager:" + manager);
    	if( manager != null ){
    		
	    	// 获取页面传递过来的三个参数：状态、(登录名/职位/学校)其中之一、当前页数
	    	String userStatus = request.getParameter("userStatus");	//状态
	    	String userId = request.getParameter("userId");			//(登录名/职位/学校)其中之一用userId指代
	    	String page = request.getParameter("page");
	    	if( userId != null ){
	    		userId = userId.trim();	// 去除搜索的空格
	    		if( page == null || page == "" ){
	    			System.out.println("\n/manager/user---userStatus:"+userStatus+", condition:"+userId+", page:1");
	    			
	    		}else{
	    			System.out.println("\n/manager/user---userStatus:"+userStatus+", condition:"+userId+", page:"+page);
	    		}
	    	}else{
	    		if( page == null || page == "" ){
	    			System.out.println("\n/manager/user---userStatus:"+userStatus+", page:1");
	    		}else{
	    			System.out.println("\n/manager/user---userStatus:"+userStatus+", page:"+page);
	    		}
	    	}
	    	
	    	pageSize = 10;	// 每页显示的条数,设置为5条---页面看起来更好
	    	
	    	// 分页
	    	List<User> userList = new ArrayList<User>();
	    	Page pageModel = new Page();
	    	if( page == null || page == "" ){
    			pageFirst = 1;	// 当前页 设置为第一页
    		}else{
    			pageFirst = Integer.parseInt(page);// 当前页
    		}
    		pageModel.setPage(pageFirst);	// 当前页
    		pageModel.setSize(pageSize);	// 每页显示的条数,默认10条
    		int first = (pageFirst-1)*pageSize;	// limit第一个参数
    		
	    	if( userStatus == null || userStatus == "" || userStatus.equals("-1") ){ //此状态时，都不作为查询条件 
	    		int total = 0;
	    		total = userService.getAllUserPageNumberByUserId(userId);	// 总条数
	    		if( total == 0 ){
	    			pageModel.setPage(0);			// 当前页--用于页面显示
	    		}
	    		pageModel.setTotalSize(total);		//总条数
	    		int totalPage = 0;	// 总页数
	    		if( total%pageSize == 0 ){
	    			totalPage = total/pageSize;	
	    		}else{
	    			totalPage=total/pageSize+1;
	    		}
	    		pageModel.setTotalPage(totalPage);	//总页数
	    		
	    		// 通过(登录名/职位/学校)其中之一  来查询分页的用户表
	    		userList = userService.getAllUserPageByUserId(userId, first, pageSize);
	    		
	    	}else{
	    		// int userStatus1 = Integer.parseInt(userStatus);
	    		int total = 0;
	    		total = userService.getAllUserPageNumberByUserStatusAndUserId(userStatus, userId);	// 总条数
	    		if( total == 0 ){
	    			pageModel.setPage(0);			// 当前页--用于页面显示
	    		}
	    		pageModel.setTotalSize(total);		//总条数
	    		int totalPage = 0;	// 总页数
	    		if( total%pageSize == 0 ){
	    			totalPage = total/pageSize;	
	    		}else{
	    			totalPage=total/pageSize+1;
	    		}
	    		pageModel.setTotalPage(totalPage);	//总页数
	    		
	    		// 通过(登录名/职位/学校)其中之一  来查询分页的用户表
	    		userList = userService.getAllUserPageByUserStatusAndUserId(userStatus, userId, first, pageSize);
        	}
	    	
    		if( userList != null && userList.size() > 0 ){
    			//存储数据
        		pageModel.setUserList(userList);
    			System.out.println("\n/manager/user-->后台管理---用户管理页面----userList:" + userList);
    		}
    		request.setAttribute("pageModel", pageModel);
    		
    		if( userStatus != null && userStatus != "" ){
    			request.setAttribute("userStatus", userStatus);
    		}
    		if( userId != null && userId != "" ){
    			request.setAttribute("userId", userId);
    		}
    		
    		return "manager/manager-user";
    		
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    	
        
    }
    
    /**
   	 * 	-->后台管理--个人信息管理
   	 */
    @RequestMapping(value = "/manager/personal")  
    public String managerPersonal(HttpServletRequest request, HttpSession session){
    	System.out.println("\n\n后台管理--个人信息管理:\n");
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	System.out.println("\n/manager/personal-->后台管理---管理员个人信息----manager:" + manager);
    	if( manager != null ){
    		
    		Manager m = new Manager();
    		m = managerService.getManager(manager.getManagerAccount());
        	request.setAttribute("manager", m);
    		return "manager/manager-personal";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
    
    /**
   	 * 	-->后台管理--个人信息修改
   	 */
    @RequestMapping(value = "/manager/personal/update", produces="text/html;charset=UTF-8;")
    public String managerPersonalUpdate(Manager m, HttpServletRequest request, HttpSession session, HttpServletResponse response){
    	System.out.println("\n/manager/personal/update-->管理员个人信息修改------sex:" + m.getManagerSex()+", m:" + m);
    	Manager manager = new Manager();
    	manager = (Manager) session.getAttribute("manager");
    	if( manager != null && m != null ){
    		
    		// 通过用户修改信息--更新用户数据  
    		int updateRseult = managerService.updateManagerSelective(m);
    		if( updateRseult == 1 ){
    			System.out.println("\n/manager/personal/update-->管理员个人信息修改成功了！！");
    		}else{
    			System.out.println("\n/manager/personal/update-->管理员个人信息修改失败了。。。");
    		}
    		
    		/*// 通过管理员账号  查询管理员表 
    		Manager manager1 = new Manager();
    		manager1 = managerService.getManager(manager.getManagerAccount());
    		System.out.println("\n/manager/personal/update-->管理员个人信息修改----manager1:" + manager1);
    		
    		String res = "{\"managerAccount\":\""+manager1.getManagerAccount()+"\","
    					+ "\"managerName\":\""+manager1.getManagerName()+"\","
    					+ "\"managerPassword\":\""+manager1.getManagerPassword()+"\","
    					+ "\"managerSex\":\""+manager1.getManagerSex()+ "\"}";
    		return res;*/
    		return "redirect:/manager/personal";
    	}else{
    		request.setAttribute("errorMsg", "您还未登录，请您先登陆！");
    		return "manager/manager-error";
    	}
    }
    
}  