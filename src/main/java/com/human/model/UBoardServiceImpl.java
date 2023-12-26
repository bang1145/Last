package com.human.model;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.human.dto.UBoardDto;
import com.human.vo.UPageMaker;
import com.human.dao.UBoardDao;
import com.human.dao.UReplyDao;

@Service
public class UBoardServiceImpl implements UBoardService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void regist(UBoardDto board) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		dao.create(board);
	}

	@Override
	public UBoardDto read(Integer id) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		return dao.read(id);
	}

	@Override
	public void modify(UBoardDto board) throws Exception {
		board.setuUpdateTime(new Timestamp(System.currentTimeMillis()));
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		dao.update(board);
	}

//	@Override
//	public void remove(Integer id) throws Exception {
//		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
//		dao.delete(id);
//	}
	//@Transactional
		@Transactional(isolation=Isolation.SERIALIZABLE)
		@Override
		public void remove(Integer id) throws Exception {
			UReplyDao rDao=sqlSession.getMapper(UReplyDao.class);
			UBoardDao dao=sqlSession.getMapper(UBoardDao.class);
			
			rDao.deleteId(id);
			//if(true) throw new Exception();
			dao.delete(id);	
		
		}

	@Override
	public List<UBoardDto> listAll() throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		List<UBoardDto> dtos = dao.listAll();
		// System.out.println(dtos);
		return dtos;
	}

	@Override
	public void increaseViewCount(Integer id) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		dao.increaseViewCount(id);
	}

	@Override
	public void uLike(Integer id) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		dao.uLike(id);
	}

	@Override
	public List<UBoardDto> listMenu(String uGroupKind) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		List<UBoardDto> dtos = dao.listMenu(uGroupKind);
		return dtos;
	}

	public List<String> menuKind() throws Exception {

		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		List<String> dtos = dao.menuKind();

		return dtos;
	}

	// 답글
	@Override
	public void replyCreate(UBoardDto board) throws Exception {
		System.out.println(sqlSession);
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		dao.replyCreate(board);
	}

	@Override
	public void replyStep(int uGroup, int uStep) throws Exception {
		System.out.println(sqlSession);
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		dao.replyStep(uGroup, uStep);
	}

	@Override
	public List<UBoardDto> listSearch(UPageMaker pm) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		return dao.listSearch(pm);
	}

	@Override
	public int listSearchCount(UPageMaker pm) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		return dao.listSearchCount(pm);
	}

	@Override
	public List<UBoardDto> uGroupKindSearch(UPageMaker pm) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		return dao.uGroupKindSearch(pm);
	}

	@Override
	public int uGroupKindSearchCount(UPageMaker pm) throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		return dao.uGroupKindSearchCount(pm);
	}

	@Override
	public String[] category() throws Exception {
		UBoardDao dao = sqlSession.getMapper(UBoardDao.class);
		String[] category = dao.category();
		return category;
	}
}