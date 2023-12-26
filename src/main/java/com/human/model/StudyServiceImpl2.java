package com.human.model;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.human.dto.StudyDto;
import com.human.vo.StudyPageMaker;
import com.human.dao.StudyDao;
import com.human.dao.StudyReplyDao;

@Service
public class StudyServiceImpl2 implements StudyService {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void regist(StudyDto study) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		dao.create(study);
	}

	@Override
	public StudyDto read(Integer sId) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		return dao.read(sId);
	}

	@Override
	public void modify(StudyDto study) throws Exception {
		study.setsUpdateTime(new Timestamp(System.currentTimeMillis()));
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		dao.update(study);
	}

//	@Override
//	public void studyRemove(Integer sId) throws Exception {
//		StudyDao dao = sqlSession.getMapper(StudyDao.class);
//		dao.delete(sId);
//	}
	
	//@Transactional
	@Transactional(isolation=Isolation.SERIALIZABLE)
	@Override
	public void studyRemove(Integer sId) throws Exception {
		StudyReplyDao rDao=sqlSession.getMapper(StudyReplyDao.class);
		StudyDao dao=sqlSession.getMapper(StudyDao.class);
		
		rDao.deletesId(sId);
		//if(true) throw new Exception();
		dao.delete(sId);	
	}

	@Override
	public List<StudyDto> studyListAll() throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		List<StudyDto> dtos = dao.studyListAll();
		// System.out.println(dtos);
		return dtos;
	}

	@Override
	public void increaseViewCount(Integer sId) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		dao.increaseViewCount(sId);
	}

	@Override
	public void sLike(Integer sId) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		dao.sLike(sId);
	}

	@Override
	public List<StudyDto> listMenu(String sGroupKind) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		List<StudyDto> dtos = dao.listMenu(sGroupKind);
		return dtos;
	}

	public List<String> menuKind() throws Exception {

		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		List<String> dtos = dao.menuKind();

		return dtos;
	}

	// 답글
	@Override
	public void replyCreate(StudyDto study) throws Exception {
		System.out.println(sqlSession);
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		dao.replyCreate(study);
	}

	@Override
	public void replyStep(int sGroup, int sStep) throws Exception {
		System.out.println(sqlSession);
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		dao.replyStep(sGroup, sStep);
	}

	@Override
	public List<StudyDto> listSearch(StudyPageMaker spm) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		return dao.listSearch(spm);
	}

	@Override
	public int listSearchCount(StudyPageMaker spm) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		return dao.listSearchCount(spm);
	}

	@Override
	public List<StudyDto> sGroupKindSearch(StudyPageMaker spm) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		return dao.sGroupKindSearch(spm);
	}

	@Override
	public int sGroupKindSearchCount(StudyPageMaker spm) throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		return dao.sGroupKindSearchCount(spm);
	}

	@Override
	public String[] category() throws Exception {
		StudyDao dao = sqlSession.getMapper(StudyDao.class);
		String[] category = dao.category();
		return category;
	}
}