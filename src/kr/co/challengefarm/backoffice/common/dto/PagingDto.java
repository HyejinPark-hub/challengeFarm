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
 *				: [20240806172702][pluto@himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.common.dto;

/**
 * @version 1.0.0
 * @author pluto@himedia.co.kr
 * 
 * @since 2024-08-06
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class PagingDto {
	
	private int totalLine			= 0;	// 전체 라인(행) 수
	private int totalPage			= 0;	// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
	private int linePerPage			= 10;	// 페이징할 라인수
	private int currentPage			= 1;	// 현재 페이지
	
	private String searchKey		= "";	// 검색키(예: 타이틀, 내용, 타이틀+내용)
	private String searchWord		= "";	// 검색어
	
	private Integer cd_state		= null;	// [공통]
	private int cd_bbs_type			= 0;	// [게시판] 공지사항(1), 자주 찾는 질문(2), 질의 응답(3)
	private String cd_ctg			= "";
	private int register			= 0;
	private int seq_bbs				= 0;
	private int cd_state_act	= 0;	// [경매] 대기(0), 승인(1)
	private String success		= "";	// [경매] 낙찰전(NULL), 낙찰(Y), 유찰(N)
	private int cd_state_sale	= 1;	// [상품] 판매(1), 품절(2), 중지(3), 반려(9)
	
	
	public int getCd_state_sale() {
		return cd_state_sale;
	}
	public void setCd_state_sale(int cd_state_sale) {
		this.cd_state_sale = cd_state_sale;
	}
	public int getCd_state_act() {
		return cd_state_act;
	}
	public void setCd_state_act(int cd_state_act) {
		this.cd_state_act = cd_state_act;
	}
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}
	public String getCd_ctg() {
		return cd_ctg;
	}
	public void setCd_ctg(String cd_ctg) {
		this.cd_ctg = cd_ctg;
	}
	public int getSeq_bbs() {
		return seq_bbs;
	}
	public void setSeq_bbs(int seq_bbs) {
		this.seq_bbs = seq_bbs;
	}
	public int getRegister() {
		return register;
	}
	public void setRegister(int register) {
		this.register = register;
	}
	public Integer getCd_state() {
		return cd_state;
	}
	public void setCd_state(Integer cd_state) {
		this.cd_state = cd_state;
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
	public int getCd_bbs_type() {
		return cd_bbs_type;
	}
	public void setCd_bbs_type(int cd_bbs_type) {
		this.cd_bbs_type = cd_bbs_type;
	}
}