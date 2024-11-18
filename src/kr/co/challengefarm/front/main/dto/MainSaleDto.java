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
 * File			: SaleDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241002145713][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.main.dto;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-10-02
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class MainSaleDto {
	
	private int seq_mbr				= 0;
	private String type					= "";
	private int seq_sle				= 0;
	private String sle_nm				= "";
	private String cd_ctg				= "";
	private String cd_state_sale		= ""; 
	private int price_cost				= 0;
	private int discount				= 0;
	private String desces				= "";
	private String color				= "";
	private String merterial			= "";
	private String img					= "";
	private String size					= "";
	private String size_detail			= "";
	private int heart					= 0;
	private int review					= 0;
	private String dt_sale_start		= "";
	private String dt_reg				= "";
	private int register				= 0;
	private String dt_upt				= "";
	private int updater				= 0;
	private int rating					= 0;
	
	private String flg_cancel			= "";
	
	private int seq_act				= 0;
	private String act_nm				= "";
	private int day_remain				= 0;
	private String	dt_act_end			= "";
	private int bid_cnt				= 0;
	
	
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
	}
	public String getDt_act_end() {
		return dt_act_end;
	}
	public void setDt_act_end(String dt_act_end) {
		this.dt_act_end = dt_act_end;
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
	public int getDay_remain() {
		return day_remain;
	}
	public void setDay_remain(int day_remain) {
		this.day_remain = day_remain;
	}
	public int getBid_cnt() {
		return bid_cnt;
	}
	public void setBid_cnt(int bid_cnt) {
		this.bid_cnt = bid_cnt;
	}
	public String getFlg_cancel() {
		return flg_cancel;
	}
	public void setFlg_cancel(String flg_cancel) {
		this.flg_cancel = flg_cancel;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getSeq_sle() {
		return seq_sle;
	}
	public void setSeq_sle(int seq_sle) {
		this.seq_sle = seq_sle;
	}
	public String getSle_nm() {
		return sle_nm;
	}
	public void setSle_nm(String sle_nm) {
		this.sle_nm = sle_nm;
	}
	public String getCd_ctg() {
		return cd_ctg;
	}
	public void setCd_ctg(String cd_ctg) {
		this.cd_ctg = cd_ctg;
	}
	public String getCd_state_sale() {
		return cd_state_sale;
	}
	public void setCd_state_sale(String cd_state_sale) {
		this.cd_state_sale = cd_state_sale;
	}
	public int getPrice_cost() {
		return price_cost;
	}
	public void setPrice_cost(int price_cost) {
		this.price_cost = price_cost;
	}
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getDesces() {
		return desces;
	}
	public void setDesces(String desces) {
		this.desces = desces;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getMerterial() {
		return merterial;
	}
	public void setMerterial(String merterial) {
		this.merterial = merterial;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getSize_detail() {
		return size_detail;
	}
	public void setSize_detail(String size_detail) {
		this.size_detail = size_detail;
	}
	public int getHeart() {
		return heart;
	}
	public void setHeart(int heart) {
		this.heart = heart;
	}
	public int getReview() {
		return review;
	}
	public void setReview(int review) {
		this.review = review;
	}
	public String getDt_sale_start() {
		return dt_sale_start;
	}
	public void setDt_sale_start(String dt_sale_start) {
		this.dt_sale_start = dt_sale_start;
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

}
