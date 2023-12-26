package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.BoardDto;
//import org.zerock.domain.Criteria;
//import org.zerock.domain.SearchCriteria;
import com.human.vo.PageMaker;

public interface BoardService {

	public void regist(BoardDto board) throws Exception;

	public BoardDto read(Integer bId) throws Exception;

	public void modify(BoardDto board) throws Exception;

	public void remove(Integer bId) throws Exception;

	public List<BoardDto> listAll() throws Exception;

	public void increaseViewCount(Integer bId) throws Exception;

	public void bLike(Integer bId) throws Exception;

	public List<BoardDto> listMenu(String bGroupKind) throws Exception;

	public List<String> menuKind() throws Exception;
	
	public void replyCreate(BoardDto dto) throws Exception;
	public void replyStep(int bGroup, int bStep) throws Exception;
	 	
	public List<BoardDto> listSearch(PageMaker pm)throws Exception;
	public List<BoardDto> bGroupKindSearch(PageMaker pm)throws Exception;
	
	public int listSearchCount(PageMaker pm) throws Exception;
	public int bGroupKindSearchCount(PageMaker pm)throws Exception;

	public String[] category() throws Exception;
}
