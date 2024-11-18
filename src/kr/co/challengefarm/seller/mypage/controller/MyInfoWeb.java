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
package kr.co.challengefarm.seller.mypage.controller;

import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.seller.common.Common;
import kr.co.challengefarm.seller.mypage.dto.MyInfoDto;
import kr.co.challengefarm.seller.mypage.service.MyInfoSrvc;

/**
 * @version 1.0.0
 * @author kalguksu7022@gmail.com
 * 
 * @since 2024-10-04
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.seller.mypage.controller.MyInfoWeb")
public class MyInfoWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(MyInfoWeb.class);
	
	@Autowired
	Properties staticProperties;
	
	@Inject
	MyInfoSrvc myInfoSrvc;
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-04
	 * <p>DESCRIPTION: 회원 정보 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/mypage/myInfo.web")
	public ModelAndView myInfo(HttpServletRequest request, HttpServletResponse response, MyInfoDto myInfoDto) {
	    
	    ModelAndView mav = new ModelAndView("redirect:/error.web");
	    
	    try {
	        myInfoDto.setSeq_sll(Integer.parseInt(getSession(request, "SEQ_SLL")));
	        
	        MyInfoDto myInfo = myInfoSrvc.select(myInfoDto);
	        
	        if (myInfo != null) {
	           
	        	mav.addObject("myInfoDto", myInfo);
	        	mav.setViewName("seller/mypage/myInfo");
	        	mav.addObject("currentPage", "myInfo");
	        	
	        } else {
	            logger.warn("No MyInfoDto found for seq_sll: " + myInfoDto.getSeq_sll());
	        }
	        
	    } catch (ClassCastException e) {
	        logger.error("Type conversion error: " + e.getMessage(), e);
	    } catch (Exception e) {
	        logger.error("[" + this.getClass().getName() + ".myInfo()] " + e.getMessage(), e);
	    }
	    
	    return mav;
	}

}