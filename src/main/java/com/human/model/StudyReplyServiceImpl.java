package com.human.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;


import com.human.dao.StudyDao;
import com.human.dao.StudyReplyDao;
import com.human.dto.StudyReplyDto;
import com.human.vo.StudyPageMaker;

@Service
public class StudyReplyServiceImpl implements StudyReplyService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addReply(StudyReplyDto dto) throws Exception {
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		dao.insert(dto);
	}

	@Override
	public List<StudyReplyDto> listReply(Integer sId) throws Exception {
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		return dao.list(sId);
	}

	@Override
	public void modifyReply(StudyReplyDto dto) throws Exception {
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		dao.update(dto);
	}

	@Override
	public void removeReply(Integer sId) throws Exception {
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		dao.delete(sId);
	}


	@Override
	public List<StudyReplyDto> listReplyPage(Integer sId, StudyPageMaker spm) throws Exception {
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		return dao.listPage(sId, spm);
	}

	@Override
	public int count(Integer sId) throws Exception {
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		return dao.count(sId);
	}

	// 대댓
	@Override
	public StudyReplyDto read(Integer sId) throws Exception {
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		return dao.read(sId);
	}

	@Override
	public void createReply(StudyReplyDto reply) throws Exception {
		System.out.println(sqlSession);
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		dao.createReply(reply);
	}

	@Override
	public void stepReply(int sGroup, int sStep) throws Exception {
		System.out.println(sqlSession);
		StudyReplyDao dao = sqlSession.getMapper(StudyReplyDao.class);
		dao.stepReply(sGroup, sStep);
	}
}
