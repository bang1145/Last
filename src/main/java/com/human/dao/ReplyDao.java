package com.human.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.ReplyDto;

import com.human.vo.PageMaker;

public interface ReplyDao {

	  public List<ReplyDto> list(Integer bId) throws Exception;

	  public void insert(ReplyDto dto) throws Exception;

	  public void update(ReplyDto dto) throws Exception;

	  public void delete(Integer rId) throws Exception;

	  public List<ReplyDto> listPage(
	      @Param("bId") Integer bId, @Param("pm") PageMaker pm) throws Exception;

	  public int count(Integer bId) throws Exception;
	  
	  //대댓
	  public void createReply(ReplyDto dto) throws Exception;
	  
//	  public void stepReply(int rGroup, int rStep) throws Exception;
	  public void stepReply(@Param("rGroup") int rGroup, @Param("rStep") int rStep) throws Exception;
	  
	  public ReplyDto read(Integer rId) throws Exception; //대댓 위해 추가함

	}





