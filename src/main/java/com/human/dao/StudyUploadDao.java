package com.human.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.StudyDto;
import com.human.vo.PageMaker;

public interface StudyUploadDao {
	
	public List<String> getFiles(Integer sId)throws Exception;

	public void deleteFile(@Param("fullName")String fullName)throws Exception;

	public void addFile(@Param("fullName")String fullName, @Param("sId")Integer sId)throws Exception;
	public void deleteFileAll(Integer sId)throws Exception;
}
