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
 * File			: AuctionWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241030113952][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.auction.controller;

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

import kr.co.challengefarm.front.auction.dto.AuctionDtlImgDto;
import kr.co.challengefarm.front.auction.dto.AuctionDto;
import kr.co.challengefarm.front.auction.dto.BidDto;
import kr.co.challengefarm.front.auction.dto.ChatDto;
import kr.co.challengefarm.front.auction.service.AuctionSrvc;
import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;


/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-30
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.auction.controller.AuctionWeb")
public class AuctionWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(AuctionWeb.class);
	
	@Inject
	AuctionSrvc auctionSrvc;

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-11-01
	 * <p>DESCRIPTION: 경매 채팅 업데이트</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/auction/chatInterval.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody List<ChatDto> chatInterval(@RequestBody ChatDto chatDto, HttpServletRequest request){
		
		List<ChatDto> list = null;
		
		try {
			list = auctionSrvc.list(chatDto);
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".chatInterval()] " + e.getMessage(), e);
		}
		finally {}
		
		return list;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-11-01
	 * <p>DESCRIPTION: 경매 채팅 등록</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/auction/chatProc.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean chatProc(@RequestBody ChatDto chatDto, HttpServletRequest request){

		boolean result = false;
		
		try {
			result = auctionSrvc.insertChat(chatDto);
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".chatProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return result;
	}

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-11-04
	 * <p>DESCRIPTION: 경매 채팅 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/auction/chatForm.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody List<ChatDto> chatForm(@RequestBody ChatDto chatDto, HttpServletRequest request){
		
		List<ChatDto> list = null;
		
		try {
			list = auctionSrvc.list(chatDto);
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".chatForm()] " + e.getMessage(), e);
		}
		finally {}
		
		return list;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 입찰하기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/auction/bidProc.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean bidProc(@RequestBody BidDto bidDto, HttpServletRequest request){

		boolean result = false;
		
		try {
			if (bidDto.getProcess().equals("insert")) {			// 입찰
				result = auctionSrvc.insert(bidDto);
			} else if (bidDto.getProcess().equals("update") || bidDto.getProcess().equals("rebid")) {	// 입찰가 수정
				result = auctionSrvc.update(bidDto);
			} else if (bidDto.getProcess().equals("delete")) {	// 입찰 포기
				result = auctionSrvc.giveUp(bidDto);
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".bidProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return result;
	}
	
	@RequestMapping(value = "/front/auction/view.web")
	public ModelAndView view(HttpServletRequest request, HttpServletResponse response, AuctionDto auctionDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			auctionDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR")));
			AuctionDto _auctionDto = auctionSrvc.select(auctionDto);
			
			List<AuctionDtlImgDto> auctionImgDto = auctionSrvc.selectImgs(auctionDto);
			
			mav.addObject("auctionDto", _auctionDto);
			mav.addObject("auctionImgDto", auctionImgDto);
			
			mav.setViewName("/front/auction/view");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modify()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	@RequestMapping(value = "/front/auction/list.web")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			PagingListDto pagingListDto = auctionSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("/front/auction/list");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
