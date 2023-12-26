package com.human.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.human.dao.BoardDao;
import com.human.dao.ReplyDao;
import com.human.dto.BoardDto;
import com.human.dto.ReplyDto;
import com.human.vo.PageMaker;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private SqlSession sqlSession;
	
  @Override
  public void addReply(ReplyDto dto) throws Exception {
	  ReplyDao dao=sqlSession.getMapper(ReplyDao.class);
	  dao.insert(dto);
  }

  @Override
  public List<ReplyDto> listReply(Integer bId) throws Exception {
	  ReplyDao dao=sqlSession.getMapper(ReplyDao.class);
    return dao.list(bId);
  }

  @Override
  public void modifyReply(ReplyDto dto) throws Exception {
	  ReplyDao dao=sqlSession.getMapper(ReplyDao.class);
    dao.update(dto);
  }

  @Override
  public void removeReply(Integer rId) throws Exception {
	  ReplyDao dao=sqlSession.getMapper(ReplyDao.class);
    dao.delete(rId);
  }
  @Override
  public List<ReplyDto> listReplyPage(Integer bId, PageMaker cri) 
      throws Exception {
	  ReplyDao dao=sqlSession.getMapper(ReplyDao.class);
    return dao.listPage(bId, cri);
  }
  @Override
  public int count(Integer bId) throws Exception {
	  ReplyDao dao=sqlSession.getMapper(ReplyDao.class);
    return dao.count(bId);
  }
  
  
  // 대댓
	@Override
	public ReplyDto read(Integer rId) throws Exception {
		ReplyDao dao = sqlSession.getMapper(ReplyDao.class);
		return dao.read(rId);
	}
	
	@Override
	public void createReply(ReplyDto reply) throws Exception {
		System.out.println(sqlSession);
		ReplyDao dao=sqlSession.getMapper(ReplyDao.class);
		dao.createReply(reply);
	}
	
	@Override
	public void stepReply(int rGroup, int rStep) throws Exception {
		System.out.println(sqlSession);
		ReplyDao dao=sqlSession.getMapper(ReplyDao.class);
		dao.stepReply(rGroup, rStep);
	}
}
