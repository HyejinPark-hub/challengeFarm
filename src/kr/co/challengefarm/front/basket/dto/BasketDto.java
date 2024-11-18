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
 * File			: BasketDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241011162844][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.basket.dto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-11
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class BasketDto {
	
	private int seq_bsk				= 0;
	private int seq_mbr				= 0;
	private int seq_sle				= 0;
	private String sle_nm			= "";
	private String size_nm			= "";
	private int price				= 0;
	private int count				= 0;
	private String img				= "";
	private String cd_state_pay		= "";
	private String dt_reg			= "";
	private int register			= 0;
	private String dt_upt			= "";
	private int updater				= 0;
	
	private int discount			= 0;
	private String size_name		= "";
	private Integer[] products		= null;	// 장바구니 중 구매할 상품들의 일련번호
	
	
	public int getSeq_bsk() {
		return seq_bsk;
	}
	public void setSeq_bsk(int seq_bsk) {
		this.seq_bsk = seq_bsk;
	}
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
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
	public String getSize_nm() {
		return size_nm;
	}
	public void setSize_nm(String size_nm) {
		this.size_nm = size_nm;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getCd_state_pay() {
		return cd_state_pay;
	}
	public void setCd_state_pay(String cd_state_pay) {
		this.cd_state_pay = cd_state_pay;
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
	public int getDiscount() {
		return discount;
	}
	public void setDiscount(int discount) {
		this.discount = discount;
	}
	public String getSize_name() {
		return size_name;
	}
	public void setSize_name(String size_name) {
		this.size_name = size_name;
	}
	public Integer[] getProducts() {
		return products;
	}
	public void setProducts(Integer[] products) {
		this.products = products;
	}
}
