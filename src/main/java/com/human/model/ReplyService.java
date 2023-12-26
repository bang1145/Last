package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.ReplyDto;
import com.human.vo.PageMaker;

public interface ReplyService {

		  public void addReply(ReplyDto dto) throws Exception;
		  
		

		  public List<ReplyDto> listReply(Integer bId) throws Exception;

		  public void modifyReply(ReplyDto dto) throws Exception;

		  public void removeReply(Integer rId) throws Exception;

		  public List<ReplyDto> listReplyPage(Integer bId, PageMaker pm) throws Exception;

		  public int count(Integer bId) throws Exception;
		  
		  //대댓
		  public void createReply(ReplyDto dto) throws Exception;
		  
		  public void stepReply(@Param("rGroup") int rGroup, @Param("rStep") int rStep) throws Exception;

		  public ReplyDto read(Integer rId) throws Exception; //대댓 위해 추가함
		  
}
