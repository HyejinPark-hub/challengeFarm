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
 * File			: Details.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004130456][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.buy.controller;

import kr.co.challengefarm.front.buy.service.BuySrvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

import kr.co.challengefarm.front.buy.controller.BuyWeb;
import kr.co.challengefarm.front.buy.dto.BuyDto;
import kr.co.challengefarm.front.buy.dto.BuyImgDto;
import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.front.mypage.dto.BuyListDto;
import kr.co.challengefarm.front.mypage.dto.ReviewDto;
import kr.co.challengefarm.util.security.SKwithAES;

/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-11-15
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */

@Controller("kr.co.challengefarm.front.buy.controller.BuyWeb")
public class BuyWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(BuyWeb.class);
	
	@Autowired
	Properties staticProperties;
	
	@Inject
	BuySrvc buySrvc;
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-22
	 * <p>DESCRIPTION: 결제 완료</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/buy/result.web")
	public ModelAndView result(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			mav.setViewName("front/buy/result");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".result()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	@RequestMapping(value = "/front/buy/writeProc.web")
	public ModelAndView writeProc(HttpServletRequest request, HttpServletResponse response, BuyDto buyDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			buyDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			List<BuyDto> list	= new ArrayList<BuyDto>();
			
			BuyDto _buyDto = new BuyDto();
			_buyDto.setSeq_sle(buyDto.getSeq_sle());
			_buyDto.setImg(buyDto.getImg());
			_buyDto.setSle_nm(buyDto.getSle_nm());
			_buyDto.setSize_name(buyDto.getSize_name());
			_buyDto.setSize_nm(buyDto.getSize_nm());
			_buyDto.setCount(buyDto.getCount());
			_buyDto.setPrice(buyDto.getPrice());
			_buyDto.setDiscount(buyDto.getDiscount());
			list.add(_buyDto);
			
			MemberDto memberDto	= buySrvc.info(buyDto);
			
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
			logger.error("[" + this.getClass().getName() + ".writeProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-06-21
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/buy/buy.web")
	public ModelAndView buy(HttpServletRequest request, HttpServletResponse response, BuyDto buyDto,BuyImgDto buyImgDto, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			if(getSession(request, "SEQ_MBR") != "[UNDEFINED]") {
				buyDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR")));
			}
			
			BuyDto _buyDto = buySrvc.select(buyDto);
			mav.addObject("buyDto", _buyDto);
			
			List<BuyImgDto> _buyImgDto = buySrvc.selectImg(buyImgDto);
			mav.addObject("buyImgDto", _buyImgDto);
			
			pagingDto.setSeq_sle(buyDto.getSeq_sle());
			PagingListDto pagingListDto = buySrvc.reviewlist(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("front/buy/view");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".buy()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	@RequestMapping(value = "/front/buy/reviewList.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody Map<String, Object> reviewList(@RequestBody PagingDto pagingDto, HttpServletRequest request){
		
		Map<String, Object> returnMap = new HashMap<>();
		
		try {
			PagingListDto pagingListDto = buySrvc.reviewlist(pagingDto);

			returnMap.put("paging", pagingListDto.getPaging());
			returnMap.put("list", pagingListDto.getList());
			
		}
		catch (Exception e){
			logger.error("[" + this.getClass().getName() + ".reviewList()] " + e.getMessage(), e);
		}
		finally {}

		return returnMap;
	}
}
