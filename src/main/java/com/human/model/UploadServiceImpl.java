package com.human.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.dao.UploadDao;
@Service
public class UploadServiceImpl implements UploadService {


	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<String> getFiles(Integer bId) throws Exception {
		 UploadDao dao=sqlSession.getMapper(UploadDao.class);
		  
		return dao.getFiles(bId);
	}

	@Override
	public void deleteFile(String fullName) throws Exception {
		UploadDao dao=sqlSession.getMapper(UploadDao.class);
		  dao.deleteFile(fullName);

	}

	@Override
	public void addFile(String fullName, Integer bId) throws Exception {
		UploadDao dao=sqlSession.getMapper(UploadDao.class);
		  dao.addFile(fullName, bId);
	}

	@Override
	public void deleteFileAll(Integer bId) throws Exception {
		UploadDao dao=sqlSession.getMapper(UploadDao.class);
		  dao.deleteFileAll(bId);

	}

}
