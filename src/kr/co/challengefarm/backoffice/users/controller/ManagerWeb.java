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
 * File			: ManagerWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241024102907][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.users.controller;

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

import kr.co.challengefarm.backoffice.common.Common;
import kr.co.challengefarm.backoffice.users.dto.ManagerDto;
import kr.co.challengefarm.backoffice.users.service.ManagerSrvc;
import kr.co.challengefarm.util.security.HSwithSHA;
import net.nurigo.java_sdk.api.Message;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-24
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.backoffice.users.controller.ManagerWeb")
public class ManagerWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(ManagerWeb.class);

	@Autowired
	Properties staticProperties;
	
	@Inject
	ManagerSrvc managerSrvc;

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-24
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/changePasswd.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean changePasswd(@RequestBody ManagerDto managerDto) {
		
		boolean result = false;
		
		try {
			managerDto.setPasswd(HSwithSHA.encode(managerDto.getPasswd()));
			
			result = managerSrvc.changePasswd(managerDto);
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".changePasswd()] " + e.getMessage(), e);
		}
		finally {}
		
		return result;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-22
	 * <p>DESCRIPTION: 관리자 비밀번호 찾기 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/findPasswdProc.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody int findPasswdProc(@RequestBody ManagerDto managerDto){
		
		int certification = 0;
		
		try {
			int info = managerSrvc.findPasswd(managerDto);
			
			if (info == 1) {
				certification = (int)(Math.random() * 8999) + 1000;
				// coolSMS
				String api_key = "";
				String api_secret = "";
				Message coolsms = new Message(api_key, api_secret);

				String content = "인증번호[" + certification + "]";
				
				logger.debug(content);
				
				/*
				// 4 params(to, from, type, text) are mandatory. must be filled
				HashMap<String, String> params = new HashMap<String, String>();
				params.put("to", aes.decode(managerDto.getPhone()));
				params.put("from", "01050453863");
				params.put("type", "SMS");
				params.put("text", content);
				params.put("app_version", "test app 1.2"); // application name and version

				try {
					JSONObject obj = (JSONObject) coolsms.send(params);
					System.out.println(obj.toString());
				} catch (CoolsmsException e) {
					System.out.println(e.getMessage());
					System.out.println(e.getCode());
				}
				*/
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".findPasswdProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return certification;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 관리자 비밀번호 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/findPasswd.web")
	public ModelAndView findPasswd(HttpServletRequest request, HttpServletResponse response, ManagerDto managerDto) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			mav.setViewName("backoffice/manager/find/passwd");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".findPasswd()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 관리자 아이디 찾기 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/findIdProc.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean findIdProc(@RequestBody ManagerDto managerDdto) {
		
		boolean result = false;
		
		try {
			ManagerDto info = managerSrvc.findId(managerDdto);
			
			if (info != null) {
				result = true;
				
				// coolSMS
				String api_key = "";
				String api_secret = "";
				Message coolsms = new Message(api_key, api_secret);
				
				String content = info.getMng_nm() + "님의 아이디는 " + info.getId() + " 입니다.";
				
				logger.debug(content);
				/*
				// 4 params(to, from, type, text) are mandatory. must be filled
				HashMap<String, String> params = new HashMap<String, String>();
				params.put("to", number);	// 수신전화번호
				params.put("from", "01050453863");	// 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
				params.put("type", "SMS");
				params.put("text", content);
				params.put("app_version", "test app 1.2"); // application name and version

				try {
					JSONObject obj = (JSONObject) coolsms.send(params);
					System.out.println(obj.toString());
				} catch (CoolsmsException e) {
					System.out.println(e.getMessage());
					System.out.println(e.getCode());
				}
				*/
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".findIdProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return result;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 관리자 회원가입 이메일 중복체크</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/findId.web")
	public ModelAndView findId(HttpServletRequest request, HttpServletResponse response, ManagerDto managerDto) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			mav.setViewName("backoffice/manager/find/id");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".findId()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-22
	 * <p>DESCRIPTION: 관리자 회원가입 연락처 인증</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/checkCertification.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody int checkCertification(@RequestBody ManagerDto managerDto){
		
		int certification = 0;
		
		try {
			int info = managerSrvc.selectCertification(managerDto);
			
			if (info == 0) {
				certification = (int)(Math.random() * 8999) + 1000;
				// coolSMS
				String api_key = "";
				String api_secret = "";
				Message coolsms = new Message(api_key, api_secret);

				String content = "인증번호[" + certification + "]";
				
				logger.debug(content);
				
				/*
				// 4 params(to, from, type, text) are mandatory. must be filled
				HashMap<String, String> params = new HashMap<String, String>();
				params.put("to", aes.decode(managerDto.getPhone()));
				params.put("from", "01050453863");
				params.put("type", "SMS");
				params.put("text", content);
				params.put("app_version", "test app 1.2"); // application name and version

				try {
					JSONObject obj = (JSONObject) coolsms.send(params);
					System.out.println(obj.toString());
				} catch (CoolsmsException e) {
					System.out.println(e.getMessage());
					System.out.println(e.getCode());
				}
				*/
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".checkCertification()] " + e.getMessage(), e);
		}
		finally {}
		
		return certification;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 관리자 회원가입 이메일 중복체크</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/checkEmailDuplicate.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean checkEmailDuplicate(@RequestBody ManagerDto managerDto) {
		
		boolean isDuplicate = true;
		
		try {
			int count = managerSrvc.selectEmailDuplicate(managerDto);
			
			if (count == 0) isDuplicate = false;
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".checkEmailDuplicate()] " + e.getMessage(), e);
		}
		finally {}
		
		return isDuplicate;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * 
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 관리자 회원가입 아이디 중복체크</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/checkIdDuplicate.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean checkIDDuplicate(@RequestBody ManagerDto managerDto) {
		
		boolean isDuplicate = true;
		
		try {
			int count = managerSrvc.selectIdDuplicate(managerDto);
			
			if (count == 0) isDuplicate = false;
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".checkIDDuplicate()] " + e.getMessage(), e);
		}
		finally {}
		
		return isDuplicate;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param managerDto [회원 빈]
	 * 
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 관리자 회원 가입 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/registerProc.web", method = RequestMethod.POST)
	public ModelAndView registerProc(HttpServletRequest request, HttpServletResponse response, ManagerDto managerDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			// 해쉬 암호화(SHA-256)
			managerDto.setPasswd(HSwithSHA.encode(managerDto.getPasswd()));
			
			boolean insert = managerSrvc.insert(managerDto);
			
			if (insert) {
				logger.debug("가입 성공");
			}
			else logger.debug("가입 실패");
			
			
			request.setAttribute("redirect"	, "/console/login/loginForm.web");
			
			mav.setViewName("forward:/servlet/result.web");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".registerProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-24
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/registerForm.web")
	public ModelAndView registerForm(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			mav.setViewName("backoffice/manager/registerForm");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".registerForm()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-31
	 * <p>DESCRIPTION: 관리자 프로필 수정</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/modifyProc.web")
	public ModelAndView modifyProc(HttpServletRequest request, HttpServletResponse response, ManagerDto managerDto, String newPassword, String confirmPassword) {
		ModelAndView mav = new ModelAndView("redirect:/error.web");
			
		try {
			int seq_mng = Integer.parseInt(getSession(request, "SEQ_MNG"));
			managerDto.setSeq_mng(seq_mng);
			managerDto.setUpdater(seq_mng);
		
			String passwdEncoded_ = HSwithSHA.encode(managerDto.getPasswd());
			String passwdEncoded = managerSrvc.selectPasswd(managerDto).getPasswd();
		
			// 현재 비밀번호 확인
			if (passwdEncoded_.equals(passwdEncoded)) {
				// 신규 비밀번호와 확인 비밀번호 검증
				if (newPassword == null || newPassword.trim().isEmpty()) {
					 request.setAttribute("script", "alert('신규 비밀번호를 입력해 주세요.')");
					 request.setAttribute("redirect", "/console/manager/modifyForm.web");
				} else if (newPassword.length() < 8) {
					 request.setAttribute("script", "alert('신규 비밀번호는 최소 8자 이상이어야 합니다.')");
					 request.setAttribute("redirect", "/console/manager/modifyForm.web");
				} else if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
					 request.setAttribute("script", "alert('신규 비밀번호 확인을 입력해 주세요.');");
					 request.setAttribute("redirect", "/console/manager/modifyForm.web");
				} else if (!newPassword.equals(confirmPassword)) {
					 request.setAttribute("script", "alert('신규 비밀번호와 비밀번호 확인이 일치하지 않습니다.')");
					 request.setAttribute("redirect", "/console/manager/modifyForm.web");
				} else {
					// 신규 비밀번호 암호화
					managerDto.setPasswd(HSwithSHA.encode(newPassword));
				
						if (managerSrvc.updatePasswd(managerDto)) {
							request.setAttribute("script", "alert('신규 비밀번호가 입력되었습니다.');");
							request.setAttribute("redirect", "/console/manager/modifyForm.web");
						} else {
							request.setAttribute("script", "alert('시스템 관리자에게 문의하세요!');");
							request.setAttribute("redirect", "/console/manager/modifyForm.web");
						}
					}
			} else {
				request.setAttribute("script", "alert('변경되지 않았습니다.');");
				request.setAttribute("redirect", "/console/manager/modifyForm.web");
			}
				mav.setViewName("forward:/servlet/result.web");
		
		} catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modifyProc()] " + e.getMessage(), e);
		} finally {}
	
		return mav;
	}

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-29
	 * <p>DESCRIPTION: 관리자 프로필 보기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/manager/modifyForm.web")
	public ModelAndView modifyForm(HttpServletRequest request, HttpServletResponse response, ManagerDto managerDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			managerDto.setSeq_mng(Integer.parseInt(getSession(request, "SEQ_MNG")));
			
			ManagerDto _managerDto = managerSrvc.select(managerDto);
			
			_managerDto.setId(_managerDto.getId());
			_managerDto.setMng_nm(_managerDto.getMng_nm());
			_managerDto.setEmail(_managerDto.getEmail());
			_managerDto.setPhone(_managerDto.getPhone());
			_managerDto.setPost(_managerDto.getPost());
			_managerDto.setAddr1(_managerDto.getAddr1());
			_managerDto.setAddr2(_managerDto.getAddr2());
			
			mav.addObject("managerDto", _managerDto);
			
			mav.setViewName("backoffice/manager/modifyForm");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modifyForm()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
}