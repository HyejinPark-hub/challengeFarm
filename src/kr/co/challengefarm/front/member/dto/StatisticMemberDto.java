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
 * File			: StatisticMemberDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240813155732][pluto@himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.member.dto;

/**
 * @version 1.0.0
 * @author pluto@himedia.co.kr
 * 
 * @since 2024-08-13
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class StatisticMemberDto {
	
	private int seq_mbr		= 0;
	private String post		= "";
	
	
	public int getSeq_mbr() {
		return seq_mbr;
	}
	public void setSeq_mbr(int seq_mbr) {
		this.seq_mbr = seq_mbr;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
}
