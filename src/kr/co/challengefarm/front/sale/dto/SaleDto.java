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
 *				: [20241004155243][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.sale.dto;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-10-04
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class SaleDto {
	
	private int rnum					= 0;
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
	
	private String size_nm				= "";
	private int count					= 0;
	private int seq_sll				= 0;
	private String sll_nm				= "";
	private String size_name			= "";
	private int seq_buy_dtl			= 0;
	private int rating					= 0;

	private String flg_cancel			= "";	// 찜여부 N: 찜, Y: 찜 해제
	
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getFlg_cancel() {
		return flg_cancel;
	}
	public void setFlg_cancel(String flg_cancel) {
		this.flg_cancel = flg_cancel;
	}
	public int getSeq_buy_dtl() {
		return seq_buy_dtl;
	}
	public void setSeq_buy_dtl(int seq_buy_dtl) {
		this.seq_buy_dtl = seq_buy_dtl;
	}
	public String getSize_name() {
		return size_name;
	}
	public void setSize_name(String size_name) {
		this.size_name = size_name;
	}
	public int getSeq_sll() {
		return seq_sll;
	}
	public void setSeq_sll(int seq_sll) {
		this.seq_sll = seq_sll;
	}
	public String getSll_nm() {
		return sll_nm;
	}
	public void setSll_nm(String sll_nm) {
		this.sll_nm = sll_nm;
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
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
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
