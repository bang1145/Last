package com.human.dto;

import java.util.Date;

public class StudyDto {
	private String sGroupKind;
	private Integer sId;
	private String sName;
	private String sTitle;
	private String sContent;
	private String sEtc;
	private Date sWriteTime;
	private Date sUpdateTime;
	private int sHit;
	private int sGroup;
	private int sStep;
	private int sIndent;
	private String sDelete;
	private int sLike;
	private int sDislike;

	@Override
	public String toString() {
		return "StudyDto [sGroupKind=" + sGroupKind + ", sId=" + sId + ", sName=" + sName + ", sTitle=" + sTitle
				+ ", sContent=" + sContent + ", sEtc=" + sEtc + ", sWriteTime=" + sWriteTime + ", sUpdateTime="
				+ sUpdateTime + ", sHit=" + sHit + ", sGroup=" + sGroup + ", sStep=" + sStep + ", sIndent=" + sIndent
				+ ", sDelete=" + sDelete + ", sLike=" + sLike + ", sDislike=" + sDislike + "]";
	}

	public String getsGroupKind() {
		return sGroupKind;
	}

	public void setsGroupKind(String sGroupKind) {
		this.sGroupKind = sGroupKind;
	}

	public Integer getsId() {
		return sId;
	}

	public void setsId(Integer sId) {
		this.sId = sId;
	}

	public String getsName() {
		return sName;
	}

	public void setsName(String sName) {
		this.sName = sName;
	}

	public String getsTitle() {
		return sTitle;
	}

	public void setsTitle(String sTitle) {
		this.sTitle = sTitle;
	}

	public String getsContent() {
		return sContent;
	}

	public void setsContent(String sContent) {
		this.sContent = sContent;
	}

	public String getsEtc() {
		return sEtc;
	}

	public void setsEtc(String sEtc) {
		this.sEtc = sEtc;
	}

	public Date getsWriteTime() {
		return sWriteTime;
	}

	public void setsWriteTime(Date sWriteTime) {
		this.sWriteTime = sWriteTime;
	}

	public Date getsUpdateTime() {
		return sUpdateTime;
	}

	public void setsUpdateTime(Date sUpdateTime) {
		this.sUpdateTime = sUpdateTime;
	}

	public int getsHit() {
		return sHit;
	}

	public void setsHit(int sHit) {
		this.sHit = sHit;
	}

	public int getsGroup() {
		return sGroup;
	}

	public void setsGroup(int sGroup) {
		this.sGroup = sGroup;
	}

	public int getsStep() {
		return sStep;
	}

	public void setsStep(int sStep) {
		this.sStep = sStep;
	}

	public int getsIndent() {
		return sIndent;
	}

	public void setsIndent(int sIndent) {
		this.sIndent = sIndent;
	}

	public String getsDelete() {
		return sDelete;
	}

	public void setsDelete(String sDelete) {
		this.sDelete = sDelete;
	}

	public int getsLike() {
		return sLike;
	}

	public void setsLike(int sLike) {
		this.sLike = sLike;
	}

	public int getsDislike() {
		return sDislike;
	}

	public void setsDislike(int sDislike) {
		this.sDislike = sDislike;
	}

}
