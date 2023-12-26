package com.human.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.dao.StudyUploadDao;

@Service
public class StudyUploadServiceImpl implements StudyUploadService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<String> getFiles(Integer sId) throws Exception {
		StudyUploadDao dao = sqlSession.getMapper(StudyUploadDao.class);

		return dao.getFiles(sId);
	}

	@Override
	public void deleteFile(String fullName) throws Exception {
		StudyUploadDao dao = sqlSession.getMapper(StudyUploadDao.class);
		dao.deleteFile(fullName);
	}

	@Override
	public void addFile(String fullName, Integer sId) throws Exception {
		StudyUploadDao dao = sqlSession.getMapper(StudyUploadDao.class);
		dao.addFile(fullName, sId);
	}

	@Override
	public void deleteFileAll(Integer sId) throws Exception {
		StudyUploadDao dao = sqlSession.getMapper(StudyUploadDao.class);
		dao.deleteFileAll(sId);
	}
}