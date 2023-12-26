package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.HireDto;
//import org.zerock.domain.Criteria;
//import org.zerock.domain.SearchCriteria;
import com.human.vo.PageMaker;

public interface HireService {

	public void regist(HireDto board) throws Exception;

	public HireDto read(Integer hId) throws Exception;

//	public void modify(HireDto board) throws Exception;

	public void remove(Integer hId) throws Exception;

	public List<HireDto> listAll() throws Exception;

	public void increaseViewCount(Integer hId) throws Exception;

	public void hLike(Integer hId) throws Exception;

	public List<HireDto> listMenu(String hGroupKind) throws Exception;

	public List<String> menuKind() throws Exception;
	
	public void replyCreate(HireDto dto) throws Exception;

	 	
	public List<HireDto> listSearch(PageMaker pm)throws Exception;
	public List<HireDto> hGroupKindSearch(PageMaker pm)throws Exception;
	
	public int listSearchCount(PageMaker pm) throws Exception;
	public int hGroupKindSearchCount(PageMaker pm)throws Exception;

	public String[] category() throws Exception;
}
