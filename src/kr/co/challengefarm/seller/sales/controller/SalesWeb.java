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
 * File			: SalesWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241112152943][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sales.controller;

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

import kr.co.challengefarm.seller.common.Common;
import kr.co.challengefarm.seller.common.dto.PagingDto;
import kr.co.challengefarm.seller.common.dto.PagingListDto;
import kr.co.challengefarm.seller.sales.dto.BuyDetailDto;
import kr.co.challengefarm.seller.sales.service.SalesSrvc;
import kr.co.challengefarm.util.security.SKwithAES;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-11-12
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.seller.sales.controller.SalesWeb")
public class SalesWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(SalesWeb.class);
	
	@Inject
	Properties staticProperties;
	
	@Inject
	SalesSrvc salesSrvc;
	
	/**
	 * @param type
	 * @param sequence
	 * @param model
	 * @return ModelAndView
	 * 
	 * @since 2024-11-12
	 * <p>DESCRIPTION: 판매자 마이페이지 매출관리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/mypage/sales/list.web")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			pagingDto.setRegister(Integer.parseInt(getSession(request, "SEQ_SLL")));
			
			String selectMonth = pagingDto.getDt_reg() == "" ? "" : pagingDto.getDt_reg().substring(0, 7);
			
			PagingListDto pagingListDto = salesSrvc.list(pagingDto);

			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			@SuppressWarnings("unchecked")
			List<BuyDetailDto> list = (List<BuyDetailDto>) pagingListDto.getList();
			
			for (int loop = 0; loop < list.size(); loop++) {
				list.get(loop).setMbr_nm(aes.decode(list.get(loop).getMbr_nm()));
			}
			
			List<BuyDetailDto> month = salesSrvc.month(pagingDto);
			
			mav.addObject("paging",	pagingListDto.getPaging());
			mav.addObject("list",	pagingListDto.getList());
			mav.addObject("month",	month);
			mav.addObject("sMonth",	selectMonth);
			mav.setViewName("seller/mypage/sales/list");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
		
	}
}
