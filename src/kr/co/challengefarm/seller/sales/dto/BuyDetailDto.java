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
 *				: [20241112153601][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sales.dto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-11-12
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class BuyDetailDto {
	
	private int rnum			= 0;
	private int seq_buy_dtl		= 0;
	private int seq_buy_mst		= 0;
	private int seq_sle			= 0;
	private int count			= 0;
	private int price			= 0;
	private String dt_reg		= "";
	private int register		= 0;
	private String size_nm		= "";
	
	private String sle_nm		= "";
	private String mbr_nm		= "";
	private String size_num		= "";	// 상품 사이즈 index
	
	
	public String getSize_num() {
		return size_num;
	}
	public void setSize_num(String size_num) {
		this.size_num = size_num;
	}
	public String getSle_nm() {
		return sle_nm;
	}
	public void setSle_nm(String sle_nm) {
		this.sle_nm = sle_nm;
	}
	public String getMbr_nm() {
		return mbr_nm;
	}
	public void setMbr_nm(String mbr_nm) {
		this.mbr_nm = mbr_nm;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
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
	public String getSize_nm() {
		return size_nm;
	}
	public void setSize_nm(String size_nm) {
		this.size_nm = size_nm;
	}
}
