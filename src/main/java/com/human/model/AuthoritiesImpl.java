package com.human.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.dao.AuthoritiesDao;
import com.human.dto.AuthoritiesDto;

@Service
public class AuthoritiesImpl implements AuthoritiesService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void autInsert(AuthoritiesDto dto) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.autInsert(dto);
	}

	@Override
	public void autUpdate(AuthoritiesDto dto) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.autUpdate(dto);
	}

	@Override
	public void autDelete(String name) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		dao.autDelete(name);
	}

	@Override
	public ArrayList<AuthoritiesDto> autSelectAll() throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		return dao.autSelectAll();
	}

	@Override
	public AuthoritiesDto autSelectName(String name) throws Exception {
		AuthoritiesDao dao = sqlSession.getMapper(AuthoritiesDao.class);
		return dao.autSelectName(name);
	}

}
