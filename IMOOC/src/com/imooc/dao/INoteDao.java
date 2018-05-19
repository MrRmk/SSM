package com.imooc.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.imooc.entity.Note;

/*
	@Repository(value="noteDao")注解是告诉Spring，
	让Spring创建一个名字叫“noteDao”的NoteServiceImpl实例。
	
	当Service需要使用Spring创建的名字叫“noteDao”的NoteServiceImpl实例时，
	就可以使用@Resource(name = "noteDao")注解告诉Spring，
	Spring把创建好的noteDao注入给Service即可。
*/
@Repository("noteDao")  
public interface INoteDao {
	
	// 通过笔记id 获得一个笔记表 对象
	public Note getNote(int noteId);
	
	// 查询所有的笔记表的数据
	public List<Note> selectAllNote();
	
	// 查询所有的笔记表的数据(关联了笔记表+用户表)
	public List<Note> selectAllNoteAndUser(@Param("first")int first, @Param("pageSize")int pageSize);
	
	// 通过用户id  获取该用户所有的笔记(关联了笔记表+用户表)
	public List<Note> selectAllNoteByUserId(String userId);
	
	// 通过用户id  获取该用户所有的笔记总个数(关联了笔记表+用户表)
	public int getNoteNumberByUserId(String userId);
	
	// 通过课程id查找   笔记表的集合(关联了笔记表+用户表+小节表+章节表)   
	public List<Note> getAllNoteByCourseId(int courseId);
	
	// 通过课程id查找   笔记表的集合(关联了笔记表+用户表)   
	public List<Note> getNoteByCourseId(int courseId);
		
	// 通过课程id和小节id查找   笔记表的集合   
	public List<Note> getAllNoteByCourseIdAndSmallChapterId(@Param("courseId")int courseId, @Param("smallChapterId")int smallChapterId);
	
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
