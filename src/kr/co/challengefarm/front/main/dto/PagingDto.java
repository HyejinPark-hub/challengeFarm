/**
 * YOU ARE STRICTLY PROHIBITED TO COPY, DISCLOSE, DISTRIBUTE, MODIFY OR USE THIS PROGRAM
 * IN PART OR AS A WHOLE WITHOUT THE PRIOR WRITTEN CONSENT OF HIMEDIA.CO.KR.
 * HIMEDIA.CO.KR OWNS THE INTELLECTUAL PROPERTY RIGHTS IN AND TO THIS PROGRAM.
 * COPYRIGHT (C) 2024 HIMEDIA.CO.KR ALL RIGHTS RESERVED.
 *
 * 하기 프로그램에 대한 저작권을 포함한 지적재산권은 himedia.co.kr에 있으며,
 * himedia.co.kr이 명시적으로 허용하지 않는 사용, 복사, 변경 및 제 3자에 의한 공개, 배포는 엄격히 금지되며
 * himedia.co.kr의 지적재산권 침해에 해당된다.
 * Copyright (C) 2024 himedia.co.kr All Rights Reserved.
 *
 *
 * Program		: kr.co.challengefarm
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			: PagingDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240807120736][pluto@himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.main.dto;

/**
 * @version 1.0.0
 * @author hyebongssss#gmail.co.kr
 * 
 * @since 2024-10-06
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class PagingDto {
	
	private int totalLine		= 0;	// 전체 라인(행) 수
	private int totalPage		= 0;	// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
	private int linePerPage	= 9;	// 페이징할 라인수
	private int currentPage	= 1;	// 현재 페이지
	
	private String searchKey	= "";	// 검색키
	private String searchWord	= "";	// 검색어
	
	private String cd_ctg		= "";	// [상품리스트] 상품 카테고리
	private String brd_ctg		= "";	// [상품리스트] 브랜드 분류
	private String prc_ctg		= "";	// [상품리스트] 가격 분류
	private String size_nm		= "";	// [상품리스트] 사이즈 분류
	private String sale_sort	= ""; 	// [상품리스트] 상품 정렬
	private int register		= 0;	// [등록자]
	
	
	public String getSize_nm() {
		return size_nm;
	}
	public void setSize_nm(String size_nm) {
		this.size_nm = size_nm;
	}
	public String getPrc_ctg() {
		return prc_ctg;
	}
	public void setPrc_ctg(String prc_ctg) {
		this.prc_ctg = prc_ctg;
	}
	public String getBrd_ctg() {
		return brd_ctg;
	}
	public void setBrd_ctg(String brd_ctg) {
		this.brd_ctg = brd_ctg;
	}
	public String getSale_sort() {
		return sale_sort;
	}
	public void setSale_sort(String sale_sort) {
		this.sale_sort = sale_sort;
	}
	public String getCd_ctg() {
		return cd_ctg;
	}
	public void setCd_ctg(String cd_ctg) {
		this.cd_ctg = cd_ctg;
	}
	public int getRegister() {
		return register;
	}
	public void setRegister(int register) {
		this.register = register;
	}
	public int getTotalLine() {
		return totalLine;
	}
	public void setTotalLine(int totalLine) {
		this.totalLine = totalLine;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getLinePerPage() {
		return linePerPage;
	}
	public void setLinePerPage(int linePerPage) {
		this.linePerPage = linePerPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
}