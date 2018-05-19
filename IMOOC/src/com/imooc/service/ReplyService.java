package com.imooc.service;

import java.util.List;

import com.imooc.entity.Reply;

public interface ReplyService {
	
	// 通过回复id 获得一个回复表 对象
	public Reply getReply(int replyId);
	
	// 查询所有的回复表的数据
	public List<Reply> selectAllReply();
	
	// 通过用户id 获取该用户所有的回答记录
	public List<Reply> selectAllReplyByUserId(String userId);
	
	// 通过用户id 获取该用户所有的回答记录总个数
	public int getReplyNumberByUserId(String userId);
	
	// 通过问题id查找   回复表的集合   
	public List<Reply> getAllReplyByQuestionId(int questionId);		
	
	// 通过问题id查找   回复表中有多少问答个数
	public int getReplyCountByQuestionId(int questionId);
	
	// 添加回复
	public int addReply(Reply reply);
	
	// 删除回复
	public int deleteReply(int replyId);
	
	// 修改回复
	public int updateReply(Reply reply);
	
	// 通过课程id查找   该课程所有问题的回复数量
	public int getReplyNumberByCourseId(int courseId);
}
