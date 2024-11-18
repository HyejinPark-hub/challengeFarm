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
 * File			: BidDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241030150843][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.auction.dto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-30
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class BidDto {

	private int seq_bid			= 0;
	private int seq_act			= 0;
	private int seq_mbr			= 0;
	private int bid_price		= 0;
	private String flg_success	= "";
	private String flg_giveup	= "";
	private String dt_reg		= "";
	private int register		= 0;
	private String dt_upt		= "";
	private int updater			= 0;
	
	private String process		= "";	// 입찰(insert), 수정(update), 포기(delete)
	private String mbr_nm		= "";	// 입찰자 명
	private String act_price	= "";	// 기본 입찰가
	
	
	public int getSeq_bid() {
		return seq_bid;
	}
	public void setSeq_bid(int seq_bid) {
		this.seq_bid = seq_bid;
	}
	public int getSeq_act() {
		return seq_act;
	}
	public void setSeq_act(int seq_act) {
		this.seq_act = seq_act;
	}
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
	}
	public int getBid_price() {
		return bid_price;
	}
	public void setBid_price(int bid_price) {
		this.bid_price = bid_price;
	}
	public String getFlg_success() {
		return flg_success;
	}
	public void setFlg_success(String flg_success) {
		this.flg_success = flg_success;
	}
	public String getFlg_giveup() {
		return flg_giveup;
	}
	public void setFlg_giveup(String flg_giveup) {
		this.flg_giveup = flg_giveup;
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
	public String getDt_upt() {
		return dt_upt;
	}
	public void setDt_upt(String dt_upt) {
		this.dt_upt = dt_upt;
	}
	public int getUpdater() {
		return updater;
	}
	public void setUpdater(int updater) {
		this.updater = updater;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getMbr_nm() {
		return mbr_nm;
	}
	public void setMbr_nm(String mbr_nm) {
		this.mbr_nm = mbr_nm;
	}
	public String getAct_price() {
		return act_price;
	}
	public void setAct_price(String act_price) {
		this.act_price = act_price;
	}
}
