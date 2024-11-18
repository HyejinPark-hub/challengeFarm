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
 *				: [20241023155247][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.main.controller;

import java.util.Calendar;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.backoffice.main.service.MainSrvc;
import kr.co.challengefarm.backoffice.sale.dto.SaleDto;
import kr.co.challengefarm.front.buy.dto.BuyDetailDto;
import kr.co.challengefarm.front.main.dto.VisitorDto;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.seller.sellers.dto.SellerDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-23
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.backoffice.main.controller.MainWeb")
public class MainWeb {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(MainWeb.class);

	@Inject
	MainSrvc mainSrvc;
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-23
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/index.web")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			// 구매자 수
			MemberDto memberDto = new MemberDto();
			int member = mainSrvc.member(memberDto);
			// 판매자 수
			SellerDto sellerDto = new SellerDto();
			int seller = mainSrvc.seller(sellerDto);
			// 판매중인 상품 수
			SaleDto saleDto = new SaleDto();
			int sale = mainSrvc.sale(saleDto);
			// 월 방문자 수
			VisitorDto visitorDto = new VisitorDto();
			Calendar now = Calendar.getInstance();
			visitorDto.setYear(now.get(Calendar.YEAR));
			visitorDto.setMonth(now.get(Calendar.MONTH) +1);
			int visit = mainSrvc.visit(visitorDto);
			// 판매자별 판매중인 상품 리스트
			List<SellerDto> saleList = mainSrvc.saleList(sellerDto);
			// 월별 방문자 수 리스트
			List<VisitorDto> visitorList = mainSrvc.visitorList(visitorDto);
			// 최근 5개월 가입 회원 수 리스트
			List<MemberDto> joinList = mainSrvc.joinList(memberDto);
			// 최근 5개월 탈퇴 회원 수 리스트
			List<MemberDto> outList = mainSrvc.outList(memberDto);
			// 판매자별 월 매출 리스트
			BuyDetailDto buyDetailDto = new BuyDetailDto();
			List<BuyDetailDto> salesList = mainSrvc.salesList(buyDetailDto);
			
			
			mav.addObject("member",			member);
			mav.addObject("seller",			seller);
			mav.addObject("sale",			sale);
			mav.addObject("visit",			visit);
			mav.addObject("saleList",		saleList);
			mav.addObject("visitorList",	visitorList);
			mav.addObject("joinList",		joinList);
			mav.addObject("outList",		outList);
			mav.addObject("salesList",		salesList);
			
			mav.setViewName("backoffice/index");
			mav.addObject("currentPageNm", "home");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".index()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
