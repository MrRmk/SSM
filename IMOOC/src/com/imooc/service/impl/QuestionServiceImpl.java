package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.IQuestionDao;
import com.imooc.entity.Question;
import com.imooc.service.QuestionService;


/*
 * @Service注解说明：
	@Service("questionService")注解是告诉Spring，
	当Spring要创建QuestionServiceImpl的的实例时，
	bean的名字必须叫做"questionService"，
	这样当Action需要使用QuestionServiceImpl的的实例时,
	就可以由Spring创建好的"questionService"，然后注入给Action。
*/
@Service("questionService")  
public class QuestionServiceImpl implements QuestionService{  
  
    @Resource(name = "questionDao")  
    private IQuestionDao questionDao;

    // 通过提问id 获得一个提问表 对象
	@Override
	public Question getQuestion(int questionId) {
		return questionDao.getQuestion(questionId);
	}
	
	// 通过提问id 获得一个提问表 对象(关联了提问表+用户表)
	@Override
	public Question getQuestionAndUser(int questionId){
		return questionDao.getQuestionAndUser(questionId);
	}

	// 查询所有的提问表的数据
	@Override
	public List<Question> selectAllQuestion() {
		return questionDao.selectAllQuestion();
	}
	
	// 查询所有的提问表的数据(关联了评论表+用户表)--分页---参数limit(first,pageSize)
	@Override
	public List<Question> selectAllQuestionAndUser(int first, int pageSize){
		return questionDao.selectAllQuestionAndUser(first,pageSize);
	}
	
	// 通过用户id  查询该用户提出的所有问题的总个数
	@Override
	public int getQuestionNumberByUserId(String userId){
		return questionDao.getQuestionNumberByUserId(userId);
	}

	// 通过用户id  查询该用户提出的所有问题表的数据(关联了评论表+用户表)
	@Override
	public List<Question> selectAllQuestionByUserId(String userId){
		return questionDao.selectAllQuestionByUserId(userId);
	}
		
	// 通过课程id查找   提问表的集合(关联了提问表+用户表+小节表+章节表)
	@Override
	public List<Question> getAllQuestionByCourseId(int courseId) {
		return questionDao.getAllQuestionByCourseId(courseId);
	}
	
	// 通过课程id查找   提问表的集合(关联了提问表+用户表 ) 
	@Override
	public List<Question> getQuestionByCourseId(int courseId) {
		return questionDao.getQuestionByCourseId(courseId);
	}
	
	// 通过课程id和小节id查找   提问表的集合
	@Override
	public List<Question> getAllQuestionByCourseIdAndSmallChapterId(int courseId, int smallChapterId) {
		return questionDao.getAllQuestionByCourseIdAndSmallChapterId(courseId, smallChapterId);
	}
		
	// 添加提问记录
	@Override
	public int addQuestion(Question question) {
		return questionDao.addQuestion(question);
	}

	// 删除提问记录
	@Override
	public int deleteQuestion(int questionId) {
		return questionDao.deleteQuestion(questionId);
	}

	// 修改提问记录
	@Override
	public int updateQuestion(Question question) {
		return questionDao.updateQuestion(question);
	}

	// 通过问题id 将 问题的浏览量+1
	@Override
	public int updateQuestionScanNumber(int questionId){
		return questionDao.updateQuestionScanNumber(questionId);
	}
	
	// 通过问题id 将 问题的回答量+1
	@Override
	public int updateQuestionReplyNumber(int questionId){
		return questionDao.updateQuestionReplyNumber(questionId);
	}

	// 查询所有的提问表的数据的总页数 
	@Override
	public int selectAllQuestionAndUserTotal(){
		return questionDao.selectAllQuestionAndUserTotal();
	}
	
	// 通过课程id查找   该课程的提问数量
	@Override
	public int getQuestionNumberByCourseId(int courseId){
		return questionDao.getQuestionNumberByCourseId(courseId);
	}
	
	
} 