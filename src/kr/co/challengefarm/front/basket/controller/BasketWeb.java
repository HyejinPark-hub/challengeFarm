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
 * File			: BasketWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241011142744][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.basket.controller;

import java.util.List;
import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.front.basket.dto.BasketDto;
import kr.co.challengefarm.front.basket.service.BasketSrvc;
import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.util.security.SKwithAES;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-11
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.basket.controller.BasketWeb")
public class BasketWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(BasketWeb.class);

	@Autowired
	Properties staticProperties;
	
	@Inject
	BasketSrvc basketSrvc;

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-21
	 * <p>DESCRIPTION: 장바구니</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/basket/writeProc.web")
	public ModelAndView writeProc(HttpServletRequest request, HttpServletResponse response, BasketDto basketDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			basketDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			List<BasketDto> list	= basketSrvc.order(basketDto);
			
			MemberDto memberDto		= basketSrvc.info(basketDto);
			
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
						
			memberDto.setMbr_nm(aes.decode(memberDto.getMbr_nm()));
			memberDto.setPhone(aes.decode(memberDto.getPhone()));
			memberDto.setPost(aes.decode(memberDto.getPost()));
			memberDto.setAddr1(aes.decode(memberDto.getAddr1()));
			memberDto.setAddr2(aes.decode(memberDto.getAddr2()));
			
			mav.addObject("memberDto"	, memberDto);
			mav.addObject("list"		, list);
			
			mav.setViewName("front/basket/writeProc");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".index()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request 
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-10
	 * <p>DESCRIPTION: 장바구니 담기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/basket/changeBaket.web", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean changeBaket(@RequestBody BasketDto basketDto, HttpServletRequest request){
		
		boolean result = false;
		
		try {
			int seq_mbr = Integer.parseInt(getSession(request, "SEQ_MBR"));
			basketDto.setSeq_mbr(seq_mbr);
			basketDto.setUpdater(seq_mbr);
			
			if (basketSrvc.update(basketDto)) {
				result = true;
				
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".changeBaket()] " + e.getMessage(), e);
		}
		finally {}
		
		return result;
	}
	
	/**
	 * @param request 
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-10
	 * <p>DESCRIPTION: 장바구니 담기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/basket/setBasket.web", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean setBasket(@RequestBody BasketDto basketDto, HttpServletRequest request){

		boolean result = false;
		
		try {
			int seq_mbr = Integer.parseInt(getSession(request, "SEQ_MBR"));
			basketDto.setSeq_mbr(seq_mbr);
			
			int find = basketSrvc.select(basketDto);
			
			if (find == 0) {
				if (basketSrvc.insert(basketDto)) result = true;
			}
			else if (find == 1) {
				basketDto.setUpdater(seq_mbr);
				
				if (basketSrvc.update(basketDto)) result = true;
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".setBasket()] " + e.getMessage(), e);
		}
		finally {}
		
		return result;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-11
	 * <p>DESCRIPTION: 장바구니</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/basket/index.web")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response, BasketDto basketDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {

			basketDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			List<BasketDto> list = basketSrvc.list(basketDto);
			
			mav.addObject("list", list);
			
			mav.setViewName("front/basket/index");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".index()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
