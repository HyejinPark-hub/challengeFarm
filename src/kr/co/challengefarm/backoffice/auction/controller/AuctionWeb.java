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
 *				: [20241107173342][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.auction.controller;

import java.util.List;
import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.backoffice.auction.dto.AuctionDtlImgDto;
import kr.co.challengefarm.backoffice.auction.dto.AuctionDto;
import kr.co.challengefarm.backoffice.auction.service.AuctionSrvc;
import kr.co.challengefarm.backoffice.common.Common;
import kr.co.challengefarm.backoffice.common.dto.PagingDto;
import kr.co.challengefarm.backoffice.common.dto.PagingListDto;
import kr.co.challengefarm.util.security.SKwithAES;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-11-07
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.backoffice.auction.controller.AuctionWeb")
public class AuctionWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(AuctionWeb.class);
	
	@Inject
	Properties staticProperties;
	
	@Inject
	AuctionSrvc auctionSrvc;
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-11-08
	 * <p>DESCRIPTION: 관리자 경매상품 상태수정</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/auction/update.web")
	public ModelAndView update(HttpServletRequest request, HttpServletResponse response, AuctionDto auctionDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			logger.debug("경매번호: " + auctionDto.getSeq_act());
			logger.debug("경매상태: " + auctionDto.getCd_state_act());
			
			if (auctionSrvc.update(auctionDto)) {
				request.setAttribute("script", "alert('수정되었습니다!')");
			} else {
				request.setAttribute("script", "alert('아이디와 비밀번호를 확인하세요!')");
			}
			request.setAttribute("redirect"	, "/console/auction/list.web");
			
			mav.setViewName("forward:/servlet/result.web");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".update()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-11-08
	 * <p>DESCRIPTION: 관리자 경매상품 상세</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/auction/view.web")
	public ModelAndView view(HttpServletRequest request, HttpServletResponse response, AuctionDto auctionDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			AuctionDto _auctionDto = auctionSrvc.select(auctionDto);
			List<AuctionDtlImgDto> images = auctionSrvc.selectImg(auctionDto);
			
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			_auctionDto.setMbr_nm(aes.decode(_auctionDto.getMbr_nm()));
			_auctionDto.setEmail(aes.decode(_auctionDto.getEmail()));
			
			mav.addObject("auctionDto",	_auctionDto);
			mav.addObject("images",		images);
			mav.setViewName("backoffice/auction/view");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".view()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	@RequestMapping(value = "/console/auction/list.web")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			PagingListDto pagingListDto = auctionSrvc.list(pagingDto);
			
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			@SuppressWarnings("unchecked")
			List<AuctionDto> list = (List<AuctionDto>) pagingListDto.getList();
			
			for (int loop = 0; loop < list.size(); loop++) {
				list.get(loop).setMbr_nm(aes.decode(list.get(loop).getMbr_nm()));
			}
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("backoffice/auction/list");
			mav.addObject("currentPageNm", "auctionList");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
