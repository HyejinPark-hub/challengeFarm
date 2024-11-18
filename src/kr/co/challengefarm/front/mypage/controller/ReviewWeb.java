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
 * File			: ReviewWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004113850][kalguksu7022@gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.controller;

import java.util.Hashtable;
import java.util.LinkedList;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.common.dto.FileDto;
import kr.co.challengefarm.common.dto.FileUploadDto;
import kr.co.challengefarm.common.file.FileUpload;
import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.mypage.dto.ReviewDto;
import kr.co.challengefarm.front.mypage.service.ReviewSrvc;
import kr.co.challengefarm.front.sale.dto.SaleDto;

/**
 * @version 1.0.0
 * @author pluto@himedia.co.kr
 * 
 * @since 2024-10-04
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.mypage.controller.ReviewWeb")
public class ReviewWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(ReviewWeb.class);
	
	@Inject
	ReviewSrvc reviewSrvc;
	
	@Autowired
	private MessageSourceAccessor dynamicProperties;
	
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	@RequestMapping(value = "/front/mypage/writeReviewProc.web")
	public ModelAndView writeReviewProc(HttpServletRequest request, HttpServletResponse response, ReviewDto reviewDto, FileUploadDto fileUploadDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		String message	= "";
		
		try {
			
			reviewDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR")));
			reviewDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			// 이미지(대표)
			String pathBase		= dynamicProperties.getMessage("front.upload.path", "[UNDEFINED]");
			String maxSize		= dynamicProperties.getMessage("front.upload.file.max5MB"			, "[UNDEFINED]");
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
				
				for (int loop = 0; loop < countFile; loop++) {
					fileNameSrc		= (String)hashtable.get("files[" + loop + "]_fileSrcName");
					fileNameSve		= (String)hashtable.get("files[" + loop + "]_fileSveNameRelative");
					fileSize		= (String)hashtable.get("files[" + loop + "]_fileSveSize");
					if (fileSize == null || fileSize == "") fileSize = "0";
					
					fileDto[loop] = new FileDto();
					fileDto[loop].setFileNameOriginal(fileNameSrc);			// 파일 원본명
					fileDto[loop].setFileNameSave(fileNameSve);				// 파일 저장명(경로 포함)
					fileDto[loop].setFileSize((Long.parseLong(fileSize)));	// 파일 크기
					
					totalSize += Long.parseLong(fileSize);
				}
				
				reviewDto.setImg(fileDto[0].getFileNameSave());
				
				
				if (reviewSrvc.insert(reviewDto, fileDto)) {
					request.setAttribute("script"	, "alert('등록되었습니다.');");
					request.setAttribute("redirect"	, "/front/mypage/buyList.web");
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
	
	@RequestMapping(value = "/front/mypage/writeReview.web")
	public ModelAndView writeReview(HttpServletRequest request, HttpServletResponse response, SaleDto saleDto) {
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			SaleDto _saleDto = reviewSrvc.select(saleDto);
			
			mav.addObject("saleDto", _saleDto);
			
			mav.setViewName("front/mypage/review/writeReview");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".writeReview()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
		
	}
			
	@RequestMapping(value = "/front/mypage/review/list.web")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			pagingDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			PagingListDto pagingListDto = reviewSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("front/mypage/review/list");
			mav.addObject("currentPageNm", "reviewList");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
