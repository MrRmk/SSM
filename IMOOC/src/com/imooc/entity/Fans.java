package com.imooc.entity;


// 粉丝表
public class Fans {
	
	private int fansId;					// 粉丝id
	
	private String userId;				// 用户id
	
	private String followedUser;		// 关注的人的id(实际为用户id)
	
	private int fansStatus;				// 关注状态(0:取消关注,1:关注)

	private User user;					// 用户对象
	
	public int getFansId() {
		return fansId;
	}

	public void setFansId(int fansId) {
		this.fansId = fansId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFollowedUser() {
		return followedUser;
	}

	public void setFollowedUser(String followedUser) {
		this.followedUser = followedUser;
	}

	public int getFansStatus() {
		return fansStatus;
	}

	public void setFansStatus(int fansStatus) {
		this.fansStatus = fansStatus;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Fans [fansId=" + fansId + ", userId=" + userId + ", followedUser=" + followedUser + ", fansStatus="
				+ fansStatus + ", user=" + user + "]";
	}
	
}
