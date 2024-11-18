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
 * File			: HeartDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241031104147][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.sale.dto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-31
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class HeartDto {

	private int seq_hrt				= 0;
	private int seq_mbr				= 0;
	private int seq_sle				= 0;
	private int seq_act				= 0;
	private String dt_reg			= "";
	private String flg_cancel		= "";
	private String flg_sle_delete	= "";
	private int register			= 0;
	private String dt_upt			= "";
	private int updater				= 0;
	
	private String process			= "";	// 찜(insert), 해제(delete)
	
	
	public int getSeq_hrt() {
		return seq_hrt;
	}
	public void setSeq_hrt(int seq_hrt) {
		this.seq_hrt = seq_hrt;
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
	public int getSeq_act() {
		return seq_act;
	}
	public void setSeq_act(int seq_act) {
		this.seq_act = seq_act;
	}
	public String getDt_reg() {
		return dt_reg;
	}
	public void setDt_reg(String dt_reg) {
		this.dt_reg = dt_reg;
	}
	public String getFlg_cancel() {
		return flg_cancel;
	}
	public void setFlg_cancel(String flg_cancel) {
		this.flg_cancel = flg_cancel;
	}
	public String getFlg_sle_delete() {
		return flg_sle_delete;
	}
	public void setFlg_sle_delete(String flg_sle_delete) {
		this.flg_sle_delete = flg_sle_delete;
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
}
