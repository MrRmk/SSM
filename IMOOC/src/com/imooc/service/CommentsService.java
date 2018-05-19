package com.imooc.service;

import java.util.List;

import com.imooc.entity.Comments;

public interface CommentsService {
	
	// 通过评论id 获得一个评论表 对象
	public Comments getComments(int commentsId);
	
	// 查询所有的评论表的数据
	public List<Comments> selectAllComments();
	
	// 通过课程id查找   评论表的集合(关联了评论表+用户表+小节表+章节表)      
	public List<Comments> getAllCommentsByCourseId(int courseId);
	
	// 通过课程id查找   评论表的集合(只关联了评论表+用户表)      
	public List<Comments> getCommentsByCourseId(int courseId);
		
	// 通过课程id和小节id查找   评论表的集合   
	public List<Comments> getAllCommentsByCourseIdAndSmallChapterId(int courseId, int smallChapterId);
		
	// 添加评论
	public int addComments(Comments comment);
	
	// 删除评论
	public int deleteComments(int commentsId);
	
	// 修改评论
	public int updateComments(Comments comment);
	
	// 通过课程id查找   该课程的评论数量
	public int getCommentsNumberByCourseId(int courseId);
		
		
}
