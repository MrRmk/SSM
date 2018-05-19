package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.ICommentsDao;
import com.imooc.entity.Comments;
import com.imooc.service.CommentsService;


/*
 * @Service注解说明：
	@Service("commentsService")注解是告诉Spring，
	当Spring要创建CommentsServiceImpl的的实例时，
	bean的名字必须叫做"commentsService"，
	这样当Action需要使用CommentsServiceImpl的的实例时,
	就可以由Spring创建好的"commentsService"，然后注入给Action。
*/
@Service("commentsService")  
public class CommentsServiceImpl implements CommentsService{  
  
    @Resource(name = "commentsDao")  
    private ICommentsDao commentsDao;

    // 通过评论id 获得一个评论表 对象
	@Override
	public Comments getComments(int commentsId) {
		return commentsDao.getComments(commentsId);
	}

	// 查询所有的评论表的数据
	@Override
	public List<Comments> selectAllComments() {
		return commentsDao.selectAllComments();
	}

	// 通过课程id查找   评论表的集合(关联了评论表+用户表+小节表+章节表)    
	@Override
	public List<Comments> getAllCommentsByCourseId(int courseId) {
		return commentsDao.getAllCommentsByCourseId(courseId);
	}
	
	// 通过课程id查找   评论表的集合(只关联了评论表+用户表) 
	@Override
	public List<Comments> getCommentsByCourseId(int courseId) {
		return commentsDao.getCommentsByCourseId(courseId);
	}

	// 通过课程id和小节id查找   评论表的集合
	@Override
	public List<Comments> getAllCommentsByCourseIdAndSmallChapterId(int courseId, int smallChapterId) {
		return commentsDao.getAllCommentsByCourseIdAndSmallChapterId(courseId, smallChapterId);
	}

	// 添加评论
	@Override
	public int addComments(Comments comment) {
		return commentsDao.addComments(comment);
	}

	// 删除评论
	@Override
	public int deleteComments(int commentsId) {
		return commentsDao.deleteComments(commentsId);
	}

	// 修改评论
	@Override
	public int updateComments(Comments comment) {
		return commentsDao.updateComments(comment);
	}

	// 通过课程id查找   该课程的评论数量
	@Override
	public int getCommentsNumberByCourseId(int courseId){
		return commentsDao.getCommentsNumberByCourseId(courseId);
	}

} 