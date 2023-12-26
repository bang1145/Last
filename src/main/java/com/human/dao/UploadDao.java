package com.human.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.BoardDto;
import com.human.vo.PageMaker;

public interface UploadDao {
	
	public List<String> getFiles(Integer bId)throws Exception;

	public void deleteFile(@Param("fullName")String fullName)throws Exception;

	public void addFile(@Param("fullName")String fullName, @Param("bId")Integer bId)throws Exception;
	public void deleteFileAll(Integer bId)throws Exception;
}
