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
 * File			: PayDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241016164442][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.pay.dto;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-10-16
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class PayDto {
	
	private int seq_pay			= 0;
	private int seq_mbr			= 0;
	private int seq_buy_mst		= 0;
	private int cd_pg				= 0;
	private String num_order		= "";
	private String num_deal			= "";
	private String cd_response		= "";
	private int cd_pay_method		= 0;
	private String flg_act			= "";
	private String flg_success		= "";
	private String dt_reg			= "";
	private int register			= 0;
	
	
	public int getSeq_pay() {
		return seq_pay;
	}
	public void setSeq_pay(int seq_pay) {
		this.seq_pay = seq_pay;
	}
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
	}
	public int getSeq_buy_mst() {
		return seq_buy_mst;
	}
	public void setSeq_buy_mst(int seq_buy_mst) {
		this.seq_buy_mst = seq_buy_mst;
	}
	public int getCd_pg() {
		return cd_pg;
	}
	public void setCd_pg(int cd_pg) {
		this.cd_pg = cd_pg;
	}
	public String getNum_order() {
		return num_order;
	}
	public void setNum_order(String num_order) {
		this.num_order = num_order;
	}
	public String getNum_deal() {
		return num_deal;
	}
	public void setNum_deal(String num_deal) {
		this.num_deal = num_deal;
	}
	public String getCd_response() {
		return cd_response;
	}
	public void setCd_response(String cd_response) {
		this.cd_response = cd_response;
	}
	public int getCd_pay_method() {
		return cd_pay_method;
	}
	public void setCd_pay_method(int cd_pay_method) {
		this.cd_pay_method = cd_pay_method;
	}
	public String getFlg_act() {
		return flg_act;
	}
	public void setFlg_act(String flg_act) {
		this.flg_act = flg_act;
	}
	public String getFlg_success() {
		return flg_success;
	}
	public void setFlg_success(String flg_success) {
		this.flg_success = flg_success;
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
