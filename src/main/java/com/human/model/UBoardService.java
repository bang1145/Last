package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.UBoardDto;
import com.human.vo.UPageMaker;

public interface UBoardService {

	public void regist(UBoardDto board) throws Exception;

	public UBoardDto read(Integer id) throws Exception;

	public void modify(UBoardDto board) throws Exception;

	public void remove(Integer id) throws Exception;

	public List<UBoardDto> listAll() throws Exception;

	public void increaseViewCount(Integer id) throws Exception;

	public void uLike(Integer id) throws Exception;

	public List<UBoardDto> listMenu(String uGroupKind) throws Exception;

	public List<String> menuKind() throws Exception;
	
	public void replyCreate(UBoardDto dto) throws Exception;
	public void replyStep(int uGroup, int uStep) throws Exception;
	 	
	public List<UBoardDto> listSearch(UPageMaker pm)throws Exception;
	public List<UBoardDto> uGroupKindSearch(UPageMaker pm)throws Exception;
	
	public int listSearchCount(UPageMaker pm) throws Exception;
	public int uGroupKindSearchCount(UPageMaker pm)throws Exception;

	public String[] category() throws Exception;

}
