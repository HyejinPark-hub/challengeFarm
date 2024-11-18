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
 * Program		: kr.co.himedia.ecommerce
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			: BuyDetailDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240808101231][rkdcodbs77@naver.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.buy.dto;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.com
 * 
 * @since 2024-11-01
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class BuyDetailDto {

	private int seq_buy_dtl	= 0;
	private int seq_buy_mst	= 0;
	private int seq_sle		= 0;
	private String size_nm		= "";
	private int count			= 0;
	private int price			= 0;
	private String dt_reg		= "";
	private int register		= 0;
	
	private String sle_nm		= "";
	private int totalPrice		= 0;
	private int totalCount		= 0;
	private int discount		= 0;
	
	private String sll_nm		= "";	// 관리자 메인페이지 판매자별 월매출 판매자명
	private String period		= "";	// 관리자 메인페이지 판매자별 월매출 년월
	private String priceTotal	= "";	// 관리자 메인페이지 판매자별 월매출 총매출
	
	
	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public String getSll_nm() {
		return sll_nm;
	}

	public void setSll_nm(String sll_nm) {
		this.sll_nm = sll_nm;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getPriceTotal() {
		return priceTotal;
	}

	public void setPriceTotal(String priceTotal) {
		this.priceTotal = priceTotal;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getSeq_buy_dtl() {
		return seq_buy_dtl;
	}

	public void setSeq_buy_dtl(int seq_buy_dtl) {
		this.seq_buy_dtl = seq_buy_dtl;
	}

	public int getSeq_buy_mst() {
		return seq_buy_mst;
	}

	public void setSeq_buy_mst(int seq_buy_mst) {
		this.seq_buy_mst = seq_buy_mst;
	}

	public int getSeq_sle() {
		return seq_sle;
	}

	public void setSeq_sle(int seq_sle) {
		this.seq_sle = seq_sle;
	}

	public String getSize_nm() {
		return size_nm;
	}

	public void setSize_nm(String size_nm) {
		this.size_nm = size_nm;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getDt_reg() {
		return dt_reg;
	}

	public void setDt_reg(String dt_reg) {
		this.dt_reg = dt_reg;
	}

	public int getRegister() {
		return register;
	}

	public void setRegister(int register) {
		this.register = register;
	}

	public String getSle_nm() {
		return sle_nm;
	}

	public void setSle_nm(String sle_nm) {
		this.sle_nm = sle_nm;
	}
}