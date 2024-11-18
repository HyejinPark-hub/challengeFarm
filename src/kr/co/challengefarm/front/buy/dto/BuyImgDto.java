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
 * File			: DetailImgDtd.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241007150023][kogr0131#gmail.com][CREATE: Initial Release]
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
public class BuyImgDto {
	
	public int seq_sle_img		=0;
	public int seq_sle			=0;
	public String img			="";
	
	
	public int getSeq_sle_img() {
		return seq_sle_img;
	}
	public void setSeq_sle_img(int seq_sle_img) {
		this.seq_sle_img = seq_sle_img;
	}
	public int getSeq_sle() {
		return seq_sle;
	}
	public void setSeq_sle(int seq_sle) {
		this.seq_sle = seq_sle;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
		
}
