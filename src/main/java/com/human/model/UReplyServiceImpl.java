package com.human.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.human.dao.UBoardDao;
import com.human.dao.UReplyDao;
import com.human.dto.UBoardDto;
import com.human.dto.UReplyDto;
import com.human.vo.UPageMaker;

@Service
public class UReplyServiceImpl implements UReplyService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void addReply(UReplyDto dto) throws Exception {
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		dao.insert(dto);
	}

	@Override
	public List<UReplyDto> listReply(Integer id) throws Exception {
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		return dao.list(id);
	}

	@Override
	public void modifyReply(UReplyDto dto) throws Exception {
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		dao.update(dto);
	}

	@Override
	public void removeReply(Integer urId, String rPw) throws Exception {
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		dao.delete(urId, rPw);
	}
	
//	@Transactional(isolation=Isolation.SERIALIZABLE)
	@Override
	public List<UReplyDto> listReplyPage(Integer id, UPageMaker cri) throws Exception {
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		return dao.listPage(id, cri);
	}

//	@Transactional(isolation=Isolation.SERIALIZABLE)
//	@Override
//	public void remove(int bno) throws Exception {
//	ReplyDAO rDao = sqlSession.getMapper(ReplyDAO.class);
//
//	BoardDAO dao = sqlSession.getMapper(BoardDAO.class);
//	rDao.deleteBno(bno);
//	dao.delete(bno);
//	}
	
	@Override
	public int count(Integer id) throws Exception {
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		return dao.count(id);
	}

	// 대댓
	@Override
	public UReplyDto read(Integer urId) throws Exception {
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		return dao.read(urId);
	}

	@Override
	public void createReply(UReplyDto reply) throws Exception {
		System.out.println(sqlSession);
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		dao.createReply(reply);
	}

	@Override
	public void stepReply(int rGroup, int rStep) throws Exception {
		System.out.println(sqlSession);
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		dao.stepReply(rGroup, rStep);
	}

	@Override
	public String getReplyPassword(Integer urId) throws Exception {
		System.out.println(sqlSession);
		UReplyDao dao = sqlSession.getMapper(UReplyDao.class);
		return dao.getReplyPassword(urId);
	}
}