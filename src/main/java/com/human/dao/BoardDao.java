package com.human.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.human.dto.BoardDto;
import com.human.vo.PageMaker;

public interface BoardDao {

	public void create(BoardDto vo) throws Exception;
	
	public void replyCreate(BoardDto dto) throws Exception;
	public void replyStep(@Param("bGroup") int bGroup, @Param("bStep") int bStep) throws Exception;

	public BoardDto read(Integer bId) throws Exception;

	public void update(BoardDto vo) throws Exception;

	public void delete(Integer bId) throws Exception;

	public List<BoardDto> listAll() throws Exception;

	public void increaseViewCount(Integer bId) throws Exception;

	public void bLike(Integer bId) throws Exception;

	public List<BoardDto> listMenu(String bGroupKind) throws Exception;

	public List<String> menuKind() throws Exception;
	
	public List<BoardDto> listSearch(PageMaker pm)throws Exception;
	public List<BoardDto> bGroupKindSearch(PageMaker pm)throws Exception;
	
	public int listSearchCount(PageMaker pm)throws Exception;
	public int bGroupKindSearchCount(PageMaker pm)throws Exception;

	public String[] category() throws Exception;
}
