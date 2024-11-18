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
 * File			: QuestionListDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241106182451][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.dto;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-11-06
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class QuestionListDto {
	
	private int rnum				= 0;
	private int seq_bbs				= 0;
	private int seq_bbs_parent		= 0;
	private String depth			= "";
	private int cd_bbs_type			= 0;
	private String title			= "";
	private int cd_ctg				= 0;
	private String content			= "";
	private String flg_top			= "";
	private String flg_reply		= "";
	private String flg_delete		= "";
	private int readed				= 0;
	private String file_save		= "";
	private String file_orig		= "";
	private String dt_reg			= "";
	private int register			= 0;
	private String dt_upt			= "";
	private int updater				= 0;
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getSeq_bbs() {
		return seq_bbs;
	}
	public void setSeq_bbs(int seq_bbs) {
		this.seq_bbs = seq_bbs;
	}
	public int getSeq_bbs_parent() {
		return seq_bbs_parent;
	}
	public void setSeq_bbs_parent(int seq_bbs_parent) {
		this.seq_bbs_parent = seq_bbs_parent;
	}
	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public int getCd_bbs_type() {
		return cd_bbs_type;
	}
	public void setCd_bbs_type(int cd_bbs_type) {
		this.cd_bbs_type = cd_bbs_type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCd_ctg() {
		return cd_ctg;
	}
	public void setCd_ctg(int cd_ctg) {
		this.cd_ctg = cd_ctg;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFlg_top() {
		return flg_top;
	}
	public void setFlg_top(String flg_top) {
		this.flg_top = flg_top;
	}
	public String getFlg_reply() {
		return flg_reply;
	}
	public void setFlg_reply(String flg_reply) {
		this.flg_reply = flg_reply;
	}
	public String getFlg_delete() {
		return flg_delete;
	}
	public void setFlg_delete(String flg_delete) {
		this.flg_delete = flg_delete;
	}
	public int getReaded() {
		return readed;
	}
	public void setReaded(int readed) {
		this.readed = readed;
	}
	public String getFile_save() {
		return file_save;
	}
	public void setFile_save(String file_save) {
		this.file_save = file_save;
	}
	public String getFile_orig() {
		return file_orig;
	}
	public void setFile_orig(String file_orig) {
		this.file_orig = file_orig;
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
