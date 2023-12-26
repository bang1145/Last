package com.human.dto;

import java.util.Date;

public class UBoardDto {

	private String uGroupKind;
	private Integer id;
	private String uName;
	private String uTitle;
	private String uContent;	
	private Date uWriteTime;
	private Date uUpdateTime;
	private int uHit;
	private int uGroup;
	private int uStep;
	private int uIndent;
	private String uDelete;
	private int uLike;
	private int uDislike;
	
	public String getuGroupKind() {
		return uGroupKind;
	}
	public void setuGroupKind(String uGroupKind) {
		this.uGroupKind = uGroupKind;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getuName() {
		return uName;
	}
	public void setuName(String uName) {
		this.uName = uName;
	}
	public String getuTitle() {
		return uTitle;
	}
	public void setuTitle(String uTitle) {
		this.uTitle = uTitle;
	}
	public String getuContent() {
		return uContent;
	}
	public void setuContent(String uContent) {
		this.uContent = uContent;
	}
	public Date getuWriteTime() {
		return uWriteTime;
	}
	public void setuWriteTime(Date uWriteTime) {
		this.uWriteTime = uWriteTime;
	}
	public Date getuUpdateTime() {
		return uUpdateTime;
	}
	public void setuUpdateTime(Date uUpdateTime) {
		this.uUpdateTime = uUpdateTime;
	}
	public int getuHit() {
		return uHit;
	}
	public void setuHit(int uHit) {
		this.uHit = uHit;
	}
	public int getuGroup() {
		return uGroup;
	}
	public void setuGroup(int uGroup) {
		this.uGroup = uGroup;
	}
	public int getuStep() {
		return uStep;
	}
	public void setuStep(int uStep) {
		this.uStep = uStep;
	}
	public int getuIndent() {
		return uIndent;
	}
	public void setuIndent(int uIndent) {
		this.uIndent = uIndent;
	}
	public String getuDelete() {
		return uDelete;
	}
	public void setuDelete(String uDelete) {
		this.uDelete = uDelete;
	}
	public int getuLike() {
		return uLike;
	}
	public void setuLike(int uLike) {
		this.uLike = uLike;
	}
	public int getuDislike() {
		return uDislike;
	}
	public void setuDislike(int uDislike) {
		this.uDislike = uDislike;
	}
	
	@Override
	public String toString() {
		return "BoardDto [uGroupKind=" + uGroupKind + ", id=" + id + ", uName=" + uName + ", uTitle=" + uTitle
				+ ", uContent=" + uContent + ", uWriteTime=" + uWriteTime + ", uUpdateTime=" + uUpdateTime + ", uHit="
				+ uHit + ", uGroup=" + uGroup + ", uStep=" + uStep + ", uIndent=" + uIndent + ", uDelete=" + uDelete
				+ ", uLike=" + uLike + ", uDislike=" + uDislike + "]";
	}
}