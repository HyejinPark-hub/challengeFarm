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
 * File			: ReviewWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004113850][kalguksu7022@gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.mypage.service.HeartListSrvc;

/**
 * @version 1.0.0
 * @author kalguksu7022@gmail.com
 * 
 * @since 2024-10-04
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.mypage.controller.HeartListWeb")
public class HeartListWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(HeartListWeb.class);
	
	@Inject
	HeartListSrvc heartListSrvc;
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-04
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/mypage/heartList.web")
	public ModelAndView heartList(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
	
		ModelAndView mav = new ModelAndView("front/mypage/heartList");
	
		try {
			int seqMbr = Integer.parseInt(getSession(request, "SEQ_MBR"));
			
			pagingDto.setRegister(seqMbr);
			
			PagingListDto pagingListDto = heartListSrvc.list(pagingDto);
			
			mav.addObject("paging", pagingListDto.getPaging());
			mav.addObject("list", pagingListDto.getList());
			mav.addObject("currentPage", "heartList");
		} catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".heartList()] " + e.getMessage(), e);
			mav.setViewName("redirect:/error.web");
		}
	
		return mav;
	
	}
}
