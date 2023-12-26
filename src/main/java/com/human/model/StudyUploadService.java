package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;


public interface StudyUploadService {
	public List<String> getFiles(Integer sId)throws Exception;

	public void deleteFile(String fullName)throws Exception;

	public void addFile(String fullName, Integer sId)throws Exception;
	public void deleteFileAll(Integer sId)throws Exception;
}
