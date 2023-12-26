package com.human.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PartnerDto {
	private Integer pId;
	private int pHit; //조회수
	private String pTitle; //제목
	private String pContent; //내용
	private String username; //닉네임 -->로그인할 때 정한 닉네임 FK
	private int personnel; //모집인원
	private String progress; //진행방식 -->온라인/오프라인
	private String stack; //기술 스택
	private String pPosition; //모집 포지션
	private String pContact; //연락 방법
	private String expectDate; //예상 기간
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate; //프로젝트 시작일 = 모집마감일
	private Date writeDate; //글 쓴 시간
	private Date endDate; //모집 마감일
	private String pDelete;
	
	
	public Integer getpId() {
		return pId;
	}
	public void setpId(Integer pId) {
		this.pId = pId;
	}
	public int getpHit() {
		return pHit;
	}
	public void setpHit(int pHit) {
		this.pHit = pHit;
	}
	public String getpTitle() {
		return pTitle;
	}
	public void setpTitle(String pTitle) {
		this.pTitle = pTitle;
	}
	public String getpContent() {
		return pContent;
	}
	public void setpContent(String pContent) {
		this.pContent = pContent;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getPersonnel() {
		return personnel;
	}
	public void setPersonnel(int personnel) {
		this.personnel = personnel;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getStack() {
		return stack;
	}
	public void setStack(String stack) {
		this.stack = stack;
	}
	public String getpPosition() {
		return pPosition;
	}
	public void setpPosition(String pPosition) {
		this.pPosition = pPosition;
	}
	public String getpContact() {
		return pContact;
	}
	public void setpContact(String pContact) {
		this.pContact = pContact;
	}
	public String getExpectDate() {
		return expectDate;
	}
	public void setExpectDate(String expectDate) {
		this.expectDate = expectDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public String getpDelete() {
		return pDelete;
	}
	public void setpDelete(String pDelete) {
		this.pDelete = pDelete;
	}
	
	@Override
	public String toString() {
		return "PartnerDto [pId=" + pId + ", pHit=" + pHit + ", pTitle=" + pTitle + ", pContent=" + pContent
				+ ", username=" + username + ", personnel=" + personnel + ", progress=" + progress + ", stack=" + stack
				+ ", pPosition=" + pPosition + ", pContact=" + pContact + ", expectDate=" + expectDate + ", startDate="
				+ startDate + ", writeDate=" + writeDate + ", endDate=" + endDate + ", pDelete=" + pDelete + "]";
	}
}
