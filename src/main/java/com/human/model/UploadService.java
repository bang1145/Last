package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;


public interface UploadService {
	public List<String> getFiles(Integer bId)throws Exception;

	public void deleteFile(String fullName)throws Exception;

	public void addFile(String fullName, Integer bId)throws Exception;
	public void deleteFileAll(Integer bId)throws Exception;
}
