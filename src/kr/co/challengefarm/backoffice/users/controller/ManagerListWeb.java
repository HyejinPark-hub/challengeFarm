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
 *				: [20241002101309][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.users.controller;

import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.backoffice.common.Common;
import kr.co.challengefarm.backoffice.users.dto.ManagerListDto;
import kr.co.challengefarm.backoffice.users.service.ManagerListSrvc;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-02
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.backoffice.users.managerListWeb")
public class ManagerListWeb extends Common {
	
	private static Logger logger = LoggerFactory.getLogger(ManagerListWeb.class);

	@Autowired
	Properties staticProperties;
	
	@Autowired
	ManagerListSrvc managerListSrvc;
	
	@RequestMapping(value = "/console/users/managerList.web", method = RequestMethod.GET)
	public String list(Model model) {
		List<ManagerListDto> list = managerListSrvc.list();
		
		model.addAttribute("list", list);
		model.addAttribute("currentPageNm", "managerList");
		
		return "backoffice/users/managerList";
	}
	
	@RequestMapping(value = "/console/users/managerList_cancel.web", method = RequestMethod.GET)
	public String list_cancel(Model model) {
		List<ManagerListDto> list = managerListSrvc.list_cancel();
		
		model.addAttribute("list", list);
		
		return "backoffice/users/managerList";
	}
	
	@RequestMapping(value = "/console/users/modify_Manager.web")
	public ModelAndView modify_Manager(HttpServletRequest request, HttpServletResponse response, ManagerListDto managerListDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			managerListDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_MNG")));
			
			if (managerListSrvc.update(managerListDto)) {
				request.setAttribute("script"	, "alert('적용되었습니다.');");
				request.setAttribute("redirect"	, "/console/users/managerList.web");
			}
			else {
				request.setAttribute("script"	, "alert('시스템 관리자에게 문의하세요!');");
				request.setAttribute("redirect"	, "/");
			}
			mav.setViewName("forward:/servlet/result.web");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modify_Manager()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}

}
