package com.human.model;

import java.util.List;



import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.human.dao.PartnerDao;
import com.human.dto.PartnerDto;
import com.human.vo.PageMaker;

@Service
public class PartnerServiceImpl implements PartnerService {
	
	@Autowired
	private SqlSession sqlSession;


	@Override
	public void insertPartner(PartnerDto dto) throws Exception {
		PartnerDao dao=sqlSession.getMapper(PartnerDao.class);
		dao.insertPartner(dto);
	}

	@Override
	public PartnerDto readPartner(Integer pId) throws Exception {
		PartnerDao dao=sqlSession.getMapper(PartnerDao.class);
		return dao.readPartner(pId);
	}

	@Override
	public void updatePartner(PartnerDto dto) throws Exception {
		PartnerDao dao=sqlSession.getMapper(PartnerDao.class);
		dao.updatePartner(dto);
	}

	@Override
	public void deletePartner(Integer pId) throws Exception {
		PartnerDao dao=sqlSession.getMapper(PartnerDao.class);
		dao.deletePartner(pId);		
	}

	@Override
	public List<PartnerDto> listPartner() throws Exception {
		PartnerDao dao=sqlSession.getMapper(PartnerDao.class);
		List<PartnerDto> dtos = dao.listPartner();
		return dtos;
	}

	@Override
	public void partnerViewCount(Integer pId) throws Exception {
		PartnerDao dao=sqlSession.getMapper(PartnerDao.class);
		dao.partnerViewCount(pId);		
	}


	
}
