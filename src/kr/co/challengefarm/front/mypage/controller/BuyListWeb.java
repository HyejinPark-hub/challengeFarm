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

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.mypage.dto.BuyListDto;
import kr.co.challengefarm.front.mypage.service.BuyListSrvc;

/**
 * @version 1.0.0
 * @author kalguksu7022@gmail.com
 * 
 * @since 2024-10-04
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.mypage.controller.BuyListWeb")
public class BuyListWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(BuyListWeb.class);
	
	@Inject
	BuyListSrvc buyListSrvc;
	
	@RequestMapping(value = "/front/mypage/buyDetailList.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody List<BuyListDto> buyDetailList(@RequestBody BuyListDto buyListDto, HttpServletRequest request){
		
		List<BuyListDto> buyDetailList = new ArrayList<BuyListDto>();
		
		try {
			buyDetailList = buyListSrvc.buyDetailList(buyListDto);
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".mainSaleList()] " + e.getMessage(), e);
		}
		finally {}
		
		return buyDetailList;
	}
	
	
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
	@RequestMapping(value = "/front/mypage/buyList.web")
	public ModelAndView buyList(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			pagingDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			PagingListDto pagingListDto = buyListSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("front/mypage/buyList");
			mav.addObject("currentPageNm", "buyList");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".buyList()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
