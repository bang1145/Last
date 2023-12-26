package com.human.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.human.dto.UBoardDto;
import com.human.vo.UPageMaker;

public interface UBoardUploadDao {
	
	public List<String> getFiles(Integer bId)throws Exception;

	public void deleteFile(@Param("fullName")String fullName)throws Exception;

	public void addFile(@Param("fullName")String fullName, @Param("id")Integer id)throws Exception;
	public void deleteFileAll(Integer bId)throws Exception;
}
