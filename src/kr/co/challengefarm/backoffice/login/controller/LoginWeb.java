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
 * File			: LoginWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241023171308][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.login.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.backoffice.common.Common;
import kr.co.challengefarm.backoffice.login.dto.LoginDto;
import kr.co.challengefarm.backoffice.login.service.LoginSrvc;
import kr.co.challengefarm.backoffice.users.dto.ManagerDto;
import kr.co.challengefarm.util.Datetime;
import kr.co.challengefarm.util.security.HSwithSHA;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-23
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.backoffice.login.controller.LoginWeb")
public class LoginWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(LoginWeb.class);
	
	@Inject
	LoginSrvc loginSrvc;

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
	@RequestMapping(value = "/console/login/logout.web")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			HttpSession session = request.getSession(false);
			
			// [2024-07-25][pluto@himedia.co.kr][TODO: 세션 만료 시 처리 추가]
			String name		= (String) session.getAttribute("NAME");
			String dt_login	= (String) session.getAttribute("DT_LOGIN");
			session.invalidate();
			
			request.setAttribute("script"	, "alert('" + dt_login + "에 로그인한 " + name + "님 안녕히 가세요.')");
			request.setAttribute("redirect"	, "/console/");
			
			mav.setViewName("forward:/servlet/result.web");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".logout()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
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
	@RequestMapping(value = "/console/login/loginProc.web")
	public ModelAndView loginProc(HttpServletRequest request, HttpServletResponse response, LoginDto loginDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			loginDto.setPasswd(HSwithSHA.encode(loginDto.getPasswd()));
			
			ManagerDto managerDto = loginSrvc.exist(loginDto);
			
			if (managerDto != null
					&& loginDto.getPasswd().equals(managerDto.getPasswd())) {
				
				/** 정상적인 관리자일 경우 세션에 이름과 아이디를 저장 */
				HttpSession session = request.getSession(true);
				session.setAttribute("SEQ_MNG", Integer.toString(managerDto.getSeq_mng()));
				session.setAttribute("NAME", managerDto.getMng_nm());
				session.setAttribute("ID", managerDto.getId());
				session.setAttribute("MNG_LEVEL", managerDto.getMng_level());
				session.setAttribute("DT_LOGIN", Datetime.getNow("yyyy-MM-dd HH:mm:ss"));
				
				request.setAttribute("script", "alert('" + session.getAttribute("NAME")
												+ "님이 "
												+ session.getAttribute("DT_LOGIN")
												+ "에 로그인하였습니다."
												+ "')");
			}
			else {
				request.setAttribute("script", "alert('아이디와 비밀번호를 확인하세요!')");
			}
			
			request.setAttribute("redirect"	, "/console/");
			
			mav.setViewName("forward:/servlet/result.web");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".loginProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
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
	@RequestMapping(value = "/console/login/loginForm.web")
	public ModelAndView loginForm(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("backoffice/login/loginForm");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".loginForm()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
