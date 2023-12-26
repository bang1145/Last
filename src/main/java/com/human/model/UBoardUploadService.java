package com.human.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

public interface UBoardUploadService {
	public List<String> getFiles(Integer id) throws Exception;

	public void deleteFile(String fullName) throws Exception;

	public void addFile(String fullName, Integer id) throws Exception;

	public void deleteFileAll(Integer id) throws Exception;
}
