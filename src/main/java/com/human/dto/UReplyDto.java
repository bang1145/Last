package com.human.dto;

import java.util.Date;

public class UReplyDto {
	private Integer urId;
	private Integer id;
	private String rPw;
	private String replytext;
	private String replyer;
	private Date regdate;
	private Date updatedate;
	
	private String commentType;
	private int rGroup;
	private int rStep;
	private int rIndent;
	private String rDelete;
	
	@Override
	public String toString() {
		return "ReplyDto [urId=" + urId + ", id=" + id + ", rPw=" + rPw + ", replytext=" + replytext + ", replyer="
				+ replyer + ", regdate=" + regdate + ", updatedate=" + updatedate + ", commentType=" + commentType
				+ ", rGroup=" + rGroup + ", rStep=" + rStep + ", rIndent=" + rIndent + ", rDelete=" + rDelete + "]";
	}

	public Integer getUrId() {
		return urId;
	}

	public void setUrId(Integer urId) {
		this.urId = urId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getrPw() {
		return rPw;
	}

	public void setrPw(String rPw) {
		this.rPw = rPw;
	}

	public String getReplytext() {
		return replytext;
	}

	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}

	public String getReplyer() {
		return replyer;
	}

	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	public String getCommentType() {
		return commentType;
	}

	public void setCommentType(String commentType) {
		this.commentType = commentType;
	}

	public int getrGroup() {
		return rGroup;
	}

	public void setrGroup(int rGroup) {
		this.rGroup = rGroup;
	}

	public int getrStep() {
		return rStep;
	}

	public void setrStep(int rStep) {
		this.rStep = rStep;
	}

	public int getrIndent() {
		return rIndent;
	}

	public void setrIndent(int rIndent) {
		this.rIndent = rIndent;
	}

	public String getrDelete() {
		return rDelete;
	}

	public void setrDelete(String rDelete) {
		this.rDelete = rDelete;
	}
}