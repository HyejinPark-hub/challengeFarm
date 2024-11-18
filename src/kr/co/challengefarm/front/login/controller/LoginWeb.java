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
 * Program		: kr.co.challengefarm
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			: LoginWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240618160606][pluto@himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.login.controller;

import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.login.dto.LoginDto;
import kr.co.challengefarm.front.login.service.LoginSrvc;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.util.Datetime;
import kr.co.challengefarm.util.security.HSwithSHA;
import kr.co.challengefarm.util.security.SKwithAES;
import kr.co.challengefarm.util.servlet.Request;

/**
 * @version 1.0.0
 * @author pluto@himedia.co.kr
 * 
 * @since 2024-06-18
 * <p>DESCRIPTION: 로그인 컨트롤러</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.login.controller.LoginWeb")
public class LoginWeb extends Common {
	
	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(LoginWeb.class);

	@Autowired
	Properties staticProperties;
	
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
	@RequestMapping(value = "/front/login/logout.web")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			HttpSession session = request.getSession(false);
			
			// [2024-07-25][pluto@himedia.co.kr][TODO: 세션 만료 시 처리 추가]
			String name		= (String) session.getAttribute("NAME");
			String dt_login	= (String) session.getAttribute("DT_LOGIN");
			session.invalidate();
			
			request.setAttribute("script"	, "alert('" + dt_login + "에 로그인한 " + name + "님 안녕히 가세요.')");
			request.setAttribute("redirect"	, "/");
			
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
	 * @param loginDto [로그인 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-02
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/login/loginProc.web", method = RequestMethod.POST)
	public ModelAndView loginProc(HttpServletRequest request, HttpServletResponse response, LoginDto loginDto, String checkID) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			loginDto.setEmail(aes.encode(loginDto.getEmail()));
			
			MemberDto memberDto = loginSrvc.exist(loginDto);
			
			if (memberDto != null
					&& HSwithSHA.encode(loginDto.getPasswd()).equals(memberDto.getPasswd())) {
				
				/** 최종 접속한 IP와 시간을 업데이트 */
				memberDto.setLast_ip(Request.getRemoteAddr(request));
				
				if (!loginSrvc.updateLast(memberDto))
					logger.info("[ERROR] 최종 접속한 IP와 시간을 업데이트에 실패하였습니다!");
				
				// 아이디 저장 체크시 cookie에 로그인 정보 저장
				Cookie checkedID = new Cookie("checkedID", "Y");
				checkedID.setPath("/");
				Cookie loginType = new Cookie("loginType", "member");
				loginType.setPath("/");
				Cookie loginId = new Cookie("loginId", aes.decode(memberDto.getEmail()));
				loginId.setPath("/");
				
				if (checkID == null) checkID = "N";
				if (checkID.equals("Y")) {
					checkedID.setMaxAge(60*60*24*7);
					loginType.setMaxAge(60*60*24*7);
					loginId.setMaxAge(60*60*24*7);
				} else {
					checkedID.setMaxAge(0);
					loginType.setMaxAge(0);
					loginId.setMaxAge(0);
				}
				response.addCookie(checkedID);
				response.addCookie(loginType);
				response.addCookie(loginId);
				
				/** 정상적인 회원일 경우 세션에 이름과 아이디를 저장 */
				HttpSession session = request.getSession(true);
				session.setAttribute("SEQ_MBR", Integer.toString(memberDto.getSeq_mbr()));
				session.setAttribute("NAME", aes.decode(memberDto.getMbr_nm()));
				session.setAttribute("EMAIL", aes.decode(memberDto.getEmail()));
				session.setAttribute("DT_LOGIN", Datetime.getNow("yyyy-MM-dd HH:mm:ss"));
				
				request.setAttribute("script", "alert('" + session.getAttribute("NAME")
												+ "님이 "
												+ session.getAttribute("DT_LOGIN")
												+ "에 로그인하였습니다."
												+ "')");
				
				request.setAttribute("redirect"	, "/");
			}
			else {
				// logger.debug("해당 회원이 없거나 암호가 일치하지 않음");
				request.setAttribute("script", "alert('이메일(아이디)과 비밀번호를 확인하세요!')");
				request.setAttribute("redirect"	, "/front/login/loginForm.web");
			}
			
			
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
	 * @since 2024-06-21
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/login/loginForm.web")
	public ModelAndView loginForm(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("front/login/loginForm");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".loginForm()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}