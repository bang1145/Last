package com.human.model;

import java.util.ArrayList;
import com.human.dto.AuthoritiesDto;

public interface AuthoritiesService {
	
	public void autInsert(AuthoritiesDto dto) throws Exception;
	public void autUpdate(AuthoritiesDto dto) throws Exception;
	public void autDelete(String username) throws Exception;
	public ArrayList<AuthoritiesDto> autSelectAll() throws Exception;
	public AuthoritiesDto autSelectName(String username) throws Exception;
}
