package com.human.model;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.human.dto.BoardDto;
import com.human.vo.PageMaker;
//import org.zerock.domain.Criteria;
//import org.zerock.domain.SearchCriteria;
import com.human.dao.BoardDao;

@Service
public class BoardServiceImpl2 implements BoardService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void regist(BoardDto board) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.create(board);
	}

	@Override
	public BoardDto read(Integer bId) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		return dao.read(bId);
	}

	@Override
	public void modify(BoardDto board) throws Exception {
		board.setbUpdateTime(new Timestamp(System.currentTimeMillis()));
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.update(board);
	}

	@Override
	public void remove(Integer bId) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.delete(bId);
	}

	@Override
	public List<BoardDto> listAll() throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		List<BoardDto> dtos = dao.listAll();
		// System.out.println(dtos);
		return dtos;
	}

	@Override
	public void increaseViewCount(Integer bId) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.increaseViewCount(bId);
	}

	@Override
	public void bLike(Integer bId) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		dao.bLike(bId);
	}

	@Override
	public List<BoardDto> listMenu(String bGroupKind) throws Exception {
		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		List<BoardDto> dtos = dao.listMenu(bGroupKind);
		return dtos;
	}

	public List<String> menuKind() throws Exception {

		BoardDao dao = sqlSession.getMapper(BoardDao.class);
		List<String> dtos = dao.menuKind();

		return dtos;
	}
	
	//답글
	@Override
	public void replyCreate(BoardDto board) throws Exception {
		System.out.println(sqlSession);
		BoardDao dao=sqlSession.getMapper(BoardDao.class);
		dao.replyCreate(board);
	}
	
	@Override
	public void replyStep(int bGroup, int bStep) throws Exception {
		System.out.println(sqlSession);
		BoardDao dao=sqlSession.getMapper(BoardDao.class);
		dao.replyStep(bGroup, bStep);
	}
	
	@Override
	public List<BoardDto> listSearch(PageMaker pm) throws Exception {
		BoardDao dao=sqlSession.getMapper(BoardDao.class);
		return dao.listSearch(pm);
	}

	@Override
	public int listSearchCount(PageMaker pm) throws Exception {
		BoardDao dao=sqlSession.getMapper(BoardDao.class);
		return dao.listSearchCount(pm);
	}
	
	@Override
	public List<BoardDto> bGroupKindSearch(PageMaker pm) throws Exception {
		BoardDao dao=sqlSession.getMapper(BoardDao.class);
		return dao.bGroupKindSearch(pm);
	}

	@Override
	public int bGroupKindSearchCount(PageMaker pm) throws Exception {
		BoardDao dao=sqlSession.getMapper(BoardDao.class);
		return dao.bGroupKindSearchCount(pm);
	}

	@Override
	   public String[] category() throws Exception {
	      BoardDao dao=sqlSession.getMapper(BoardDao.class);
	      String[] category=dao.category();
	      return category;
	   }
}