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
 * File			: MemberWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240620143410][pluto@himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.member.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.front.member.service.MemberSrvc;
import kr.co.challengefarm.util.security.HSwithSHA;
import kr.co.challengefarm.util.security.SKwithAES;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
/**
 * @version 1.0.0
 * @author dhtjgml87@himedia.co.kr
 * 
 * @since 2024-06-20
 * <p>DESCRIPTION: 회원 컨트롤러</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.member.controller.MemberWeb")
public class MemberWeb extends Common {
	
	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(MemberWeb.class);
	
	@Autowired
	Properties staticProperties;
	
	@Inject
	MemberSrvc memberSrvc;

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-22
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/changePasswd.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean changePasswd(@RequestBody MemberDto memberDto) {
		
		boolean result = false;
		
		try {
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			memberDto.setMbr_nm(aes.encode(memberDto.getMbr_nm()));
			memberDto.setPhone(aes.encode(memberDto.getPhone()));
			memberDto.setEmail(aes.encode(memberDto.getEmail()));
			memberDto.setPasswd(HSwithSHA.encode(memberDto.getPasswd()));
			
			result = memberSrvc.changePasswd(memberDto);
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
	 * <p>DESCRIPTION: 구매자 아이디 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/findPasswdProc.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody int findPasswdProc(@RequestBody MemberDto memberDto){
		
		int certification = 0;
		
		try {
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			String name		= memberDto.getMbr_nm();
			String number	= memberDto.getPhone();
			String email	= memberDto.getEmail();
			
			memberDto.setMbr_nm(aes.encode(name));
			memberDto.setPhone(aes.encode(number));
			memberDto.setEmail(aes.encode(email));
			
			int info = memberSrvc.findPasswd(memberDto);
			
			if (info == 1) {
				certification = (int)(Math.random() * 8999) + 1000;
				// coolSMS
				String api_key = "";
				String api_secret = "";
				Message coolsms = new Message(api_key, api_secret);

				String content = "인증번호[" + certification + "]";
				
				logger.info(content);
				
				/*
				// 4 params(to, from, type, text) are mandatory. must be filled
				HashMap<String, String> params = new HashMap<String, String>();
				params.put("to", aes.decode(memberDto.getPhone()));
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
	 * @return ModelAndView
	 * 
	 * @since 2024-10-10
	 * <p>DESCRIPTION: 구매자 아이디 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/findPasswd.web")
	public ModelAndView findPasswd(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("front/member/find/passwd");
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
	 * @since 2024-10-10
	 * <p>DESCRIPTION: 구매자 아이디 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/findIdProc.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean findIdProc(@RequestBody MemberDto memberDto){

		boolean result = false;
		
		try {
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			logger.debug(memberDto.getMbr_nm());
			logger.debug(memberDto.getPhone());
			
			String name		= memberDto.getMbr_nm();
			String number	= memberDto.getPhone();
			
			memberDto.setMbr_nm(aes.encode(name));
			memberDto.setPhone(aes.encode(number));
			
			MemberDto info = memberSrvc.findId(memberDto);
			
			if (info != null) {
				result = true;
				
				// coolSMS
				String api_key = "";
				String api_secret = "";
				Message coolsms = new Message(api_key, api_secret);
				
				String content = name + "님의 이메일은 " + aes.decode(info.getEmail()) + " 입니다.";
				
				logger.info(content);
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
	 * @return ModelAndView
	 * 
	 * @since 2024-10-10
	 * <p>DESCRIPTION: 구매자 아이디 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/findId.web")
	public ModelAndView findId(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("front/member/find/id");
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
	 * @return int
	 * 
	 * @since 2024-10-10
	 * <p>DESCRIPTION: 구매자 회원가입 전화번호 인증</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/checkNumber.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody int checkNumber(@RequestBody MemberDto memberDto) {
		
		int certification = 0;
		
		try {
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			memberDto.setPhone(aes.encode(memberDto.getPhone()));
			
			int phone = memberSrvc.selectPhone(memberDto);
			
			if (phone == 0) {
				certification = (int)(Math.random() * 8999) + 1000;
				// coolSMS
				String api_key = "NCSQAZRTBWWVQ3G5";
				String api_secret = "CULAWFIDXGCPZEIDQMACUPUID9WBMHU9";
				Message coolsms = new Message(api_key, api_secret);
				
				String content = "인증번호[" + certification + "]";
				
				logger.info(content);
				
				
				HashMap<String, String> params = new HashMap<String, String>();
				params.put("to", aes.decode(memberDto.getPhone()));
				params.put("from", "01012345678");
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
				
			}
			
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".checkDuplicate()] " + e.getMessage(), e);
		}
		finally {}
		
		return certification;
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
	@RequestMapping(value = "/front/member/checkDuplicate.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean checkDuplicate(@RequestBody MemberDto memberDto) {
		
		boolean isDuplicate = true;
		
		try {
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			memberDto.setEmail(aes.encode(memberDto.getEmail()));
			
			logger.debug("email: " + memberDto.getEmail());
			
			int count = memberSrvc.selectDuplicate(memberDto);
			
			if (count == 0) isDuplicate = false;
			
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".checkDuplicate()] " + e.getMessage(), e);
		}
		finally {}
		
		return isDuplicate;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-01
	 * <p>DESCRIPTION: 이메일 인증</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/front/member/confirmEmail.web")
	public ModelAndView confirmEmail(HttpServletRequest request, HttpServletResponse response, MemberDto memberDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			memberDto.setEmail(URLDecoder.decode(memberDto.getEmail()));
			
			if (memberSrvc.update(memberDto)) {
				request.setAttribute("script"	, "alert('이메일 인증이 완료되어 정상적으로 서비스를 이용할 있습니다.');");
				request.setAttribute("redirect"	, "/front/login/loginForm.web");
			}
			else {
				// [2024-09-19][pluto@himedia.co.kr][TODO: 10분 이내에 인증되지 않은 이메일이므로 '#' + SEQ_MBR + '_' + EMAIL 패턴으로 업데이트]
				request.setAttribute("script"	, "alert('회원 가입 재시도 또는 고객센터에 문의하세요!');");
				request.setAttribute("redirect"	, "/");
			}
			
			mav.setViewName("forward:/servlet/result.web");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".confirmEmail()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param mebmerDto [회원 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-01
	 * <p>DESCRIPTION: 회원 가입 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/registerProc.web", method = RequestMethod.POST)
	public ModelAndView registerProc(HttpServletRequest request, HttpServletResponse response
			, MemberDto memberDto
			, String term_1
			, String term_2
			, String term_3) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			if (term_1 == null || term_1.equals("")) term_1 = "N";
			if (term_2 == null || term_2.equals("")) term_2 = "N";
			if (term_3 == null || term_3.equals("")) term_3 = "N";
			
			String[] arrTermAgreement = {term_1, term_2, term_3};
			
			if (memberDto.getFlg_email() == null || memberDto.getFlg_email().equals("")) memberDto.setFlg_email("N");
			if (memberDto.getFlg_sms() == null || memberDto.getFlg_sms().equals("")) memberDto.setFlg_sms("N");
			
			// 해쉬 암호화(SHA-256)
			memberDto.setPasswd(HSwithSHA.encode(memberDto.getPasswd()));
			
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			memberDto.setEmail(aes.encode(memberDto.getEmail()));
			memberDto.setMbr_nm(aes.encode(memberDto.getMbr_nm()));
			memberDto.setPhone(aes.encode(memberDto.getPhone()));
			memberDto.setPost(aes.encode(memberDto.getPost()));
			memberDto.setAddr1(aes.encode(memberDto.getAddr1()));
			memberDto.setAddr2(aes.encode(memberDto.getAddr2()));
			
			boolean insert = memberSrvc.insert(memberDto, arrTermAgreement, aes.decode(memberDto.getPost()));
			
			if (insert) {
				logger.debug("가입 성공");
			}
			else logger.debug("가입 실패");
			
			
			request.setAttribute("redirect"	, "/front/login/loginForm.web");
			
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
	 * @since 2024-09-30
	 * <p>DESCRIPTION: 회원 가입 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/registerForm.web")
	public ModelAndView registerForm(HttpServletRequest request, HttpServletResponse response
			, String term_1
			, String term_2
			, String term_3) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			String term = "";
			
			if (term_1 == null || term_1.equals("")) term += "N";
			else term += "Y";
			if (term_2 == null || term_2.equals("")) term += "N";
			else term += "Y";
			if (term_3 == null || term_3.equals("")) term += "N";
			else term += "Y";
			
			mav.addObject("term", term);
			
			mav.setViewName("front/member/registerForm");
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
	 * @since 2024-09-30
	 * <p>DESCRIPTION: 회원 가입 약관 동의</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/agree.web")
	public ModelAndView agree(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("front/member/agree");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".agree()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-26
	 * <p>DESCRIPTION: 마이페이지 회원정보 수정 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/modifyProc.web")
	public ModelAndView modifyProc(HttpServletRequest request, HttpServletResponse response, MemberDto memberDto, String _flg_sms, String _flg_email, String confirmPasswd) {
	ModelAndView mav = new ModelAndView("redirect:/error.web");
	
	try {
		int seq_mbr = Integer.parseInt(getSession(request, "SEQ_MBR"));
		
		memberDto.setSeq_mbr(seq_mbr);
		memberDto.setUpdater(seq_mbr);
		
		// 신규 비밀번호가 비어 있는지 확인
		if (confirmPasswd != null && !confirmPasswd.trim().isEmpty()) {
			// 신규 비밀번호 암호화
			memberDto.setPasswd(HSwithSHA.encode(confirmPasswd));
		
			if (memberSrvc.updatePasswd(memberDto)) {
				request.setAttribute("script", "alert('신규 비밀번호가 입력되었습니다.');");
				request.setAttribute("redirect", "/front/myPage/");
			} else {
				request.setAttribute("script", "alert('시스템 관리자에게 문의하세요!');");
				request.setAttribute("redirect", "/");
			}
		}
	
		// SMS 또는 Email 수신 동의 정보 기본값 설정
		if (memberDto.getFlg_email() == null || memberDto.getFlg_email().isEmpty()) {
			memberDto.setFlg_email("N");
		}
		if (memberDto.getFlg_sms() == null || memberDto.getFlg_sms().isEmpty()) {
			memberDto.setFlg_sms("N");
		}
	
		// 정보 업데이트 (필요한 경우 AES 암호화)
		String staticKey = staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
		SKwithAES aes = new SKwithAES(staticKey);
		
		memberDto.setPhone(aes.encode(memberDto.getPhone()));
		memberDto.setPost(aes.encode(memberDto.getPost()));
		memberDto.setAddr1(aes.encode(memberDto.getAddr1()));
		memberDto.setAddr2(aes.encode(memberDto.getAddr2()));
		
		// 사용자 정보 업데이트
		if (memberSrvc.update(memberDto)) {
		request.setAttribute("script", "alert('정보가 수정되었습니다.');");
		request.setAttribute("redirect", "/front/mypage/");
		} else {
		request.setAttribute("script", "alert('정보 수정에 실패했습니다. 시스템 관리자에게 문의하세요.');");
		request.setAttribute("redirect", "/");
		}
		
		mav.setViewName("forward:/servlet/result.web");
	
	} catch (Exception e) {
		logger.error("[" + this.getClass().getName() + ".modifyProc()] " + e.getMessage(), e);
	}
	
		return mav;
	
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-26
	 * <p>DESCRIPTION: 마이페이지 수정 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/modifyForm.web")
	public ModelAndView modifyForm(HttpServletRequest request, HttpServletResponse response, MemberDto memberDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			memberDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			MemberDto _memberDto = memberSrvc.select(memberDto);
			
			_memberDto.setEmail(aes.decode(_memberDto.getEmail()));
			_memberDto.setMbr_nm(aes.decode(_memberDto.getMbr_nm()));
			_memberDto.setPhone(aes.decode(_memberDto.getPhone()));
			_memberDto.setPost(aes.decode(_memberDto.getPost()));
			_memberDto.setAddr1(aes.decode(_memberDto.getAddr1()));
			_memberDto.setAddr2(aes.decode(_memberDto.getAddr2()));
			
			mav.addObject("memberDto", _memberDto);
			
			mav.setViewName("front/member/modifyForm");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modifyForm()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param boardDto [게시판 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-26
	 * <p>DESCRIPTION: 마이페이지 회원정보 탈퇴 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/member/deleteProc.web", method = RequestMethod.POST)
	public void deleteProc(HttpServletRequest request, HttpServletResponse response, @RequestBody MemberDto memberDto) throws IOException {
	response.setContentType("application/json");
	
		try {
			// 입력 검증
			if (memberDto.getSeq_mbr() <= 0 || memberDto.getPasswd() == null || memberDto.getPasswd().isEmpty()) {
			response.getWriter().write("{\"success\": false, \"message\": \"회원번호 또는 비밀번호가 올바르지 않습니다.\", \"errorCode\": \"INVALID_REQUEST\"}");
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
	
		// 데이터베이스에서 암호화된 비밀번호 조회
		String passwdEncoded = memberSrvc.selectPasswd(memberDto).getPasswd();
	
		// 입력된 비밀번호 암호화 후 비교
		String passwdEncodedInput = HSwithSHA.encode(memberDto.getPasswd());
		
		 // 로그로 값 확인
		logger.info("입력된 비밀번호(암호화): " + passwdEncodedInput);
		logger.info("DB에 저장된 비밀번호(암호화): " + passwdEncoded);
	
		if (passwdEncodedInput.equals(passwdEncoded)) {
			memberDto.setCd_state(8); // 탈퇴 상태로 변경
			if (memberSrvc.deleteState(memberDto) == 1) {
				request.getSession().invalidate();
				response.getWriter().write("{\"success\": true}");
			} else {
				response.getWriter().write("{\"success\": false, \"message\": \"탈퇴 처리 중 오류가 발생했습니다.\", \"errorCode\": \"DB_UPDATE_FAILED\"}");
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			}
		} else {
			response.getWriter().write("{\"success\": false, \"message\": \"비밀번호가 일치하지 않습니다.\", \"errorCode\": \"INVALID_PASSWORD\"}");
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			}
		} catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".deleteProc()] " + e.getMessage(), e);
			response.getWriter().write("{\"success\": false, \"message\": \"예외 발생: " + e.getMessage() + "\", \"errorCode\": \"INTERNAL_ERROR\"}");
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
	
}