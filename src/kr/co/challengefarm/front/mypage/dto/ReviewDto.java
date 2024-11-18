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
 * File			: ReviewDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241022165211][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.dto;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-10-22
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class ReviewDto {

	private int rnum				= 0;
	private int seq_rev			= 0;
	private int seq_buy_dtl		= 0;
	private int seq_sle			= 0;
	private int seq_mbr			= 0;
	private int seq_sll			= 0;
	private String content			= "";
	private int rating				= 0;
	private String img				= "";
	private String sll_nm			= "";
	private String flg_delete		= "";
	private String flg_sle_delete	= "";
	private String dt_reg			= "";
	private int register			= 0;
	private String dt_upt			= "";
	private int updater			= 0;
	
	private String sle_img			= "";
	private String sle_nm			= "";
	private String color			= "";
	private String size_nm			= "";
	private String size_name		= "";
	private int count				= 0;
	private String email			= "";
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public int getSeq_rev() {
		return seq_rev;
	}
	public void setSeq_rev(int seq_rev) {
		this.seq_rev = seq_rev;
	}
	public int getSeq_buy_dtl() {
		return seq_buy_dtl;
	}
	public void setSeq_buy_dtl(int seq_buy_dtl) {
		this.seq_buy_dtl = seq_buy_dtl;
	}
	public int getSeq_sle() {
		return seq_sle;
	}
	public void setSeq_sle(int seq_sle) {
		this.seq_sle = seq_sle;
	}
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
	}
	public int getSeq_sll() {
		return seq_sll;
	}
	public void setSeq_sll(int seq_sll) {
		this.seq_sll = seq_sll;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getSll_nm() {
		return sll_nm;
	}
	public void setSll_nm(String sll_nm) {
		this.sll_nm = sll_nm;
	}
	public String getFlg_delete() {
		return flg_delete;
	}
	public void setFlg_delete(String flg_delete) {
		this.flg_delete = flg_delete;
	}
	public String getFlg_sle_delete() {
		return flg_sle_delete;
	}
	public void setFlg_sle_delete(String flg_sle_delete) {
		this.flg_sle_delete = flg_sle_delete;
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
	public String getSle_img() {
		return sle_img;
	}
	public void setSle_img(String sle_img) {
		this.sle_img = sle_img;
	}
	public String getSle_nm() {
		return sle_nm;
	}
	public void setSle_nm(String sle_nm) {
		this.sle_nm = sle_nm;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSize_nm() {
		return size_nm;
	}
	public void setSize_nm(String size_nm) {
		this.size_nm = size_nm;
	}
	public String getSize_name() {
		return size_name;
	}
	public void setSize_name(String size_name) {
		this.size_name = size_name;
	}
}
