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
 * Program		: kr.co.challengefarm
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			: FileDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240808155254][pluto@himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.common.dto;

/**
 * @version 1.0.0
 * @author pluto@himedia.co.kr
 * 
 * @since 2024-08-08
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class FileDto {
	
	private String fileNameOriginal		= "";
	private String fileNameSave			= "";
	private Long fileSize				= 0L;
	
	
	public String getFileNameOriginal() {
		return fileNameOriginal;
	}
	public void setFileNameOriginal(String fileNameOriginal) {
		this.fileNameOriginal = fileNameOriginal;
	}
	public String getFileNameSave() {
		return fileNameSave;
	}
	public void setFileNameSave(String fileNameSave) {
		this.fileNameSave = fileNameSave;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
}