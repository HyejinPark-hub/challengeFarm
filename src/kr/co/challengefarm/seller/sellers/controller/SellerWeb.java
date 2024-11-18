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
 * File			: SellerWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241002101309][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sellers.controller;

import java.io.IOException;
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

import kr.co.challengefarm.seller.common.Common;
import kr.co.challengefarm.seller.sellers.dto.SellerDto;
import kr.co.challengefarm.seller.sellers.service.SellerSrvc;
import kr.co.challengefarm.util.security.HSwithSHA;
import kr.co.challengefarm.util.security.SKwithAES;
import net.nurigo.java_sdk.api.Message;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-02
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.seller.sellers.controller")
public class SellerWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(SellerWeb.class);

	@Autowired
	Properties staticProperties;
	
	@Inject
	SellerSrvc sellerSrvc;

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
	@RequestMapping(value = "/seller/sellers/changePasswd.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean changePasswd(@RequestBody SellerDto sellerDto) {
		
		boolean result = false;
		
		try {
			sellerDto.setPasswd(HSwithSHA.encode(sellerDto.getPasswd()));
			
			result = sellerSrvc.changePasswd(sellerDto);
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
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 판매자 비밀번호 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/findPasswdProc.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody int findPasswdProc(@RequestBody SellerDto sellerDto){
		
		int certification = 0;
		
		try {
			int info = sellerSrvc.findPasswd(sellerDto);
			
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
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 판매자 아이디 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/findPasswd.web")
	public ModelAndView findPasswd(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("seller/sellers/find/passwd");
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
	 * <p>DESCRIPTION: 판매자 아이디 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/findIdProc.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean findIdProc(@RequestBody SellerDto sellerDto){

		boolean result = false;
		
		try {
			SellerDto info = sellerSrvc.findId(sellerDto);
			
			if (info != null) {
				result = true;
				
				// coolSMS
				String api_key = "";
				String api_secret = "";
				Message coolsms = new Message(api_key, api_secret);
				
				String content = info.getSll_nm() + "님의 아이디는 " + info.getId() + " 입니다.";
				
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
	 * @since 2024-10-24
	 * <p>DESCRIPTION: 판매자 아이디 찾기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/findId.web")
	public ModelAndView findId(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("seller/sellers/find/id");
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
	 * @return ModelAndView
	 * 
	 * @since 2024-06-21
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/checkDuplicate.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody boolean checkDuplicate(@RequestBody SellerDto sellerDto) {
		
		boolean isDuplicate = true;
		
		try {
			
			sellerDto.setId(sellerDto.getId());
			
			int count = sellerSrvc.selectDuplicate(sellerDto);
			
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
	 * @return int
	 * 
	 * @since 2024-10-10
	 * <p>DESCRIPTION: 구매자 회원가입 전화번호 인증</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/checkNumber.json", method = RequestMethod.POST, headers = {"content-type=application/json; charset=UTF-8", "accept=application/json"}, consumes="application/json; charset=UTF-8", produces="application/json; charset=UTF-8")
	public @ResponseBody int checkNumber(@RequestBody SellerDto sellerDto) {
		
		int certification = 0;
		
		try {
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("seller.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			sellerDto.setPhone(aes.encode(sellerDto.getPhone()));
			
			int phone = sellerSrvc.selectPhone(sellerDto);
			
			if (phone == 0) {
				certification = (int)(Math.random() * 8999) + 1000;
				// coolSMS
				String api_key = "";
				String api_secret = "";
				Message coolsms = new Message(api_key, api_secret);
				
				String content = "인증번호[" + certification + "]";
				
				logger.info(content);
				
				/*
				HashMap<String, String> params = new HashMap<String, String>();
				params.put("to", (sellerDto.getPhone()));
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
				*/
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
	 * @param managerDto [회원 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-07-31
	 * <p>DESCRIPTION: 판매자 회원 가입 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/registerProc.web", method = RequestMethod.POST)
	public ModelAndView registerProc(HttpServletRequest request, HttpServletResponse response, SellerDto sellerDto) {
		

		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			// 해쉬 암호화(SHA-256)
			sellerDto.setPasswd(HSwithSHA.encode(sellerDto.getPasswd()));
			//logger.debug("암호화 후(Passwd): " + sellerDto.getPasswd());
			
			boolean result = sellerSrvc.insert(sellerDto);
			
			if (result) logger.debug("가입 성공");
			else logger.debug("가입 실패");

			request.setAttribute("script"	, "alert('회원가입 완료!');");
			request.setAttribute("redirect"	, "/seller/login/loginForm.web");
			
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
	 * @since 2024-10-02
	 * <p>DESCRIPTION: 판매자 회원 가입 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/registerForm.web")
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
			
			mav.setViewName("seller/sellers/registerForm");
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
	 * @since 2024-10-02
	 * <p>DESCRIPTION: 판매자 회원 가입 약관 동의</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/agree.web")
	public ModelAndView agree(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("seller/sellers/agree");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".agree()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	
	@RequestMapping(value = "/seller/sellers/modifyProc.web")
	public ModelAndView modifyProc(HttpServletRequest request, HttpServletResponse response, SellerDto sellerDto, String confirmPasswd) {
	    ModelAndView mav = new ModelAndView("redirect:/error.web");
	    
	    try {
	        int seq_sll = Integer.parseInt(getSession(request, "SEQ_SLL"));
	        
	        sellerDto.setSeq_sll(seq_sll);
	        sellerDto.setUpdater(seq_sll);

	        // 신규 비밀번호가 비어 있는지 확인
	        if (confirmPasswd != null && !confirmPasswd.trim().isEmpty()) {
	            // 신규 비밀번호 암호화
	            sellerDto.setPasswd(HSwithSHA.encode(confirmPasswd));
	            
	            if (sellerSrvc.updatePasswd(sellerDto)) {
	                request.setAttribute("script", "alert('신규 비밀번호가 입력되었습니다.');");
	                request.setAttribute("redirect", "/seller/mypage/");
	            } else {
	                request.setAttribute("script", "alert('시스템 관리자에게 문의하세요!');");
	                request.setAttribute("redirect", "/");
	            }
	        }

	        // 정보 업데이트
	        sellerDto.setEmail(sellerDto.getEmail());
	        sellerDto.setPhone(sellerDto.getPhone());
	        sellerDto.setCorp_nm(sellerDto.getCorp_nm());
	        sellerDto.setCorp_ceo(sellerDto.getCorp_ceo());
	        sellerDto.setPost(sellerDto.getPost());
	        sellerDto.setAddr1(sellerDto.getAddr1());
	        sellerDto.setAddr2(sellerDto.getAddr2());
			sellerDto.setIntro(sellerDto.getIntro());
			
	        // 사용자 정보 업데이트
	        if (sellerSrvc.update(sellerDto)) {
	            request.setAttribute("script", "alert('정보가 수정되었습니다.');");
	            request.setAttribute("redirect", "/seller/mypage/");
	        } else {
	        	logger.warn("정보 수정 실패: " + sellerDto);  // 로그 추가
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
	 * @param boardDto [게시판 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-08-02
	 * <p>DESCRIPTION: 마이페이지 수정 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/modifyForm.web")
	public ModelAndView modifyForm(HttpServletRequest request, HttpServletResponse response, SellerDto sellerDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			sellerDto.setSeq_sll(Integer.parseInt(getSession(request, "SEQ_SLL")));
			
			SellerDto _sellerDto = sellerSrvc.select(sellerDto);
			
			_sellerDto.setEmail(_sellerDto.getEmail());
			_sellerDto.setPhone(_sellerDto.getPhone());
			_sellerDto.setCorp_nm(_sellerDto.getCorp_nm());
	        _sellerDto.setCorp_ceo(_sellerDto.getCorp_ceo());
			_sellerDto.setPost(_sellerDto.getPost());
			_sellerDto.setAddr1(_sellerDto.getAddr1());
			_sellerDto.setAddr2(_sellerDto.getAddr2());
			_sellerDto.setIntro(_sellerDto.getIntro());
			
			mav.addObject("sellerDto", _sellerDto);
			
			mav.setViewName("seller/sellers/modifyForm");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modifyForm()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	// 회원 탈퇴
		@RequestMapping(value = "/seller/sellers/deleteProc.web", method = RequestMethod.POST)
		public void deleteProc(HttpServletRequest request, HttpServletResponse response, @RequestBody SellerDto sellerDto) throws IOException {
		response.setContentType("application/json");
		
			try {
				// 입력 검증
				if (sellerDto.getSeq_sll() <= 0 || sellerDto.getPasswd() == null || sellerDto.getPasswd().isEmpty()) {
				response.getWriter().write("{\"success\": false, \"message\": \"회원번호 또는 비밀번호가 올바르지 않습니다.\", \"errorCode\": \"INVALID_REQUEST\"}");
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				return;
			}
		
			// 데이터베이스에서 암호화된 비밀번호 조회
			String passwdEncoded = sellerSrvc.selectPasswd(sellerDto).getPasswd();
		
			// 입력된 비밀번호 암호화 후 비교
			String passwdEncodedInput = HSwithSHA.encode(sellerDto.getPasswd());
			
			 // 로그로 값 확인
			logger.info("입력된 비밀번호(암호화): " + passwdEncodedInput);
			logger.info("DB에 저장된 비밀번호(암호화): " + passwdEncoded);
		
			if (passwdEncodedInput.equals(passwdEncoded)) {
				sellerDto.setCd_state(8); // 탈퇴 상태로 변경
				if (sellerSrvc.deleteState(sellerDto) == 1) {
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
