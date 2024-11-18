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
 * File			: AuctionDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241029131325][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.auction.dto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-29
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class AuctionDto {
	
	private int rnum				= 0;
	private int seq_act			= 0; 
	private String act_nm			= "";
	private int price				= 0;
	private String desces			= "";
	private String img				= "";
	private String 	buy_year		= "";
	private String act_state		= "";
	private String dt_act_start		= "";
	private String 	dt_act_end		= "";
	private int heart				= 0;
	private String success			= "";
	private int seq_mbr				= 0;
	private String cd_state_act		= "";
	private String reject			= "";
	private String dt_reg			= "";
	private int register			= 0;
	private String dt_up 			= "";
	private int updater				= 0;

	private String bid_price		= "";	// 내 입찰가
	private String flg_giveup		= "";	// 내 입찰 취소여부
	private String flg_cancel		= "";	// 찜:N, 찜 해제:Y
	
	private String seller			= ""; 	// [경매리스트] 판매자
	private int bid_cnt			= 0;	// [경매리스트] 카운트
	private String day_remain		= "";	// [경매리스트] 남은 날짜
	
	private String flg_success		= "";	// [경매] 낙찰 여부
	
	
	public String getFlg_success() {
		return flg_success;
	}
	public void setFlg_success(String flg_success) {
		this.flg_success = flg_success;
	}
	public String getDay_remain() {
		return day_remain;
	}
	public void setDay_remain(String day_remain) {
		this.day_remain = day_remain;
	}
	public int getBid_cnt() {
		return bid_cnt;
	}
	public void setBid_cnt(int bid_cnt) {
		this.bid_cnt = bid_cnt;
	}
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getFlg_cancel() {
		return flg_cancel;
	}
	public void setFlg_cancel(String flg_cancel) {
		this.flg_cancel = flg_cancel;
	}
	public int getSeq_act() {
		return seq_act;
	}
	public void setSeq_act(int seq_act) {
		this.seq_act = seq_act;
	}
	public String getAct_nm() {
		return act_nm;
	}
	public void setAct_nm(String act_nm) {
		this.act_nm = act_nm;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDesces() {
		return desces;
	}
	public void setDesces(String desces) {
		this.desces = desces;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getBuy_year() {
		return buy_year;
	}
	public void setBuy_year(String buy_year) {
		this.buy_year = buy_year;
	}
	public String getAct_state() {
		return act_state;
	}
	public void setAct_state(String act_state) {
		this.act_state = act_state;
	}
	public String getDt_act_start() {
		return dt_act_start;
	}
	public void setDt_act_start(String dt_act_start) {
		this.dt_act_start = dt_act_start;
	}
	public String getDt_act_end() {
		return dt_act_end;
	}
	public void setDt_act_end(String dt_act_end) {
		this.dt_act_end = dt_act_end;
	}
	public int getHeart() {
		return heart;
	}
	public void setHeart(int heart) {
		this.heart = heart;
	}
	public String getSuccess() {
		return success;
	}
	public void setSuccess(String success) {
		this.success = success;
	}
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
	}
	public String getCd_state_act() {
		return cd_state_act;
	}
	public void setCd_state_act(String cd_state_act) {
		this.cd_state_act = cd_state_act;
	}
	public String getReject() {
		return reject;
	}
	public void setReject(String reject) {
		this.reject = reject;
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
	public String getDt_up() {
		return dt_up;
	}
	public void setDt_up(String dt_up) {
		this.dt_up = dt_up;
	}
	public int getUpdater() {
		return updater;
	}
	public void setUpdater(int updater) {
		this.updater = updater;
	}
	public String getBid_price() {
		return bid_price;
	}
	public void setBid_price(String bid_price) {
		this.bid_price = bid_price;
	}
	public String getFlg_giveup() {
		return flg_giveup;
	}
	public void setFlg_giveup(String flg_giveup) {
		this.flg_giveup = flg_giveup;
	}
}
