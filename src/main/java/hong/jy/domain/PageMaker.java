package hong.jy.domain;

import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
    
    private Criteria cri;
    private int totalDataCount;
    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;
    private int displayPageCnt = 10;
    
    public PageMaker(Criteria cri) {
    	this.cri = cri;
    }
    public Criteria getCri() {
        return cri;
    }
    public void setCri(Criteria cri) {
        this.cri = cri;
    }
    public int getTotalDataCount() {
        return totalDataCount;
    }
    public void setTotalDataCount(int totalCount) {
        this.totalDataCount = totalCount;
        calcData();
    }
    
    private void calcData() {
    	
    	int page = this.cri.getPage();
    	int perPageNum = this.cri.getPerPageNum();
    	
    	this.endPage = (int) (Math.ceil(page/(double)displayPageCnt)*displayPageCnt);
        this.startPage = (this.endPage-displayPageCnt) +1;
        
        int tempEndPage = (int) (Math.ceil(totalDataCount / (double) perPageNum));
        if (this.endPage > tempEndPage) {
            	this.endPage = tempEndPage;
        }
        
        this.prev = (startPage != 1);
        this.next = (endPage * perPageNum < totalDataCount);
        
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
    public int getdisplayPageCnt() {
        return displayPageCnt;
    }
    public void setdisplayPageCnt(int displayPageNum) {
        this.displayPageCnt = displayPageNum;
    }
    public String makeQuery(int page) {
    	UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.newInstance()
    			.queryParam("page", page)
    			.queryParam("perPageNum", this.cri.getPerPageNum());
    	//검색한 경우
    	if(this.cri.getSearchType() != null) {
    		uriComponentsBuilder
    			.queryParam("searchType", this.cri.getSearchType())
    			.queryParam("keyword", this.cri.getKeyword());
    	}
    	return uriComponentsBuilder.build().encode().toString();
    }
}
