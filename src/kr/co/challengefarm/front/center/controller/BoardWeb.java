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
 * File			: BoardWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241014121112][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.center.controller;

import java.io.File;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.common.dto.FileDownloadDto;
import kr.co.challengefarm.common.dto.FileDto;
import kr.co.challengefarm.common.dto.FileUploadDto;
import kr.co.challengefarm.common.file.FileUpload;
import kr.co.challengefarm.front.center.controller.BoardWeb;
import kr.co.challengefarm.front.center.dto.BoardDto;
import kr.co.challengefarm.front.center.dto.BoardFileDto;
import kr.co.challengefarm.front.center.service.BoardSrvc;
import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.common.component.SessionCmpn;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;

/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-10-14
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.center.controller.BoardWeb")
public class BoardWeb extends Common {
	
	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(BoardWeb.class);
	
	@Autowired
	private MessageSourceAccessor dynamicProperties;
	
	@Autowired
	SessionCmpn sessionCmpn;
	
	@Inject
	BoardSrvc boardSrvc;
	
	@RequestMapping(value = "/front/center/board.web")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			pagingDto.setCd_bbs_type(1);
			PagingListDto pagingListDto = boardSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("front/center/board/notice/list");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
		
	}
	
	/**
	 * @param type
	 * @param sequence
	 * @param model
	 * @return ModelAndView
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 파일 다운로드</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/center/board/download.web", method = RequestMethod.POST)
	public ModelAndView download(String type, long sequence, Model model) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			BoardDto boardDto = new BoardDto();
			
			FileDownloadDto fileDownloadDto = new FileDownloadDto();
			File file = null;
			
			// [2018-11-05][pluto@plutozone.com][TODO-개선: 타입이 정의되어 있지 않을 경우 처리]
			if (type.equals("BbsNotice")) boardDto.setCd_bbs_type(1);
			else if (type.equals("BbsQuestion")) boardDto.setCd_bbs_type(3);
			
			boardDto.setSeq_bbs((int)sequence);
			
			boardDto	= boardSrvc.select(boardDto);
			boardDto.setFile_orig(boardDto.getFile_orig());
			boardDto.setFile_save(boardDto.getFile_save());
			
			String pathBase		= dynamicProperties.getMessage("front.upload.path", "[UNDEFINED]");
			
			file = new File(pathBase + "" + File.separator + boardDto.getFile_save());
			
			fileDownloadDto.setFile_original(boardDto.getFile_orig());
			fileDownloadDto.setFile_size(file.length());
			
			if (file == null || file.exists() == false ) {
				mav.setViewName("redirect:/error.web?code=404");
				
				return mav;
			}
			else {
				model.addAttribute("file", file);
				model.addAttribute("filename", fileDownloadDto.getFile_original());
				model.addAttribute("filesize", fileDownloadDto.getFile_size());
				
				mav.setViewName("fileDownloadView");
			}
			
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".download()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @return String(=View)
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 뷰 예제</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/greetings.web")
	public String greetings() {
		return "front/greetings";
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param boardDto [게시판 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 삭제</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/center/board/remove.web", method = RequestMethod.POST)
	public ModelAndView remove(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			boardDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			if (boardSrvc.deleteFlag(boardDto)) {
				request.setAttribute("script"	, "alert('삭제되었습니다.');");
				
				String[] arrName = new String[1];
				String[] arrValue = new String[1];
				
				arrName[0] = "cd_bbs_type";
				arrValue[0] = Integer.toString(boardDto.getCd_bbs_type()) ;
				
				request.setAttribute("post"		, "/front/center/board/list.web");
				request.setAttribute("name"		, arrName);
				request.setAttribute("value"	, arrValue);
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
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param boardDto [게시판 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 수정 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/center/board/modifyProc.web", method = RequestMethod.POST)
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
				
				/*
				if (countFile >=2 ) {
					boardSrvc.insert(boardDto, boardFileDto);
				}
				else {
					boardSrvc.insert(boardDto);
				}
				*/
				
				boardDto.setFile_orig(fileNameSrc);
				boardDto.setFile_save("bbs\\" + fileNameSve);
				
				if (boardSrvc.update(boardDto)) {
					// GET에서 POST로 변경
					String[] arrName = new String[1];
					String[] arrValue = new String[1];
					
					arrName[0] = "cd_bbs_type";
					arrValue[0] = "3";
					
					request.setAttribute("script"	, "alert('등록되었습니다.');");
					request.setAttribute("post"		, "/front/center/board/list.web");
					request.setAttribute("name"		, arrName);
					request.setAttribute("value"	, arrValue);
					
					// request.setAttribute("script"	, "alert('등록되었습니다.');");
					// request.setAttribute("redirect"	, "/front/center/board/list.web?cd_bbs_type=" + boardDto.getCd_bbs_type());
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
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param boardDto [게시판 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 수정 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/center/board/modifyForm.web")
	public ModelAndView modifyForm(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			BoardDto _boardDto = boardSrvc.select(boardDto);
			
			mav.addObject("boardDto", _boardDto);
			
			if (boardDto.getCd_bbs_type() == 3) {
				mav.setViewName("front/center/board/question/modifyForm");
			}
			else {
				request.setAttribute("redirect"	, "/");
				mav.setViewName("forward:/servlet/result.web");
			}
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
	 * @since 2024-10-22
	 * <p>DESCRIPTION: 고객센터 보기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/center/board/view.web", method = RequestMethod.POST)
	public ModelAndView view(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto,BoardFileDto boardFileDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			BoardDto _boardDto = boardSrvc.select(boardDto);
			mav.addObject("boardDto", _boardDto);
			
			List<BoardFileDto> _boarFileDto = boardSrvc.selectFile(boardFileDto);
			mav.addObject("boardFileDto", _boarFileDto);
			
			
			if (boardDto.getCd_bbs_type() == 1) {
				mav.setViewName("front/center/board/notice/view");
			}
			else if (boardDto.getCd_bbs_type() == 2) {
				mav.setViewName("front/center/board/faq/view");
			}
			else if (boardDto.getCd_bbs_type() == 3) {
				
				
				// DB 부하 감소를 위해 답변이 있을 때만
				if (_boardDto.getSeq_reply() > 0) {
					BoardDto boardReplyDto = boardSrvc.selectReply(boardDto);
					mav.addObject("boardReplyDto", boardReplyDto);
				}
				
				
				mav.setViewName("front/center/board/question/view");
			}
			else {
				request.setAttribute("redirect"	, "/");
				mav.setViewName("forward:/servlet/result.web");
			}
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
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 쓰기 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@SuppressWarnings({ "rawtypes", "unused", "unchecked" })
	@RequestMapping(value = "/front/center/board/writeProc.web")
	public ModelAndView writeProc(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto, FileUploadDto fileUploadDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		System.out.println(boardDto.getCd_ctg());
		System.out.println(boardDto.getTitle());
		System.out.println(boardDto.getContent());
		System.out.println(boardDto.getFlg_top());
		
		
		String message	= "";
		
		try {
			
			boardDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			// **************************
			// For Board File
			// **************************
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
				
				/*
				if (countFile >=2 ) {
					boardSrvc.insert(boardDto, boardFileDto);
				}
				else {
					boardSrvc.insert(boardDto);
				}
				*/
				
				boardDto.setFile_orig(fileNameSrc);
				boardDto.setFile_save("bbs\\" + fileNameSve);
				
				if (boardSrvc.insert(boardDto)) {
					// GET에서 POST로 변경
					String[] arrName = new String[1];
					String[] arrValue = new String[1];
					
					arrName[0] = "cd_bbs_type";
					arrValue[0] = "3";
					
					request.setAttribute("script"	, "alert('등록되었습니다.');");
					request.setAttribute("post"		, "/front/center/board/list.web");
					request.setAttribute("name"		, arrName);
					request.setAttribute("value"	, arrValue);
					
					// request.setAttribute("script"	, "alert('등록되었습니다.');");
					// request.setAttribute("redirect"	, "/front/center/board/list.web?cd_bbs_type=" + boardDto.getCd_bbs_type());
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
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param boardDto [게시판 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 쓰기 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/center/board/writeForm.web")
	public ModelAndView writeForm(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			logger.debug("boardDto.getCd_bbs_type()=" + boardDto.getCd_bbs_type());
			
			//관리자 등록전까지 test 용
			if (boardDto.getCd_bbs_type() == 1) {
				mav.setViewName("front/center/board/notice/writeForm");
			}
			else if (boardDto.getCd_bbs_type() == 2) {
				mav.setViewName("front/center/board/faq/writeForm");
			}
			else  if (boardDto.getCd_bbs_type() == 3) {
				mav.setViewName("front/center/board/question/writeForm");
			}
			else {
				request.setAttribute("redirect"	, "/");
				mav.setViewName("forward:/servlet/result.web");
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".writeForm()] " + e.getMessage(), e);
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
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 목록</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/center/board/list.web", method = RequestMethod.POST)
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			// 고객 문의(3)이면서 세션이 없을 경우는 로그인 페이지로 보냄
			if (pagingDto.getCd_bbs_type() == 3 && !sessionCmpn.isSession(request)) {
				request.setAttribute("script"	, "alert('로그인이 필요합니다!');");
				request.setAttribute("redirect"	, "/front/login/loginForm.web?url=/front/center/board/list.web");
				mav.setViewName("forward:/servlet/result.web");
			}
			else {
				
				if (pagingDto.getCd_bbs_type() == 3) pagingDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MBR")));
				
				PagingListDto pagingListDto = boardSrvc.list(pagingDto);
				
				mav.addObject("paging"	, pagingListDto.getPaging());
				mav.addObject("list"	, pagingListDto.getList());
				
				if (pagingDto.getCd_bbs_type() == 1) {
					mav.setViewName("front/center/board/notice/list");
				}
				else if (pagingDto.getCd_bbs_type() == 2) {
					mav.setViewName("front/center/board/faq/list");
				}
				else if (pagingDto.getCd_bbs_type() == 3) {
					mav.setViewName("front/center/board/question/list");
				}
				else {
					request.setAttribute("redirect"	, "/");
					mav.setViewName("forward:/servlet/result.web");
				}
			}
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}