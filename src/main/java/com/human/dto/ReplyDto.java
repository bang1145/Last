package com.human.dto;

import java.util.Date;

public class ReplyDto {
	private Integer rId;
	private Integer bId;
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
		return "ReplyDto [rId=" + rId + ", bId=" + bId + ", replytext=" + replytext + ", replyer=" + replyer
				+ ", regdate=" + regdate + ", updatedate=" + updatedate + ", commentType=" + commentType + ", rGroup="
				+ rGroup + ", rStep=" + rStep + ", rIndent=" + rIndent + ", rDelete=" + rDelete + "]";
	}
	
	
	public String getCommentType() {
		return commentType;
	}


	public void setCommentType(String commentType) {
		this.commentType = commentType;
	}


	public Integer getrId() {
		return rId;
	}

	public void setrId(Integer rId) {
		this.rId = rId;
	}

	public Integer getbId() {
		return bId;
	}

	public void setbId(Integer bId) {
		this.bId = bId;
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
