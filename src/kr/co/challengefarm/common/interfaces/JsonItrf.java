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
 * File			: JsonItrf.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240829123655][pluto@himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.common.interfaces;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.co.challengefarm.util.net.HttpJson;

/**
 * @version 1.0.0
 * @author pluto@himedia.co.kr
 * 
 * @since 2024-08-29
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
public class JsonItrf {
	
	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(JsonItrf.class);
	
	/**
	 * @param Object(requestSellerInfosDto 등) [요청 빈(Bean)]
	 * @param typeReference [응답 클래스]
	 * @param url [URL]
	 * @return Object(ResponseSellerInfosDto 등)
	 * 
	 * @since 2017-07-28
	 * <p>DESCRIPTION: JSON HTTP/S Client(POST) for ResponseDto Bean</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@SuppressWarnings({"rawtypes"})
	public static Object connectPost(Object requestDto, TypeReference typeReference, String url) {
		
		ObjectMapper objectMapper	= new ObjectMapper();
		String requestJSON			= "";
		String responseJSON			= "";
		Object responseDto			= new Object();
		
		try {
			requestJSON		= objectMapper.writeValueAsString(requestDto);
			
			// System.out.println("\n" + "requestJSON: " + requestJSON);
			if (url.startsWith("https")) {
				// HttpsJson httpsJson = new HttpsJson(url);
				// responseJSON		= httpsJson.connectPost(requestJSON, 3000);
			}
			else {
				HttpJson httpJson	= new HttpJson(url);
				responseJSON		= httpJson.connectPost(requestJSON, 3000);
			}
			// System.out.println("\n" + "responseJSON: " + responseJSON + "\n");
			
			responseDto = objectMapper.readValue(responseJSON, typeReference);
		}
		catch (JsonProcessingException e) {
			logger.error("[kr.co.challengefarm.common.interfaces.JsonItrf.connectPost(requestDto, TypeReference, String)] " + e.getMessage(), e);
		}
		catch (IOException e) {
			logger.error("[kr.co.challengefarm.common.interfaces.JsonItrf.connectPost(requestDto, TypeReference, String)] " + e.getMessage(), e);
		}
		catch (Exception e) {
			logger.error("[kr.co.challengefarm.common.interfaces.JsonItrf.connectPost(requestDto, TypeReference, String)] " + e.getMessage(), e);
		}
		finally {}
		
		return responseDto;
	}
}