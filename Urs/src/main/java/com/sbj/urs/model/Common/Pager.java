
/*
 * paging 처占쏙옙占쏙옙 占쏙옙占쎈성占쏙옙 占쏙옙占쏙옙 클占쏙옙占쏙옙 占쏙옙占쏙옙
 */
package com.sbj.urs.model.Common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class Pager {
	private int totalRecord;//占쏙옙 占쏙옙占쌘듸옙 占쏙옙
	private int pageSize=10; //占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쌘듸옙占�
	private int totalPage;
	private int blockSize=10; //占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
	private int currentPage = 1 ; //占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙
	private int firstPage ;
	private int lastPage ;

	private int curPos ;//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙index
	private int num; //占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쌜뱄옙호
	
	//占쏙옙占쏙옙占� 占쏙옙占쏙옙 占십깍옙화
	public void init(HttpServletRequest request,List list) {
		//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙荑� 占쏙옙 占쏙옙占시듸옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙체
		if(request.getParameter("currentPage") !=null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		totalRecord = list.size();
		totalPage  = ((int)Math.ceil((float)totalRecord/pageSize));
		firstPage = currentPage-(currentPage-1)%blockSize;
		lastPage = firstPage + (blockSize-1);
		curPos = (currentPage-1)*pageSize;
		num =totalRecord-curPos ;
		

	}
	
	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getCurPos() {
		return curPos;
	}

	public void setCurPos(int curPos) {
		this.curPos = curPos;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
}
