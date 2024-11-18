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
 * File			: SaleWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241111170416][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.sale.controller;

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

import kr.co.challengefarm.backoffice.common.Common;
import kr.co.challengefarm.backoffice.common.dto.PagingDto;
import kr.co.challengefarm.backoffice.common.dto.PagingListDto;
import kr.co.challengefarm.backoffice.sale.dto.SaleDtlImgDto;
import kr.co.challengefarm.backoffice.sale.dto.SaleDto;
import kr.co.challengefarm.backoffice.sale.service.SaleSrvc;
import kr.co.challengefarm.util.security.SKwithAES;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-11-11
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.backoffice.sale.controller.SaleWeb")
public class SaleWeb extends Common {

	private static Logger logger = LoggerFactory.getLogger(SaleWeb.class);

	@Inject
	Properties staticProperties;
	
	@Inject
	SaleSrvc saleSrvc;

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-11-08
	 * <p>DESCRIPTION: 관리자 상품 상태수정</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/sale/update.web")
	public ModelAndView update(HttpServletRequest request, HttpServletResponse response, SaleDto saleDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			if (saleSrvc.update(saleDto)) {
				request.setAttribute("script", "alert('수정되었습니다!')");
			} else {
				request.setAttribute("script", "alert('아이디와 비밀번호를 확인하세요!')");
			}
			request.setAttribute("redirect"	, "/console/sale/list.web");
			
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
	 * @since 2024-11-11
	 * <p>DESCRIPTION: 관리자 상품 상세</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/sale/view.web")
	public ModelAndView view(HttpServletRequest request, HttpServletResponse response, SaleDto saleDto) {

		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			SaleDto _saleDto = saleSrvc.select(saleDto);
			List<SaleDtlImgDto> images = saleSrvc.selectImg(saleDto);
			
			mav.addObject("saleDto", _saleDto);
			mav.addObject("dtlImgs", images);
			mav.setViewName("backoffice/sale/view");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".view()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-11-11
	 * <p>DESCRIPTION: 관리자 상품 리스트</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/sale/list.web")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {

		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			PagingListDto pagingListDto = saleSrvc.list(pagingDto);

			String staticKey = staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes = new SKwithAES(staticKey);
			
			@SuppressWarnings("unchecked")
			List<SaleDto> list = (List<SaleDto>) pagingListDto.getList();
			
			for (int loop = 0; loop < list.size(); loop++) {
				list.get(loop).setMbr_nm(aes.decode(list.get(loop).getMbr_nm()));
			}
			
			mav.addObject("paging",	pagingListDto.getPaging());
			mav.addObject("list",	pagingListDto.getList());
			
			mav.setViewName("backoffice/sale/list");
			mav.addObject("currentPageNm", "saleList");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	
	}
}
