package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.UReplyDto;
import com.human.vo.UPageMaker;

public interface UReplyService {

	public void addReply(UReplyDto dto) throws Exception;

	public List<UReplyDto> listReply(Integer id) throws Exception;

	public void modifyReply(UReplyDto dto) throws Exception;

	public void removeReply(@Param("urId") Integer urId, @Param("rPw") String rPw) throws Exception;

	public List<UReplyDto> listReplyPage(Integer id, UPageMaker pm) throws Exception;

	public int count(Integer id) throws Exception;

	// 대댓
	public void createReply(UReplyDto dto) throws Exception;

	public void stepReply(@Param("rGroup") int rGroup, @Param("rStep") int rStep) throws Exception;

	public UReplyDto read(Integer urId) throws Exception; // 대댓 위해 추가함
	
	public String getReplyPassword(Integer urId) throws Exception;//비번 가져오는거
}
