package com.imooc.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.imooc.dao.INoteDao;
import com.imooc.entity.Note;
import com.imooc.service.NoteService;


/*
 * @Service注解说明：
	@Service("noteService")注解是告诉Spring，
	当Spring要创建NoteServiceImpl的的实例时，
	bean的名字必须叫做"noteService"，
	这样当Action需要使用NoteServiceImpl的的实例时,
	就可以由Spring创建好的"noteService"，然后注入给Action。
*/
@Service("noteService")  
public class NoteServiceImpl implements NoteService{  
  
    @Resource(name = "noteDao")  
    private INoteDao noteDao;

    // 通过笔记id 获得一个笔记表 对象
	@Override
	public Note getNote(int noteId) {
		return noteDao.getNote(noteId);
	}

	// 查询所有的笔记表的数据
	@Override
	public List<Note> selectAllNote() {
		return noteDao.selectAllNote();
	}
	
	// 查询所有的笔记表的数据(关联了笔记表+用户表)
	@Override
	public List<Note> selectAllNoteAndUser(int first, int pageSize){
		return noteDao.selectAllNoteAndUser(first, pageSize);
	}
	
	// 通过用户id  获取该用户所有的笔记(关联了笔记表+用户表)
	@Override
	public List<Note> selectAllNoteByUserId(String userId){
		return noteDao.selectAllNoteByUserId(userId);
	}
	
	// 通过用户id  获取该用户所有的笔记总个数(关联了笔记表+用户表)
	@Override
	public int getNoteNumberByUserId(String userId){
		return noteDao.getNoteNumberByUserId(userId);
	}

	// 通过课程id查找   笔记表的集合(关联了笔记表+用户表+小节表+章节表)      
	@Override
	public List<Note> getAllNoteByCourseId(int courseId) {
		return noteDao.getAllNoteByCourseId(courseId);
	}
	
	// 通过课程id查找   笔记表的集合(关联了笔记表+用户表) 
	@Override
	public List<Note> getNoteByCourseId(int courseId) {
		return noteDao.getNoteByCourseId(courseId);
	}

	// 通过课程id和小节id查找   笔记表的集合
	@Override
	public List<Note> getAllNoteByCourseIdAndSmallChapterId(int courseId, int smallChapterId) {
		return noteDao.getAllNoteByCourseIdAndSmallChapterId(courseId, smallChapterId);
	}
		
	// 添加笔记
	@Override
	public int addNote(Note note) {
		return noteDao.addNote(note);
	}

	// 删除笔记
	@Override
	public int deleteNote(int noteId) {
		return noteDao.deleteNote(noteId);
	}

	// 修改笔记
	@Override
	public int updateNote(Note note) {
		return noteDao.updateNote(note);
	}
	
	// 查询所有的笔记表的数据的总页数
	@Override
	public int selectAllNoteAndUserTotal(){
		return noteDao.selectAllNoteAndUserTotal();
	}

	// 通过课程id查找   该课程的笔记数量
	@Override
	public int getNoteNumberByCourseId(int courseId){
		return noteDao.getNoteNumberByCourseId(courseId);
	}
	
	// 点赞  通过笔记id  将笔记  点赞量+1
	@Override
	public int updateNoteThumbsUp(int noteId){
		return noteDao.updateNoteThumbsUp(noteId);
	}
		
} 