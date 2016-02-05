package com.secsm.conf;

public class Printpaging {
	
	private int firstPage;		//첫번재 페이지 번호
	private int lastPage;		//마지막 페이지 번호
	private int prevLink;		// 이전 링크
	private int nextLink;		// 다음 링크
	private int startRecord;	// 목록을 구할 때 쓰이는 ROWNUM 시작
	private int endRecord;		// 목록을 구할 때 쓰이는 ROWNUM 끝
	private int listNo;			// 목록에서 위에서 순서대로 붙여지는 번호
	private int[] pageLink;		// 첫번재 페이지 번호부터 시작하여 1씩 증가하여 마지막 페이지 번호까지 나태내는 배열
	
	public Printpaging(int totalRecord, int curPage, int numPerPage, int pageperBlock){
		
		//총페이지 수
		int totalPage = ((totalRecord % numPerPage) == 0) ? totalRecord / numPerPage : totalRecord/numPerPage +1 ;
		
		//한 블럭  <-- 1 2 3 4 5-->
		int totalBlock = ((totalPage % pageperBlock) == 0) ? totalPage / pageperBlock : totalPage / pageperBlock + 1;
		
		//현재 블러
		 int block = ((curPage % pageperBlock) == 0) ? 
				   curPage / pageperBlock : curPage / pageperBlock + 1;
		
		this.firstPage = (block-1)*pageperBlock + 1;
		this.lastPage = block * pageperBlock;
		
		if(block >= totalBlock){
			this.lastPage = totalPage;
		}
		
		pageLink = makeArray(firstPage, lastPage);
		
		if (block > 1) {
			   this.prevLink = firstPage - 1;
			  }
			  if (block < totalBlock) {
			   this.nextLink = lastPage + 1;
			  }
			  this.listNo = totalRecord - (curPage - 1) * numPerPage;
			  this.startRecord = (curPage - 1) * numPerPage + 1;
			  this.endRecord = startRecord + numPerPage - 1;
	
	}
	
	private int[] makeArray(int first, int last) {
		  int size = last - first + 1;
		  int[] ret = new int[size]; 
		  for (int i = 0; i < size; i++) {
		   ret[i] = first++;
		  }
		  
		  return ret;
	}
	
	public int getFirstPage() {
		  return firstPage;
		 }

		 public int getLastPage() {
		  return lastPage;
		 }

		 public int getPrevLink() {
		  return prevLink;
		 }

		 public int getNextLink() {
		  return nextLink;
		 }

		 public int getStartRecord() {
		  return startRecord;
		 }

		 public int getEndRecord() {
		  return endRecord;
		 }

		 public int getListNo() {
		  return listNo;
		 }

		public int[] getPageLink() {
			return pageLink;
		}
}
