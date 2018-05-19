package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.IReplyDao;
import com.imooc.entity.Reply;
import com.imooc.service.ReplyService;


/*
 * @Service注解说明：
	@Service("replyService")注解是告诉Spring，
	当Spring要创建ReplyServiceImpl的的实例时，
	bean的名字必须叫做"replyService"，
	这样当Action需要使用ReplyServiceImpl的的实例时,
	就可以由Spring创建好的"replyService"，然后注入给Action。
*/
@Service("replyService")  
public class ReplyServiceImpl implements ReplyService{  
  
    @Resource(name = "replyDao")  
    private IReplyDao replyDao;

    // 通过回复id 获得一个回复表 对象
	@Override
	public Reply getReply(int replyId) {
		return replyDao.getReply(replyId);
	}

	// 查询所有的回复表的数据
	@Override
	public List<Reply> selectAllReply() {
		return replyDao.selectAllReply();
	}
	
	// 通过用户id 获取该用户所有的回答记录
	@Override
	public List<Reply> selectAllReplyByUserId(String userId){
		return replyDao.selectAllReplyByUserId(userId);
	}
	
	// 通过用户id 获取该用户所有的回答记录总个数
	@Override
	public int getReplyNumberByUserId(String userId){
		return replyDao.getReplyNumberByUserId(userId);
	}

	// 通过问题id查找   回复表的集合   
	@Override
	public List<Reply> getAllReplyByQuestionId(int questionId) {
		return replyDao.getAllReplyByQuestionId(questionId);
	}
	
	// 通过问题id查找   回复表中有多少问答个数
	@Override
	public int getReplyCountByQuestionId(int questionId){
		return replyDao.getReplyCountByQuestionId(questionId);
	}

	// 添加回复
	@Override
	public int addReply(Reply reply) {
		return replyDao.addReply(reply);
	}

	// 删除回复
	@Override
	public int deleteReply(int replyId) {
		return replyDao.deleteReply(replyId);
	}

	// 修改回复
	@Override
	public int updateReply(Reply reply) {
		return replyDao.updateReply(reply);
	}

	// 通过课程id查找   该课程所有问题的回复数量
	@Override
	public int getReplyNumberByCourseId(int courseId){
		return replyDao.getReplyNumberByCourseId(courseId);
	}
    
} 