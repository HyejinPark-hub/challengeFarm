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
 * File			: DetailsDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004130912][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.buy.dto;

/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-10-11
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class BuyDto {
	
	public int		seq_sle			= 0;
	public String	sle_nm 			= "";
	public String	cd_ctg 			= "";
	public String	cd_state_sale 	= "";
	public int		price_cost 		= 0;
	public int		discount 		= 0;
	public String	color 			= "";
	public String	merterlal 		= "";
	public String	img 			= "";
	public String	size_nm 		= "";
	public String	size_detail 	= "";
	public String	desces 			= "";
	public int		heart 			= 0;
	public int		review 			= 0;
	
	public int 	count			= 0;
	private int	seq_mbr			= 0;
	private int	price			= 0;
	private String size_name		= "";
	
	private String flg_cancel		= "";	// 찜: N, 찜 해제: Y
	

	public String getFlg_cancel() {
		return flg_cancel;
	}
	public void setFlg_cancel(String flg_cancel) {
		this.flg_cancel = flg_cancel;
	}
	public String getSize_name() {
		return size_name;
	}
	public void setSize_name(String size_name) {
		this.size_name = size_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getSle_nm() {
		return sle_nm;
	}
	public void setSle_nm(String sle_nm) {
		this.sle_nm = sle_nm;
	}
	
	public int getSeq_sle() {
		return seq_sle;
	}
	public void setSeq_sle(int seq_sle) {
		this.seq_sle = seq_sle;
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
	
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
	public String getMerterlal() {
		return merterlal;
	}
	public void setMerterlal(String merterlal) {
		this.merterlal = merterlal;
	}
	
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getSize_nm() {
		return size_nm;
	}
	public void setSize_nm(String size_nm) {
		this.size_nm = size_nm;
	}	
	public String getSize_detail() {
		return size_detail;
	}
	public void setSize_detail(String size_detail) {
		this.size_detail = size_detail;
	}
	
	public String getDesces() {
		return desces;
	}
	public void setDesces(String desces) {
		this.desces = desces;
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
	
}
