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
 * File			: PasswdWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240801164940][whslsl88@gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sellers.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.challengefarm.seller.common.Common;
import kr.co.challengefarm.seller.sellers.dto.SellerDto;
import kr.co.challengefarm.seller.sellers.service.SellerSrvc;
import kr.co.challengefarm.util.security.HSwithSHA;

/**
 * @version 1.0.0
 * @author whslsl88@gmail.com
 * 
 * @since 2024-08-01
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.seller.sellers.controller.PasswdWeb")
public class PasswdWeb extends Common {
	
	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(PasswdWeb.class);

	@Inject
	SellerSrvc sellerSrvc;
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param boardDto [게시판 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-08-01
	 * <p>DESCRIPTION: 고객센터 수정 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sellers/passwd/modifyProc.web")
	public void modifyProc(HttpServletRequest request, HttpServletResponse response, SellerDto sellerDto) {
		try {
		int seq_sll = Integer.parseInt(getSession(request, "SEQ_SLL"));
		sellerDto.setSeq_sll(seq_sll);
		
			// 입력받은 비밀번호(암호화 포함)
		String passwdEncoded_ = HSwithSHA.encode(sellerDto.getPasswd());
			// 암호화된 비밀번호
		String passwdEncoded = sellerSrvc.selectPasswd(sellerDto).getPasswd();
		
		if (passwdEncoded_.equals(passwdEncoded)) {
			// 비밀번호가 일치하면 수정 폼으로 이동
		response.sendRedirect("/seller/sellers/modifyForm.web");
		} else {
			// 비밀번호가 틀린 경우
		response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 상태 코드
			}
		} catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modifyProc()] " + e.getMessage(), e);
		}
	}
	
	// 회원 탈퇴시 첫번째 모달에서 비밀번호 확인(로직명 바꿀 예정)
			@RequestMapping(value = "/seller/sellers/passwd/deleteProc.web", method = RequestMethod.POST)
			public void deleteProc_(HttpServletRequest request, HttpServletResponse response, @RequestBody SellerDto sellerDto) {
				
				try {
					int seq_sll = Integer.parseInt(getSession(request, "SEQ_SLL"));
					sellerDto.setSeq_sll(seq_sll);
					logger.info("회원번호: " + seq_sll);
						
					// 입력받은 비밀번호(암호화 포함)
					String passwdEncoded_ = HSwithSHA.encode(sellerDto.getPasswd());
					// 암호화된 비밀번호 조회
					String passwdEncoded = sellerSrvc.selectPasswd(sellerDto).getPasswd();
				
					// 로그로 값 확인
					logger.info("입력된 비밀번호(암호화): " + passwdEncoded_);
					logger.info("DB에 저장된 비밀번호(암호화): " + passwdEncoded);
					
					if (passwdEncoded_.equals(passwdEncoded)) {
						// 비밀번호가 일치하면 성공 응답을 보냄
						response.setContentType("application/json");
						response.setStatus(HttpServletResponse.SC_OK); // 200 상태 코드
						response.getWriter().write("{\"success\": true}");
					} else {
						// 비밀번호가 틀린 경우
						response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 상태 코드
						response.getWriter().write("{\"success\": false, \"message\": \"비밀번호가 틀렸습니다.\"}");
					}
				} catch (Exception e) {
					logger.error("[" + this.getClass().getName() + ".deleteProc()] " + e.getMessage(), e);
					response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 예외 발생 시 500 상태 코드
				}
			}	

}