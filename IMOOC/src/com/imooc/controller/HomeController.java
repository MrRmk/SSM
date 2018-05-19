package com.imooc.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imooc.common.DateUtil;
import com.imooc.entity.User;
import com.imooc.service.UserService;

@Controller  
@RequestMapping(value = "")  
public class HomeController {  
	@Resource(name = "userService")  
    UserService userService;  
    
    /**
	 * 	登录页面
	 */
    @RequestMapping(value = "/login")  
    public String login(HttpSession session){
    	User user = new User();
    	user = (User) session.getAttribute("user");
    	if( user != null ){
    		return "redirect:/me";
    	}
        return "login";
    }
    
    /**
	 * 	用户登录验证成功-->我的页面
	 */
    @RequestMapping(value = "/loginCheck",method=RequestMethod.POST)  
    public String loginCheck(String account, String password, HttpServletRequest request){
    	System.out.println("用户登录---输入的账号和姓名："+account+","+password);
    	User user = userService.getUser(account);
    	if( user != null ){	//如果不等于空说明账号正确
    		if( user.getUserPassword().equals(password) ){
    			if( user.getUserStatus() == 1 ){//等于1，表示用户状态可用，否则“禁用”
    				request.getSession().setAttribute("user",user);
    				return "redirect:/me";
    			}else{
    				request.setAttribute("errMsg","此账号已被禁用！！");
    				return "login";
    			}
			}else{
				request.setAttribute("errMsg","密码错误！！");
				return "login";
			}
    	}else{
    		request.setAttribute("errMsg","账号不存在！！");//账号不存在！
			return "login";
		}
    }
    
    /**
   	 * 	到达-->注册页面
   	 */
    @RequestMapping(value = "/register",method=RequestMethod.GET)  
    public String register(){
    	return "register";
    }
    
    /**
   	 * 	注册页面
   	 */
    @RequestMapping(value = "/registerCheck",method=RequestMethod.POST)  
    public String register(String account, String password, HttpServletRequest request){
    	System.out.println("用户注册---输入的账号和姓名："+account+","+password);
    	User user = new User();
    	user.setUserId(account);
    	user.setUserPassword(password);
    	user.setUserPhoto("anonymous-photo.png");	//设置默认头像
    	user.setUserStatus(1);						//设置默认状态可用
    	DateUtil dateUtil = new DateUtil();
    	//设置注册时间
    	user.setUserRegisterTime(dateUtil.getCurrentTime());
    	int result = userService.addUserSelective(user);
    	if( result == 1 ){	//注册成功
    		System.out.println("用户注册成功");
    		request.setAttribute("message", "注册成功");
    		return "register";
    	}else{	// 注册失败
    		System.out.println("用户注册失败");
    		request.setAttribute("message", "注册失败");
    		return "register";
    	}
    }
    
    /**
   	 * 	退出-->登录页面
   	 */
    @RequestMapping(value = "/layout",method=RequestMethod.GET)  
    public String layout(HttpSession session,HttpServletRequest request){
    	System.out.println("用户退出成功");
    	session.removeAttribute("user");
    	session.invalidate();
    	// System.out.println("用户退出---"+session.getAttribute("user"));
    	return "login";
    }

    
}  