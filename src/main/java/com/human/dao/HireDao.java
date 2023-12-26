package com.human.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.human.dto.HireDto;
import com.human.vo.PageMaker;

public interface HireDao {

	public void create(HireDto vo) throws Exception;
	
	public void replyCreate(HireDto dto) throws Exception;

	public HireDto read(Integer hId) throws Exception;

	public void update(HireDto vo) throws Exception;

	public void delete(Integer hId) throws Exception;

	public List<HireDto> listAll() throws Exception;

	public void increaseViewCount(Integer hId) throws Exception;

	public void bLike(Integer hId) throws Exception;

	public List<HireDto> listMenu(String hGroupKind) throws Exception; // 아직 hGrouopKind 없음

	public List<String> menuKind() throws Exception;
	
	public List<HireDto> listSearch(PageMaker pm)throws Exception;
	public List<HireDto> hGroupKindSearch(PageMaker pm)throws Exception;
	
	public int listSearchCount(PageMaker pm)throws Exception;
	public int hGroupKindSearchCount(PageMaker pm)throws Exception;

	public String[] category() throws Exception;
}
