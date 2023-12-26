package com.human.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class ReplyMaker {
	

	//category 추가해야함 --> 어떤 테이블의 카테고리로 만들건지 ?? 게시판 카테고리별로 만들어야하는데 어케 하는데
	private String bGroupKind;
//	private String bGKsearchType;
	private int page=1;//현재 페이지
	private int perPageNum=10;//페이지당 데이터 개수
	private String searchType;//검색할 컬럼
	private String keyword;//검색 내용
	
	private int totalCount;
	private int totalStartPage=1; // <<(맨 앞 페이지)
	private int totalEndPage; // >>(맨 뒤 페이지)
	private int startPage;//pageMake에서 시작 페이지 번호
	//(int)((totalCount -1 / perPageNum) +1) --> 소수점 없애야하니까 int로 형변환
	private int endPage;//pageMaker에서 마지막 페이지 번호
	private boolean prev;//이전 페이지 번호 목록 이동 --> <
	private boolean next;//다음 페이지 목록 이동 --> >
	//pageMaker에서 사용자에게 제공하는 한 화면에서 보여줄 페이지 개수
	private int displayPageNum = 10;
	
	
	public String getbGroupKind() {
		return bGroupKind;
	}
	public void setbGroupKind(String bGroupKind) {
		this.bGroupKind = bGroupKind;
	}
	
	public int getTotalStartPage() {
		return totalStartPage;
	}
	public void setTotalStartPage(int totalStartPage) {
		this.totalStartPage = totalStartPage;
	}
	public int getTotalEndPage() {
		return totalEndPage;
	}
	public void setTotalEndPage(int totalEndPage) {
		this.totalEndPage = totalEndPage;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page<=0) {
			page=1;
		}
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		if(perPageNum<=0||perPageNum>100) {
			perPageNum=10;
		}
		this.perPageNum = perPageNum;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		//전체 개수를 설정한다음 페이징에 필요한 데이터 값을 생성
		//할 수 있다.
		calcData(); //바로 밑 메소드로 계산해서 출력(?)
	}
	private void calcData() {
		totalStartPage=1;
		totalEndPage=(int)Math.ceil(totalCount/(double)perPageNum);
//		private int endPage;//pageMaker에서 마지막 페이지 번호
	    endPage = (int) (//ceil 올림 floor 내림 round 반올림
	    		Math.ceil(page /(double) displayPageNum)
	    		* displayPageNum);
//	    private int startPage;//pageMake에서 시작 페이지 번호
	    startPage=endPage-displayPageNum+1;
	    if(totalEndPage < endPage) {
	    	endPage=totalEndPage;
	    }
	    
	    if(startPage<1) {
	    	startPage=1;
	    }
	    if(startPage==1) {
	    	prev=false;
	    }else {
	    	prev=true;
	    }
	    if(endPage==totalEndPage) {
	    	next=false;
	    }else {
	    	next=true;
	    }

//		private boolean prev;//이전 페이지 번호 목록 이동
//		private boolean next;//다음 페이지 목록 이동
		
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	@Override
	public String toString() {
		return "PageMaker [page=" + page + ", perPageNum=" + perPageNum + ", searchType=" + searchType + ", keyword="
				+ keyword + ", totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", prev=" + prev + ", next=" + next + "]";
	}
	
	public String makeSearch() {
		UriComponents u=UriComponentsBuilder.newInstance()
				.queryParam("bGroupKind", bGroupKind)
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("keyword", keyword)

				.build();
		return u.toUriString();		
	}
	
	public String makeSearch(int page) {
		UriComponents u=UriComponentsBuilder.newInstance()
				.queryParam("bGroupKind", bGroupKind)
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				
				.queryParam("searchType", searchType)
				.queryParam("keyword", keyword)
				.build();
		return u.toUriString();		
	}
	
	public String makePage(int page) {
		UriComponents u=UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.build();
		return u.toUriString();		
	}
	
	
}