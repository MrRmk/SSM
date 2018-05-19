package com.imooc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.imooc.entity.Question;

/*
	@Repository(value="questionDao")注解是告诉Spring，
	让Spring创建一个名字叫“questionDao”的QuestionServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“questionDao”的QuestionServiceImpl实例时，
	就可以使用@Resource(name = "questionDao")注解告诉Spring，
	Spring把创建好的questionDao注入给Service即可。
*/
@Repository("questionDao")  
public interface IQuestionDao {
	
	// 通过提问id 获得一个提问表 对象
	public Question getQuestion(int questionId);
	
	// 通过提问id 获得一个提问表 对象(关联了提问表+用户表)
	public Question getQuestionAndUser(int questionId);
	
	// 查询所有的提问表的数据
	public List<Question> selectAllQuestion();
	
	// 查询所有的提问表的数据(关联了评论表+用户表)-----参数limit(first,pageSize)
	public List<Question> selectAllQuestionAndUser(@Param("first")int first, @Param("pageSize")int pageSize);
	
	// 通过用户id  查询该用户提出的所有问题表的数据(关联了评论表+用户表)
	public List<Question> selectAllQuestionByUserId(String userId);
	
	// 通过用户id  查询该用户提出的所有问题的总个数
	public int getQuestionNumberByUserId(String userId);
	
	// 通过课程id查找   提问表的集合(关联了提问表+用户表+小节表+章节表) 
	public List<Question> getAllQuestionByCourseId(int courseId);
	
	// 通过课程id查找   提问表的集合(关联了提问表+用户表 ) 
	public List<Question> getQuestionByCourseId(int courseId);
		
	// 通过课程id和小节id查找   提问表的集合   
	public List<Question> getAllQuestionByCourseIdAndSmallChapterId(@Param("courseId")int courseId, @Param("smallChapterId")int smallChapterId);
	
	// 添加提问记录
	public int addQuestion(Question question);
	
	// 删除提问记录
	public int deleteQuestion(int questionId);
	
	// 修改提问记录
	public int updateQuestion(Question question);
	
	// 通过问题id 将 问题的浏览量+1
	public int updateQuestionScanNumber(int questionId);
	
	// 通过问题id 将 问题的回答量+1
	public int updateQuestionReplyNumber(int questionId);
	
	// 查询所有的提问表的数据的总页数 
	public int selectAllQuestionAndUserTotal();
	
	// 通过课程id查找   该课程的提问数量
	public int getQuestionNumberByCourseId(int courseId);
	
}
