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
 * File			: about.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241001120313][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.sale.controller;

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
import kr.co.challengefarm.front.sale.dto.HeartDto;
import kr.co.challengefarm.front.sale.service.SaleSrvc;
/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-10-01
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */

@Controller("kr.co.challengefarm.front.main.controller.SaleWeb")
public class SaleWeb extends Common  {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(SaleWeb.class);
	
	@Inject
	SaleSrvc saleSrvc;

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-31
	 * <p>DESCRIPTION: 상품 찜</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/sale/heart.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean bidProc(@RequestBody HeartDto heartDto, HttpServletRequest request){

		boolean result = false;
		
		try {
			if (heartDto.getProcess().equals("insert")) {			// 찜
				result = saleSrvc.insert(heartDto);
			} else if (heartDto.getProcess().equals("delete")) {	// 찜 해제
				result = saleSrvc.delete(heartDto);
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".bidProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return result;
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
	@RequestMapping(value = "/front/sale/list.web")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			if(getSession(request, "SEQ_MBR") != "[UNDEFINED]") {
				pagingDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR")));
			}
			
			if(request.getParameter("gnb_cd_ctg") != null) {
				if(request.getParameter("gnb_cd_ctg").equals("1")){
					pagingDto.setCd_ctg("1");
				}else if(request.getParameter("gnb_cd_ctg").equals("2")){
					pagingDto.setCd_ctg("2");
				}else{
					pagingDto.setCd_ctg(request.getParameter("gnb_cd_ctg"));
				}
			}
			
			// 상품 검색할 때 초기화
			if(pagingDto.getSearchWord() != "") {
				pagingDto.setCurrentPage(1);
			}
			
			PagingListDto pagingListDto = saleSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("/front/sale/list");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
