package com.human.model;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.human.dto.StudyDto;
import com.human.vo.StudyPageMaker;

public interface StudyService {

	public void regist(StudyDto study) throws Exception;

	public StudyDto read(Integer sId) throws Exception;

	public void modify(StudyDto study) throws Exception;

	public void studyRemove(Integer sId) throws Exception;

	public List<StudyDto> studyListAll() throws Exception;

	public void increaseViewCount(Integer sId) throws Exception;

	public void sLike(Integer sId) throws Exception;

	public List<StudyDto> listMenu(String sGroupKind) throws Exception;

	public List<String> menuKind() throws Exception;

	public void replyCreate(StudyDto dto) throws Exception;

	public void replyStep(int sGroup, int sStep) throws Exception;

	public List<StudyDto> listSearch(StudyPageMaker spm) throws Exception;

	public List<StudyDto> sGroupKindSearch(StudyPageMaker spm) throws Exception;

	public int listSearchCount(StudyPageMaker spm) throws Exception;

	public int sGroupKindSearchCount(StudyPageMaker spm) throws Exception;

	public String[] category() throws Exception;
}
