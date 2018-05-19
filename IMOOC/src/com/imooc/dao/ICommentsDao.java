package com.imooc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.imooc.entity.Comments;

/*
	@Repository(value="commentsDao")注解是告诉Spring，
	让Spring创建一个名字叫“commentsDao”的CommentsServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“commentsDao”的CommentsServiceImpl实例时，
	就可以使用@Resource(name = "commentsDao")注解告诉Spring，
	Spring把创建好的commentsDao注入给Service即可。
*/
@Repository("commentsDao")  
public interface ICommentsDao {
	
	// 通过评论id 获得一个评论表 对象
	public Comments getComments(int commentsId);
	
	// 查询所有的评论表的数据
	public List<Comments> selectAllComments();
	
	// 通过课程id查找   评论表的集合(关联了评论表+用户表+小节表+章节表)      
	public List<Comments> getAllCommentsByCourseId(int courseId);
	
	// 通过课程id查找   评论表的集合(只关联了评论表+用户表)      
	public List<Comments> getCommentsByCourseId(int courseId);
		
	// 通过课程id和小节id查找   评论表的集合   
	public List<Comments> getAllCommentsByCourseIdAndSmallChapterId(@Param("courseId")int courseId, @Param("smallChapterId")int smallChapterId);
		
	// 添加评论
	public int addComments(Comments comment);
	
	// 删除评论
	public int deleteComments(int commentsId);
	
	// 修改评论
	public int updateComments(Comments comment);
	
	// 通过课程id查找   该课程的评论数量
	public int getCommentsNumberByCourseId(int courseId);
	
	
}
