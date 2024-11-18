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
 * File			: QuestionListWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241106182109][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.controller;

import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.common.dto.FileDto;
import kr.co.challengefarm.common.dto.FileUploadDto;
import kr.co.challengefarm.common.file.FileUpload;
import kr.co.challengefarm.front.center.dto.BoardDto;
import kr.co.challengefarm.front.center.dto.BoardFileDto;
import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.mypage.service.QuestionListSrvc;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-11-06
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.mypage.controller.QuestionListWeb")
public class QuestionListWeb extends Common {
	
	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(QuestionListWeb.class);
	
	@Autowired
	private MessageSourceAccessor dynamicProperties;
	
	@Inject
	QuestionListSrvc questionListSrvc;
	
	@RequestMapping(value = "/front/mypage/question/remove.web", method = RequestMethod.POST)
	public ModelAndView remove(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			boardDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			if (questionListSrvc.deleteFlag(boardDto)) {
				request.setAttribute("script"	, "alert('삭제되었습니다.');");
				request.setAttribute("redirect"	, "/front/mypage/question/list.web");
				
			}
			else {
				request.setAttribute("script"	, "alert('시스템 관리자에게 문의하세요!');");
				request.setAttribute("redirect"	, "/");
			}
			mav.setViewName("forward:/servlet/result.web");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".remove()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	@RequestMapping(value = "/front/mypage/question/modifyProc.web", method = RequestMethod.POST)
	public ModelAndView modifyProc(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto, FileUploadDto fileUploadDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		String message	= "";
		
		try {
			boardDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			String pathBase		= dynamicProperties.getMessage("front.upload.path", "[UNDEFINED]") + "/bbs/";
			String maxSize		= dynamicProperties.getMessage("front.upload.file.max10MB"			, "[UNDEFINED]");
			String allowedExt	= dynamicProperties.getMessage("front.upload.file.extension.image"	, "[UNDEFINED]");
			
			int countFile = 0;
			if (null != fileUploadDto.getFiles()) countFile = fileUploadDto.getFiles().size();
			
			FileDto[] fileDto = new FileDto[countFile];
			LinkedList<Object> uploadResult = FileUpload.upload(fileUploadDto, pathBase, maxSize, allowedExt, countFile);
			
			message	= (String)((Hashtable)uploadResult.getLast()).get("resultID");
			
			if (message.equals("success")) {
				
				Hashtable<String, String> hashtable	= (Hashtable<String, String>)uploadResult.getLast();
				
				String fileNameSrc	= "";
				String fileNameSve	= "";
				String fileSize		= "";
				long totalSize		= 0;
				
				logger.debug("countFile=" + countFile);
				for (int loop = 0; loop < countFile; loop++) {
					fileNameSrc		= (String)hashtable.get("files[" + loop + "]_fileSrcName");
					fileNameSve		= (String)hashtable.get("files[" + loop + "]_fileSveNameRelative");
					fileSize		= (String)hashtable.get("files[" + loop + "]_fileSveSize");
					if (fileSize == null || fileSize == "") fileSize = "0";
					
					fileDto[loop] = new FileDto();
					fileDto[loop].setFileNameOriginal(fileNameSrc);
					fileDto[loop].setFileNameSave(fileNameSve);
					fileDto[loop].setFileSize((Long.parseLong(fileSize)));
					logger.debug("fileNameSrc=" + fileNameSrc);
					logger.debug("fileNameSve=" + fileNameSve);
					logger.debug("fileSize=" + fileSize);
					
					totalSize += Long.parseLong(fileSize);
				}
				
				boardDto.setFile_orig(fileNameSrc);
				boardDto.setFile_save("bbs\\" + fileNameSve);
				
				if (questionListSrvc.update(boardDto)) {
					request.setAttribute("script"	, "alert('등록되었습니다.');");
					request.setAttribute("redirect"		, "/front/mypage/question/list.web");
				}
				else {
					request.setAttribute("script"	, "alert('시스템 관리자에게 문의하세요!');");
					request.setAttribute("redirect"	, "/");
				}
			}
			else {
				request.setAttribute("script"	, "alert('" + message + "');");
				request.setAttribute("redirect"	, "/");
			}
			mav.setViewName("forward:/servlet/result.web");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".writeProc()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	@RequestMapping(value = "/front/mypage/question/modifyForm.web", method = RequestMethod.POST)
	public ModelAndView modifyForm(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			BoardDto _boardDto = questionListSrvc.select(boardDto);
			
			mav.addObject("boardDto", _boardDto);
			mav.setViewName("front/mypage/question/modifyForm");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modifyForm()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	@RequestMapping(value = "/front/mypage/question/view.web", method = RequestMethod.POST)
	public ModelAndView view(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto,BoardFileDto boardFileDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			BoardDto _boardDto = questionListSrvc.select(boardDto);
			mav.addObject("boardDto", _boardDto);
			
			List<BoardFileDto> _boarFileDto = questionListSrvc.selectFile(boardFileDto);
			mav.addObject("boardFileDto", _boarFileDto);
			
			if (_boardDto.getSeq_reply() > 0) {
				BoardDto boardReplyDto = questionListSrvc.selectReply(boardDto);
				mav.addObject("boardReplyDto", boardReplyDto);
			}
			
			mav.setViewName("front/mypage/question/view");
			
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".view()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-11-06
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/mypage/question/list.web")
	public ModelAndView questionList(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			pagingDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			PagingListDto pagingListDto = questionListSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("front/mypage/question/list");
			mav.addObject("currentPageNm", "questionList");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".questionList()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
