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
 * File			: DeliveryDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241022101552][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.buy.dto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-22
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class DeliveryDto {
	
	private int seq_dlv			= 0;
	private int seq_buy_mst		= 0;
	private String dlv_nm		= "";
	private String phone		= "";
	private String post			= "";
	private String addr1		= "";
	private String addr2		= "";
	private String message		= "";
	private String dt_reg		= "";
	private int register		= 0;
	
	
	public int getSeq_dlv() {
		return seq_dlv;
	}
	public void setSeq_dlv(int seq_dlv) {
		this.seq_dlv = seq_dlv;
	}
	public int getSeq_buy_mst() {
		return seq_buy_mst;
	}
	public void setSeq_buy_mst(int seq_buy_mst) {
		this.seq_buy_mst = seq_buy_mst;
	}
	public String getDlv_nm() {
		return dlv_nm;
	}
	public void setDlv_nm(String dlv_nm) {
		this.dlv_nm = dlv_nm;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
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
}
