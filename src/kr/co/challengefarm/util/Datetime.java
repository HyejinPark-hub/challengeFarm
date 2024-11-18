/**
 * YOU ARE STRICTLY PROHIBITED TO COPY, DISCLOSE, DISTRIBUTE, MODIFY OR USE THIS PROGRAM
 * IN PART OR AS A WHOLE WITHOUT THE PRIOR WRITTEN CONSENT OF HIMEDIA.CO.KR.
 * HIMEDIA.CO.KR OWNS THE INTELLECTUAL PROPERTY RIGHTS IN AND TO THIS PROGRAM.
 * COPYRIGHT (C) 2023 HIMEDIA.CO.KR ALL RIGHTS RESERVED.
 *
 * 하기 프로그램에 대한 저작권을 포함한 지적재산권은 himedia.co.kr에 있으며,
 * himedia.co.kr이 명시적으로 허용하지 않는 사용, 복사, 변경 및 제 3자에 의한 공개, 배포는 엄격히 금지되며
 * himedia.co.kr의 지적재산권 침해에 해당된다.
 * Copyright (C) 2023 himedia.co.kr All Rights Reserved.
 *
 *
 * Program		: kr.co.challengefarm
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			: Datetime.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20231128164856][pluto@himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * @version 1.0.0
 * @author pluto@himedia.co.kr
 * 
 * @since 2023-11-28
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class Datetime {
	
	/*
	public static void main(String[] args) {
		System.out.println("현재 시각은 " + Datetime.getNow("yyyy-MM-dd HH:mm:ss"));
	}
	*/
	
	/**
	 * @param datetimeFormat [날짜/시간 형식]
	 * @return String
	 * 
	 * @since 2015-04-12
	 * <p>DESCRIPTION: 현재 날짜/시각을 지정한 형식(datetimeFormat)의 문자열로 얻기</p>
	 * <p>IMPORTANT: 파라미터는 데이터 타입 및 형식을 만족하여야 한다.</p>
	 * <p>EXAMPLE: <code>datetimeFormat = "yyyy-MM-dd" or "yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd HH:mm:ss SSS"</code></p>
	 */
	public static String getNow(String datetimeFormat) {
		
		Calendar currentDate		= Calendar.getInstance();
		SimpleDateFormat formatter	= new SimpleDateFormat(datetimeFormat);
		
		return formatter.format(currentDate.getTime());
	}

}