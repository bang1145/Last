package com.human.model;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.human.dto.HireDto;
import com.human.vo.PageMaker;
//import org.zerock.domain.Criteria;
//import org.zerock.domain.SearchCriteria;
import com.human.dao.HireDao;

@Service
public class HireServiceImpl implements HireService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void regist(HireDto board) throws Exception {
		HireDao dao = sqlSession.getMapper(HireDao.class);
		dao.create(board);
	}

	@Override
	public HireDto read(Integer hId) throws Exception {
		HireDao dao = sqlSession.getMapper(HireDao.class);
		return dao.read(hId);
	}

//	@Override
//	public void modify(HireDto board) throws Exception {
//		board.setbUpdateTime(new Timestamp(System.currentTimeMillis()));
//		HireDao dao = sqlSession.getMapper(HireDao.class);
//		dao.update(board);
//	}

	@Override
	public void remove(Integer hId) throws Exception {
		HireDao dao = sqlSession.getMapper(HireDao.class);
		dao.delete(hId);
	}

	@Override
	public List<HireDto> listAll() throws Exception {
		HireDao dao = sqlSession.getMapper(HireDao.class);
		List<HireDto> dtos = dao.listAll();
		// System.out.println(dtos);
		return dtos;
	}

	@Override
	public void increaseViewCount(Integer hId) throws Exception {
		HireDao dao = sqlSession.getMapper(HireDao.class);
		dao.increaseViewCount(hId);
	}

	@Override
	public void hLike(Integer hId) throws Exception {
		HireDao dao = sqlSession.getMapper(HireDao.class);
		dao.bLike(hId);
	}

	@Override
	public List<HireDto> listMenu(String hGroupKind) throws Exception {
		HireDao dao = sqlSession.getMapper(HireDao.class);
		List<HireDto> dtos = dao.listMenu(hGroupKind);
		return dtos;
	}

	public List<String> menuKind() throws Exception {

		HireDao dao = sqlSession.getMapper(HireDao.class);
		List<String> dtos = dao.menuKind();

		return dtos;
	}
	
	//답글
	@Override
	public void replyCreate(HireDto board) throws Exception {
		System.out.println(sqlSession);
		HireDao dao=sqlSession.getMapper(HireDao.class);
		dao.replyCreate(board);
	}
	
//	@Override
//	public void replyStep(int hGroup, int hStep) throws Exception {
//		System.out.println(sqlSession);
//		HireDao dao=sqlSession.getMapper(HireDao.class);
//		dao.replyStep(bGroup, bStep);
//	}
	
	@Override
	public List<HireDto> listSearch(PageMaker pm) throws Exception {
		HireDao dao=sqlSession.getMapper(HireDao.class);
		return dao.listSearch(pm);
	}

	@Override
	public int listSearchCount(PageMaker pm) throws Exception {
		HireDao dao=sqlSession.getMapper(HireDao.class);
		return dao.listSearchCount(pm);
	}
	
	@Override
	public List<HireDto> hGroupKindSearch(PageMaker pm) throws Exception {
		HireDao dao=sqlSession.getMapper(HireDao.class);
		return dao.hGroupKindSearch(pm);
	}

	@Override
	public int hGroupKindSearchCount(PageMaker pm) throws Exception {
		HireDao dao=sqlSession.getMapper(HireDao.class);
		return dao.hGroupKindSearchCount(pm);
	}

	@Override
	   public String[] category() throws Exception {
	      HireDao dao=sqlSession.getMapper(HireDao.class);
	      String[] category=dao.category();
	      return category;
	   }
}