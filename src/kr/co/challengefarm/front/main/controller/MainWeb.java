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
 * File			: MainWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241002130906][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.main.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.main.dto.MainSaleDto;
import kr.co.challengefarm.front.main.dto.VisitorDto;
import kr.co.challengefarm.front.main.service.MainSaleListSrvc;
import kr.co.challengefarm.front.main.service.VisitorSrvc;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-10-02
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.main.controller.MainWeb")
public class MainWeb extends Common{
	
	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(MainWeb.class);
	
	@Inject
	MainSaleListSrvc mainSaleListSrvc;

	@Inject
	VisitorSrvc visitorSrvc;

	@RequestMapping(value = "/front/closingAuction.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody List<MainSaleDto> closingAuctionList(){
		
		List<MainSaleDto> closingAuctionList = new ArrayList<MainSaleDto>();
		
		try {
			closingAuctionList = mainSaleListSrvc.closingAuctionList();
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".closingAuctionList()] " + e.getMessage(), e);
		}
		finally {}
		
		return closingAuctionList;
	}
	
	@RequestMapping(value = "/front/popularAuction.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody MainSaleDto popularAuction(){
		
		MainSaleDto _mainSaleDto = new MainSaleDto();
		
		try {
			_mainSaleDto = mainSaleListSrvc.popularAuction();
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".popularAuction()] " + e.getMessage(), e);
		}
		finally {}
		
		return _mainSaleDto;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-02
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/visits.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean visits(@RequestBody VisitorDto visitorDto){
		
		boolean result = false;
		
		try {
			if (visitorSrvc.select(visitorDto) > 0) {
				if (visitorSrvc.update(visitorDto)) result = true;
			} else {
				if (visitorSrvc.insert(visitorDto)) result = true;
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".mainSaleList()] " + e.getMessage(), e);
		}
		finally {}
		
		return result;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-02
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/mainSaleList.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody List<MainSaleDto> mainSaleList(@RequestBody MainSaleDto mainSaleDto){
		
		List<MainSaleDto> mainSaleList = new ArrayList<MainSaleDto>();
		
		try {
			mainSaleList = mainSaleListSrvc.mainSaleList(mainSaleDto);
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".mainSaleList()] " + e.getMessage(), e);
		}
		finally {}
		
		return mainSaleList;
	}

}
