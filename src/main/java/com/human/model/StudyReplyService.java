package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.StudyReplyDto;
import com.human.vo.StudyPageMaker;

public interface StudyReplyService {

	public void addReply(StudyReplyDto dto) throws Exception;

	public List<StudyReplyDto> listReply(Integer sId) throws Exception;

	public void modifyReply(StudyReplyDto dto) throws Exception;

	public void removeReply(Integer sId) throws Exception;

	public List<StudyReplyDto> listReplyPage(Integer sId, StudyPageMaker spm) throws Exception;

	public int count(Integer sId) throws Exception;

	// 대댓
	public void createReply(StudyReplyDto dto) throws Exception;

	public void stepReply(@Param("sGroup") int sGroup, @Param("sStep") int sStep) throws Exception;

	public StudyReplyDto read(Integer sId) throws Exception; // 대댓 위해 추가함

}
