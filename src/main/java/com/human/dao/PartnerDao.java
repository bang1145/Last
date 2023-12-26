package com.human.dao;

import java.util.List;
import com.human.dto.PartnerDto;
import com.human.vo.PageMaker;

public interface PartnerDao {
	
	public void insertPartner (PartnerDto dto) throws Exception;
	
	public PartnerDto readPartner(Integer pId) throws Exception;
	
	public void updatePartner(PartnerDto dto) throws Exception;
	
	public void deletePartner(Integer pId) throws Exception;
	
	public List<PartnerDto> listPartner() throws Exception;
	
	public void partnerViewCount(Integer pId) throws Exception;
	
}
