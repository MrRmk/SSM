package com.imooc.entity;

import java.io.Serializable;
import java.sql.Timestamp;

// 用户表
@SuppressWarnings("serial")
public class User implements Serializable{  
    private String userId;  			// 账号
  
    private String userPassword;  		// 密码
  
    private String userPhoto;  			// 头像路径
  
    private String userNickName;  		// 昵称
    
    private String userRealName;  		// 姓名
  
    private String userSex;  			// 性别
    
    private String userSummary;  		// 简介
    
    private String userQQ;  			// qq
  
    private String userSchool;			// 学校
    
    private String userEducation;  		// 学历
    
    private String userQualification;  	// 资格证书
  
    private String userPosition;		// 职位

    private Timestamp userRegisterTime;	// 注册时间
    
    private int userStatus;				// 用户状态：1:可用/0:不可用

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	public String getUserNickName() {
		return userNickName;
	}

	public void setUserNickName(String userNickName) {
		this.userNickName = userNickName;
	}

	public String getUserRealName() {
		return userRealName;
	}

	public void setUserRealName(String userRealName) {
		this.userRealName = userRealName;
	}

	public String getUserSex() {
		return userSex;
	}

	public void setUserSex(String userSex) {
		this.userSex = userSex;
	}

	public String getUserSummary() {
		return userSummary;
	}

	public void setUserSummary(String userSummary) {
		this.userSummary = userSummary;
	}

	public String getUserQQ() {
		return userQQ;
	}

	public void setUserQQ(String userQQ) {
		this.userQQ = userQQ;
	}

	public String getUserSchool() {
		return userSchool;
	}

	public void setUserSchool(String userSchool) {
		this.userSchool = userSchool;
	}

	public String getUserEducation() {
		return userEducation;
	}

	public void setUserEducation(String userEducation) {
		this.userEducation = userEducation;
	}

	public String getUserQualification() {
		return userQualification;
	}

	public void setUserQualification(String userQualification) {
		this.userQualification = userQualification;
	}

	public String getUserPosition() {
		return userPosition;
	}

	public void setUserPosition(String userPosition) {
		this.userPosition = userPosition;
	}
	
	public Timestamp getUserRegisterTime() {
		return userRegisterTime;
	}

	public void setUserRegisterTime(Timestamp userRegisterTime) {
		this.userRegisterTime = userRegisterTime;
	}

	public int getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(int userStatus) {
		this.userStatus = userStatus;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userPassword=" + userPassword + ", userPhoto=" + userPhoto
				+ ", userNickName=" + userNickName + ", userRealName=" + userRealName + ", userSex=" + userSex
				+ ", userSummary=" + userSummary + ", userQQ=" + userQQ + ", userSchool=" + userSchool
				+ ", userEducation=" + userEducation + ", userQualification=" + userQualification + ", userPosition="
				+ userPosition + ", userRegisterTime=" + userRegisterTime + ", userStatus=" + userStatus + "]";
	}

    
}  
