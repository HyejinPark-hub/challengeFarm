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
 *				: [20241030121112][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.center.controller;

import java.io.File;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

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
import kr.co.challengefarm.backoffice.center.controller.BoardWeb;
import kr.co.challengefarm.backoffice.center.dto.BoardDto;
import kr.co.challengefarm.backoffice.center.service.BoardSrvc;
import kr.co.challengefarm.backoffice.common.Common;
import kr.co.challengefarm.backoffice.common.component.SessionCmpn;
import kr.co.challengefarm.backoffice.common.dto.PagingDto;
import kr.co.challengefarm.backoffice.common.dto.PagingListDto;

/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-10-30
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.backoffice.center.controller.BoardWeb")
public class BoardWeb extends Common {
	
	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(BoardWeb.class);
	
	@Autowired
	private MessageSourceAccessor dynamicProperties;
	
	@Autowired
	SessionCmpn sessionCmpn;
	
	@Inject
	BoardSrvc boardSrvc;
	
	@RequestMapping(value = "/console/center/board.web")
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			pagingDto.setCd_bbs_type(1);
			PagingListDto pagingListDto = boardSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("backoffice/center/board/notice/list");
			mav.addObject("currentPageNm", "board");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
		
	}
	
	@RequestMapping(value = "/console/center/board/faq/list.web")
	public ModelAndView faq(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		ModelAndView mav = new ModelAndView("redirect:/error.web");

				//이건 참고해서 쓰지말자
		try {
			
			List<Integer> cdBbsTypes = Arrays.asList(2, 5);  // 여기에 원하는 값들을 추가
			List<PagingListDto> pagingListDtos = new ArrayList<>();  // 결과를 저장할 리스트
			// 각 cd_bbs_type에 대해 데이터를 처리
			for(Integer cdBbsType : cdBbsTypes) {
				pagingDto.setCd_bbs_type(cdBbsType);  // PagingDto에 cd_bbs_type 값 설정
				PagingListDto pagingListDto = boardSrvc.list(pagingDto);  // 서비스에서 데이터를 가져옴
				pagingListDtos.add(pagingListDto);  // 결과를 리스트에 추가
			}
			// 모델에 페이징 및 리스트 데이터 추가
			mav.addObject("paging2", pagingListDtos.get(0).getPaging());  // 첫 번째 cd_bbs_type의 페이징 정보 사용
			mav.addObject("list2", pagingListDtos.get(0).getList());  // 모든 cd_bbs_type에 대한 리스트 결과를 전달
			
			mav.addObject("paging5", pagingListDtos.get(1).getPaging());  // 첫 번째 cd_bbs_type의 페이징 정보 사용
			mav.addObject("list5", pagingListDtos.get(1).getList());  // 모든 cd_bbs_type에 대한 리스트 결과를 전달
			
			//mav.addObject("listAll", pagingListDtos);
			
			mav.setViewName("backoffice/center/board/faq/list");
			mav.addObject("currentPageNm", "board");
			
		}catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}

		return mav;
	}
	
	@RequestMapping(value = "/console/center/board/question/list.web")
	public ModelAndView question(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			// 0을 경우 판매자와 고객 문의 모두 조회
			pagingDto.setCd_bbs_type(0);
			PagingListDto pagingListDto = boardSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("backoffice/center/board/question/list");
			mav.addObject("currentPageNm", "board");
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
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 파일 다운로드</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/center/board/download.web")
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
			
			String pathBase		= dynamicProperties.getMessage("backoffice.upload.path", "[UNDEFINED]");
			
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
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 뷰 예제</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	/*
	@RequestMapping(value = "/greetings.web")
	public String greetings() {
		return "backoffice/greetings";
	}
	*/
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @param boardDto [게시판 빈]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 고객센터 삭제</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/center/board/remove.web", method = RequestMethod.POST)
	public ModelAndView remove(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			boardDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_MNG")));
			
			if (boardSrvc.deleteFlag(boardDto)) {
				request.setAttribute("script"	, "alert('삭제되었습니다.');");
				
				String[] arrName = new String[1];
				String[] arrValue = new String[1];
				
				arrName[0] = "cd_bbs_type";
				arrValue[0] = Integer.toString(boardDto.getCd_bbs_type()) ;
				
				request.setAttribute("post"		, "/console/center/board.web");
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
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 고객센터 수정 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/center/board/modifyProc.web")
	public ModelAndView modifyProc(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto, FileUploadDto fileUploadDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
String message	= "";
		
		try {
			boardDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_MNG")));
			
			String pathBase		= dynamicProperties.getMessage("backoffice.upload.path", "[UNDEFINED]") + "/bbs/";
			String maxSize		= dynamicProperties.getMessage("backoffice.upload.file.max10MB"			, "[UNDEFINED]");
			String allowedExt	= dynamicProperties.getMessage("backoffice.upload.file.extension.image"	, "[UNDEFINED]");
			
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
					
					/*
					arrName[0] = "cd_bbs_type";
					arrValue[0] = Integer.toString(boardDto.getCd_bbs_type());
					
					request.setAttribute("post"		, "/console/center/board/list.web");
					request.setAttribute("name"		, arrName);
					request.setAttribute("value"	, arrValue);
					*/
					// request.setAttribute("script"	, "alert('등록되었습니다.');");
					// request.setAttribute("redirect"	, "/backoffice/center/board/list.web?cd_bbs_type=" + boardDto.getCd_bbs_type());
					

					
					if (boardDto.getCd_bbs_type() == 1) {
						request.setAttribute("redirect"	, "/console/center/board/notice/list.web");
						
					} else if (boardDto.getCd_bbs_type() == 2) {
						request.setAttribute("redirect"	, "/console/center/board/faq/list.web");
						
					} else if (boardDto.getCd_bbs_type() == 3 || boardDto.getCd_bbs_type() == 6) {
						request.setAttribute("redirect"	, "/console/center/board/question/list.web");
					}
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
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 고객센터 수정 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/center/board/modifyForm.web", method = RequestMethod.POST)
	public ModelAndView modifyForm(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
try {
			
			BoardDto _boardDto = boardSrvc.select(boardDto);
			
			mav.addObject("boardDto", _boardDto);
			
			if (boardDto.getCd_bbs_type() == 1) {
				mav.setViewName("backoffice/center/board/notice/modifyForm");
			}
			else if (boardDto.getCd_bbs_type() == 2) {
				mav.setViewName("backoffice/center/board/faq/modifyForm");
			}
			else if (boardDto.getCd_bbs_type() == 3|| boardDto.getCd_bbs_type() == 6) {
				
				BoardDto boardQuestionDto = boardSrvc.selectQuestion(_boardDto);
				
				mav.addObject("boardQuestionDto", boardQuestionDto);
				mav.setViewName("backoffice/center/board/question/modifyForm");
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
	@RequestMapping(value = "/console/center/board/view.web")
	public ModelAndView view(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			BoardDto _boardDto = boardSrvc.select(boardDto);
			
			// 조회수 증가 실패 시
			if (_boardDto == null ) {
				request.setAttribute("script"	, "alert('시스템 관리자에게 문의하세요!');");
				request.setAttribute("redirect"	, "/");
				mav.setViewName("forward:/servlet/result.web");
			}
			else {
				mav.addObject("boardDto", _boardDto);
				
				if (boardDto.getCd_bbs_type() == 1) {
					mav.setViewName("backoffice/center/board/notice/view");
				}
				else if (boardDto.getCd_bbs_type() == 2) {
					mav.setViewName("backoffice/center/board/faq/view");
				}
				else if (boardDto.getCd_bbs_type() == 3 || boardDto.getCd_bbs_type() == 6) {
					
					// DB 부하 감소를 위해 답변이 있을 때만
					if (_boardDto.getSeq_reply() > 0) {
						BoardDto boardReplyDto = boardSrvc.selectReply(boardDto);
						mav.addObject("boardReplyDto", boardReplyDto);
					}
					
					mav.setViewName("backoffice/center/board/question/view");
				}
				else {
					request.setAttribute("script"	, "alert('시스템 관리자에게 문의하세요!');");
					request.setAttribute("redirect"	, "/");
					mav.setViewName("forward:/servlet/result.web");
				}
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
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 고객센터 쓰기 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
	@RequestMapping(value = "/console/center/board/writeProc.web")
	public ModelAndView writeProc(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto, FileUploadDto fileUploadDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		System.out.println(boardDto.getCd_ctg());
		System.out.println(boardDto.getTitle());
		System.out.println(boardDto.getContent());
		System.out.println(boardDto.getFlg_top());
		System.out.println("---------------------------------------------");
		System.out.println(boardDto.getCd_bbs_type());
		System.out.println("---------------------------------------------");
		
		String message	= "";
		
		try {
			
			boardDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MNG")));
			
			// **************************
			// For Board File
			// **************************
			String pathBase		= dynamicProperties.getMessage("backoffice.upload.path", "[UNDEFINED]") + "/bbs/";
			String maxSize		= dynamicProperties.getMessage("backoffice.upload.file.max10MB"			, "[UNDEFINED]");
			String allowedExt	= dynamicProperties.getMessage("backoffice.upload.file.extension.doc"	, "[UNDEFINED]");
			
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
				
				for (int loop = 0; loop < countFile; loop++) {
					fileNameSrc		= (String)hashtable.get("files[" + loop + "]_fileSrcName");
					fileNameSve		= (String)hashtable.get("files[" + loop + "]_fileSveNameRelative");
					fileSize		= (String)hashtable.get("files[" + loop + "]_fileSveSize");
					if (fileSize == null || fileSize == "") fileSize = "0";
					
					fileDto[loop] = new FileDto();
					fileDto[loop].setFileNameOriginal(fileNameSrc);
					fileDto[loop].setFileNameSave(fileNameSve);
					fileDto[loop].setFileSize((Long.parseLong(fileSize)));
					
					totalSize += Long.parseLong(fileSize);
				}
				
				/*
				if (totalSize > 0) {
					boardSrvc.insert(boardDto, boardFileDto);
				}
				else {
					boardSrvc.insert(boardDto);
				}
				*/
				
				boardDto.setFile_orig(fileNameSrc);
				boardDto.setFile_save("bbs\\" + fileNameSve);
				
				if (boardDto.getCd_bbs_type() == 3 || boardDto.getCd_bbs_type() == 6) {
					// 답변글(상위 일련번호에 문의글 번호를 저장)
					boardDto.setSeq_bbs_parent(boardDto.getSeq_bbs());
					boardDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_MNG")));
				}
				
				if (boardSrvc.insert(boardDto)) {
					
					if (boardDto.getCd_bbs_type() == 3 || boardDto.getCd_bbs_type() == 6) {
						request.setAttribute("script"	, "alert('답변이 등록되었습니다.');");
					}
					else {
						request.setAttribute("script"	, "alert('등록되었습니다.');");
					}
					
					
					if (boardDto.getCd_bbs_type() == 1) {
						request.setAttribute("redirect"	, "/console/center/board/notice/list.web");
						
					} else if (boardDto.getCd_bbs_type() == 2) {
						request.setAttribute("redirect"	, "/console/center/board/faq/list.web");
						
					} else if (boardDto.getCd_bbs_type() == 3 || boardDto.getCd_bbs_type() == 6) {
						request.setAttribute("redirect"	, "/console/center/board/question/list.web");
					}
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
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 고객센터 쓰기 폼</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/center/board/writeForm.web")
	public ModelAndView writeForm(HttpServletRequest request, HttpServletResponse response, BoardDto boardDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			if (boardDto.getCd_bbs_type() == 1) {
				mav.setViewName("backoffice/center/board/notice/writeForm");
			}
			else if (boardDto.getCd_bbs_type() == 2) {
				mav.setViewName("backoffice/center/board/faq/writeForm");
			}
			else if (boardDto.getCd_bbs_type() == 3 || boardDto.getCd_bbs_type() == 6) {
				
				BoardDto _boardDto = boardSrvc.select(boardDto);
				
				mav.addObject("boardDto", _boardDto);
				mav.setViewName("backoffice/center/board/question/writeForm");
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
	 * @since 2024-10-30
	 * <p>DESCRIPTION: 고객센터 목록</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/console/center/board/list.web")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			// 고객 문의(3)이면서 세션이 없을 경우는 로그인 페이지로 보냄
			if (pagingDto.getCd_bbs_type() == 3 && !sessionCmpn.isSession(request)) {
				request.setAttribute("script"	, "alert('로그인이 필요합니다!');");
				request.setAttribute("redirect"	, "/backoffice/login/loginForm.web?url=/backoffice/center/board/list.web");
				mav.setViewName("forward:/servlet/result.web");
			}
			else {
				
				if (pagingDto.getCd_bbs_type() == 3) pagingDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MNG")));
				
				PagingListDto pagingListDto = boardSrvc.list(pagingDto);
				
				mav.addObject("paging"	, pagingListDto.getPaging());
				mav.addObject("list"	, pagingListDto.getList());
				
				if (pagingDto.getCd_bbs_type() == 1) {
					mav.setViewName("backoffice/center/board/notice/list");
				}
				else if (pagingDto.getCd_bbs_type() == 2) {
					mav.setViewName("backoffice/center/board/faq/list");
				}
				else if (pagingDto.getCd_bbs_type() == 3 || pagingDto.getCd_bbs_type() == 6) {
					mav.setViewName("backoffice/center/board/question/list");
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