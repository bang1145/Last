package com.human.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.dao.UserDao;
import com.human.dto.UserDto;
//실제 구현부
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void userInsert(UserDto dto) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		dao.userInsert(dto);
	}

	@Override
	public void userUpdate(UserDto dto) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		dao.userUpdate(dto);
	}

	@Override
	public void userDelete(String username) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		dao.userDelete(username);
	}

	@Override
	public ArrayList<UserDto> userSelectAll() throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		return dao.userSelectAll();
	}

	@Override
	public UserDto userSelectName(String username) throws Exception {
		UserDao dao=sqlSession.getMapper(UserDao.class);
		return dao.userSelectName(username);
	}
	



}
