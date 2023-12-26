package com.human.dto;

import java.util.Date;

public class HireDto {

	private Integer hId;
	private String hName;
	private String hTitle;
	private String hContent;
	private String career;
	private String education;
	private String salary;
	private String location;
	private String type;
	private String time;
	private Date startDate;
	private Date writeDate;
	private Date endDate;
	private int hHit;
	
	@Override
	public String toString() {
		return "HireDto [hId=" + hId + ", hName=" + hName + ", hTitle=" + hTitle + ", hContent=" + hContent
				+ ", career=" + career + ", education=" + education + ", salary=" + salary + ", location=" + location
				+ ", type=" + type + ", time=" + time + ", startDate=" + startDate + ", writeDate=" + writeDate
				+ ", endDate=" + endDate + ", hHit=" + hHit + "]";
	}
	public Integer gethId() {
		return hId;
	}
	public void sethId(Integer hId) {
		this.hId = hId;
	}
	public String gethName() {
		return hName;
	}
	public void sethName(String hName) {
		this.hName = hName;
	}
	public String gethTitle() {
		return hTitle;
	}
	public void sethTitle(String hTitle) {
		this.hTitle = hTitle;
	}
	public String gethContent() {
		return hContent;
	}
	public void sethContent(String hContent) {
		this.hContent = hContent;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getSalary() {
		return salary;
	}
	public void setSalary(String salary) {
		this.salary = salary;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
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
	public int gethHit() {
		return hHit;
	}
	public void sethHit(int hHit) {
		this.hHit = hHit;
	}
	
	
	
	
	
	
	
}