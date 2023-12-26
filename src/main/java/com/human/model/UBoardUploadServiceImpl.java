package com.human.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.dao.UBoardUploadDao;

@Service
public class UBoardUploadServiceImpl implements UBoardUploadService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<String> getFiles(Integer id) throws Exception {
		UBoardUploadDao dao = sqlSession.getMapper(UBoardUploadDao.class);

		return dao.getFiles(id);
	}

	@Override
	public void deleteFile(String fullName) throws Exception {
		UBoardUploadDao dao = sqlSession.getMapper(UBoardUploadDao.class);
		dao.deleteFile(fullName);
	}

	@Override
	public void addFile(String fullName, Integer id) throws Exception {
		UBoardUploadDao dao = sqlSession.getMapper(UBoardUploadDao.class);
		dao.addFile(fullName, id);
	}

	@Override
	public void deleteFileAll(Integer id) throws Exception {
		UBoardUploadDao dao = sqlSession.getMapper(UBoardUploadDao.class);
		dao.deleteFileAll(id);
	}
}