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
 * File			: AuctionWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241029131302][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.controller;

import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

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
import kr.co.challengefarm.front.auction.dto.AuctionDtlImgDto;
import kr.co.challengefarm.front.auction.dto.AuctionDto;
import kr.co.challengefarm.front.auction.dto.BidDto;
import kr.co.challengefarm.front.mypage.service.AuctionSrvc;
import kr.co.challengefarm.util.security.SKwithAES;
import kr.co.challengefarm.front.common.Common;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-29
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.front.mypage.controller.AuctionWeb")
public class AuctionWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(AuctionWeb.class);
	
	@Autowired
	private MessageSourceAccessor dynamicProperties;

	@Inject
	Properties staticProperties;
	
	@Inject
	AuctionSrvc auctionSrvc;

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-11-04
	 * <p>DESCRIPTION: 마이페이지 내가 등록한 경매 입찰 내역</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/mypage/auction/bidView.web")
	public ModelAndView bidView(HttpServletRequest request, HttpServletResponse response, BidDto bidDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			AuctionDto auctionDto = auctionSrvc.state(bidDto);
			
			// 대칭키 암호화(AES-256)
			String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
			SKwithAES aes		= new SKwithAES(staticKey);
			
			List<BidDto> list = auctionSrvc.listBid(bidDto);
			
			for (int loop = 0; loop < list.size(); loop++) {
				list.get(loop).setMbr_nm(aes.decode(list.get(loop).getMbr_nm()));
			}
			
			mav.addObject("list",	list);
			mav.addObject("auctionDto",	auctionDto);
			mav.setViewName("front/mypage/auction/bidView");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".bidView()] " + e.getMessage(), e);
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
	 * <p>DESCRIPTION: 마이페이지 경매 수정 처리</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	@RequestMapping(value = "/front/mypage/auction/modifyProc.web")
	public ModelAndView modifyProc(HttpServletRequest request, HttpServletResponse response, AuctionDto auctionDto, FileUploadDto fileUploadDto
			, String chgMainImg
			, String chgDtlImg) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");

		String message	= "";
		
		try {
			
			auctionDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			// 이미지(대표)
			String pathBase		= dynamicProperties.getMessage("auction.upload.path", "[UNDEFINED]");
			String maxSize		= dynamicProperties.getMessage("auction.upload.file.max5MB"			, "[UNDEFINED]");
			String allowedExt	= dynamicProperties.getMessage("auction.upload.file.extension.image"	, "[UNDEFINED]");
			
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
				
				if (chgMainImg.equals("Y"))
					auctionDto.setImg(fileDto[0].getFileNameSave());
				
				// DB 수정이 완료 된 후 해당 경로의 파일(이미지) 삭제하기
				if (auctionSrvc.update(auctionDto, fileDto, chgMainImg, chgDtlImg)) {
					request.setAttribute("script"	, "alert('수정되었습니다.');");
					request.setAttribute("redirect"	, "/front/mypage/auction/myList.web");
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
			logger.error("[" + this.getClass().getName() + ".modifyProc()] " + e.getMessage(), e);
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
	 * <p>DESCRIPTION: 마이페이지 경매 수정</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/mypage/auction/modify.web")
	public ModelAndView modify(HttpServletRequest request, HttpServletResponse response, AuctionDto auctionDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			AuctionDto _auctionDto = auctionSrvc.select(auctionDto);
			List<AuctionDtlImgDto> _detailImgList = auctionSrvc.selectImgs(auctionDto);
			
			mav.addObject("auctionDto", _auctionDto);
			mav.addObject("detailImgList", _detailImgList);
			
			mav.setViewName("front/mypage/auction/modify");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".modify()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-29
	 * <p>DESCRIPTION: 마이페이지 등록한 경매</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	@RequestMapping(value = "/front/mypage/auction/writeProc.web")
	public ModelAndView writeProc(HttpServletRequest request, HttpServletResponse response, AuctionDto auctionDto, FileUploadDto fileUploadDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");

		String message	= "";
		
		try {

			auctionDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			// 이미지(대표)
			String pathBase		= dynamicProperties.getMessage("auction.upload.path", "[UNDEFINED]");
			String maxSize		= dynamicProperties.getMessage("auction.upload.file.max5MB"			, "[UNDEFINED]");
			String allowedExt	= dynamicProperties.getMessage("auction.upload.file.extension.image"	, "[UNDEFINED]");
			
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
				
				auctionDto.setImg(fileDto[0].getFileNameSave());
				auctionDto.setDt_act_end(auctionDto.getDt_act_end() + " 23:59:59");

				if (auctionSrvc.insert(auctionDto, fileDto)) {
					request.setAttribute("script"	, "alert('등록되었습니다.');");
					request.setAttribute("redirect"	, "/front/mypage/auction/myList.web");
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
	 * @return ModelAndView
	 * 
	 * @since 2024-10-29
	 * <p>DESCRIPTION: 마이페이지 등록한 경매</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/mypage/auction/write.web")
	public ModelAndView write(HttpServletRequest request, HttpServletResponse response, AuctionDto auctionDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("front/mypage/auction/write");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".write()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-29
	 * <p>DESCRIPTION: 마이페이지 참여한 경매</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/mypage/auction/joinList.web")
	public ModelAndView joinList(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			pagingDto.setSeq_mbr(Integer.parseInt(getSession(request, "SEQ_MBR"))); 
			
			PagingListDto pagingListDto = auctionSrvc.joinList(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("front/mypage/auction/joinList");
			mav.addObject("currentPageNm", "joinAuction");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".myList()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
	
	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-29
	 * <p>DESCRIPTION: 마이페이지 등록한 경매</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/front/mypage/auction/myList.web")
	public ModelAndView myList(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			pagingDto.setRegister(Integer.parseInt(getSession(request, "SEQ_MBR")));
			
			PagingListDto pagingListDto = auctionSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("front/mypage/auction/myList");
			mav.addObject("currentPageNm", "myAuction");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".myList()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
