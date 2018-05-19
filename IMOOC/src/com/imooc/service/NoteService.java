package com.imooc.service;

import java.util.List;

import com.imooc.entity.Note;

public interface NoteService {
	
	// 通过笔记id 获得一个笔记表 对象
	public Note getNote(int noteId);
	
	// 查询所有的笔记表的数据
	public List<Note> selectAllNote();
	
	// 查询所有的笔记表的数据(关联了笔记表+用户表)
	public List<Note> selectAllNoteAndUser(int first,int pageSize);
	
	// 通过用户id  获取该用户所有的笔记(关联了笔记表+用户表)
	public List<Note> selectAllNoteByUserId(String userId);
	
	// 通过用户id  获取该用户所有的笔记总个数(关联了笔记表+用户表)
	public int getNoteNumberByUserId(String userId);
	
	// 通过课程id查找   笔记表的集合(关联了笔记表+用户表+小节表+章节表)   
	public List<Note> getAllNoteByCourseId(int courseId);
		
	// 通过课程id查找   笔记表的集合(关联了笔记表+用户表)   
	public List<Note> getNoteByCourseId(int courseId);
		
	// 通过课程id和小节id查找   笔记表的集合   
	public List<Note> getAllNoteByCourseIdAndSmallChapterId(int courseId, int smallChapterId);
	
	// 添加笔记
	public int addNote(Note note);
	
	// 删除笔记
	public int deleteNote(int noteId);
	
	// 修改笔记
	public int updateNote(Note note);
	
	// 查询所有的笔记表的数据的总页数
	public int selectAllNoteAndUserTotal();
	
	// 通过课程id查找   该课程的笔记数量
	public int getNoteNumberByCourseId(int courseId);
	
	// 点赞  通过笔记id  将笔记  点赞量+1
	public int updateNoteThumbsUp(int noteId);
		
		
}
