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
 * File			: MemberDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241001144255][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.member.dto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-01
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class MemberDto {
	private int seq_mbr			= 0;
	private String email		= "";
	private String passwd		= "";
	private int cd_state		= 0;
	private String mbr_nm		= "";
	private String gender		= "";
	private String phone		= "";
	private String post			= "";
	private String addr1		= "";
	private String addr2		= "";
	private String flg_sms		= "";
	private String dt_sms		= "";
	private String flg_email	= "";
	private String dt_email		= "";
	private String last_ip		= "";
	private String last_dt		= "";
	private String dt_reg		= "";
	private int register		= 0;
	private String dt_upt		= "";
	private int updater			= 0;
	
	
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}	
	public int getCd_state() {
		return cd_state;
	}
	public void setCd_state(int cd_state) {
		this.cd_state = cd_state;
	}
	public String getMbr_nm() {
		return mbr_nm;
	}
	public void setMbr_nm(String mbr_nm) {
		this.mbr_nm = mbr_nm;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
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
	public String getFlg_sms() {
		return flg_sms;
	}
	public void setFlg_sms(String flg_sms) {
		this.flg_sms = flg_sms;
	}
	public String getDt_sms() {
		return dt_sms;
	}
	public void setDt_sms(String dt_sms) {
		this.dt_sms = dt_sms;
	}
	public String getFlg_email() {
		return flg_email;
	}
	public void setFlg_email(String flg_email) {
		this.flg_email = flg_email;
	}
	public String getDt_email() {
		return dt_email;
	}
	public void setDt_email(String dt_email) {
		this.dt_email = dt_email;
	}
	public String getLast_ip() {
		return last_ip;
	}
	public void setLast_ip(String last_ip) {
		this.last_ip = last_ip;
	}
	public String getLast_dt() {
		return last_dt;
	}
	public void setLast_dt(String last_dt) {
		this.last_dt = last_dt;
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
