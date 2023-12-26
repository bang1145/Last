package com.human.dto;

import java.util.Date;

public class StudyReplyDto {
	private Integer sRId;
	private Integer sId;
	private String sReplytext;
	private String sReplyer;
	private Date sRegdate;
	private Date sUpdatedate;
	
	private String commentType;
	private int sGroup;
	private int sStep;
	private int sIndent;
	private String sDelete;
	
	@Override
	public String toString() {
		return "StudyReplyDto [sRId=" + sRId + ", sId=" + sId + ", sReplytext=" + sReplytext + ", sReplyer=" + sReplyer
				+ ", sRegdate=" + sRegdate + ", sUpdatedate=" + sUpdatedate + ", commentType=" + commentType
				+ ", sGroup=" + sGroup + ", sStep=" + sStep + ", sIndent=" + sIndent + ", sDelete=" + sDelete + "]";
	}

	public Integer getsRId() {
		return sRId;
	}

	public void setsRId(Integer sRId) {
		this.sRId = sRId;
	}

	public Integer getsId() {
		return sId;
	}

	public void setsId(Integer sId) {
		this.sId = sId;
	}

	public String getsReplytext() {
		return sReplytext;
	}

	public void setsReplytext(String sReplytext) {
		this.sReplytext = sReplytext;
	}

	public String getsReplyer() {
		return sReplyer;
	}

	public void setsReplyer(String sReplyer) {
		this.sReplyer = sReplyer;
	}

	public Date getsRegdate() {
		return sRegdate;
	}

	public void setsRegdate(Date sRegdate) {
		this.sRegdate = sRegdate;
	}

	public Date getsUpdatedate() {
		return sUpdatedate;
	}

	public void setsUpdatedate(Date sUpdatedate) {
		this.sUpdatedate = sUpdatedate;
	}

	public String getCommentType() {
		return commentType;
	}

	public void setCommentType(String commentType) {
		this.commentType = commentType;
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
	
}
