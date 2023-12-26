package com.human.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.StudyReplyDto;

import com.human.vo.StudyPageMaker;

public interface StudyReplyDao {
	
	public void deletesId(Integer sId) throws Exception;

	  public List<StudyReplyDto> list(Integer sId) throws Exception;

	  public void insert(StudyReplyDto dto) throws Exception;

	  public void update(StudyReplyDto dto) throws Exception;

	  public void delete(Integer sId) throws Exception;

	  public List<StudyReplyDto> listPage(
	      @Param("sId") Integer sId, @Param("spm") StudyPageMaker spm) throws Exception;

	  public int count(Integer sId) throws Exception;
	  
	  //대댓
	  public void createReply(StudyReplyDto dto) throws Exception;
	  
//	  public void stepReply(int rGroup, int rStep) throws Exception;
	  public void stepReply(@Param("sGroup") int sGroup, @Param("sStep") int sStep) throws Exception;
	  
	  public StudyReplyDto read(Integer sId) throws Exception; //대댓 위해 추가함

	}





