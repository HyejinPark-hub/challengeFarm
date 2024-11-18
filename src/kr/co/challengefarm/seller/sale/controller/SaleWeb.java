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
 * File			: SaleWeb.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004095019][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sale.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.co.challengefarm.common.dto.FileDto;
import kr.co.challengefarm.common.dto.FileUploadDto;
import kr.co.challengefarm.common.file.FileUpload;
import kr.co.challengefarm.seller.common.Common;
import kr.co.challengefarm.seller.common.dto.PagingDto;
import kr.co.challengefarm.seller.common.dto.PagingListDto;
import kr.co.challengefarm.seller.sale.dto.SaleDtlImgDto;
import kr.co.challengefarm.seller.sale.dto.SaleDto;
import kr.co.challengefarm.seller.sale.service.SaleSrvc;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-04
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Controller("kr.co.challengefarm.seller.sale.controller.SaleWeb")
public class SaleWeb extends Common {

	/** Logger */
	private static Logger logger = LoggerFactory.getLogger(SaleWeb.class);

	@Autowired
	private MessageSourceAccessor dynamicProperties;
	
	@Inject
	SaleSrvc saleSrvc;

	/**
	 * @param request [요청 서블릿]
	 * @param response [응답 서블릿]
	 * @return ModelAndView
	 * 
	 * @since 2024-10-08
	 * <p>DESCRIPTION: 판매자 상품 수정</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	@RequestMapping(value = "/seller/sale/modifyProc.web")
	public ModelAndView modifyProc(HttpServletRequest request, HttpServletResponse response, SaleDto saleDto, FileUploadDto fileUploadDto
			, String chgMainImg
			, String chgDtlImg
			, String chgInfoImg) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");

		String message	= "";
		
		try {
			
			saleDto.setUpdater(Integer.parseInt(getSession(request, "SEQ_SLL")));
			
			// 이미지(대표)
			String pathBase		= dynamicProperties.getMessage("seller.upload.path", "[UNDEFINED]");
			String maxSize		= dynamicProperties.getMessage("seller.upload.file.max5MB"			, "[UNDEFINED]");
			String allowedExt	= dynamicProperties.getMessage("seller.upload.file.extension.image"	, "[UNDEFINED]");
			
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
					saleDto.setImg(fileDto[0].getFileNameSave());
				
				// DB 수정이 완료 된 후 해당 경로의 파일(이미지) 삭제하기
				if (saleSrvc.update(saleDto, fileDto, chgMainImg, chgDtlImg, chgInfoImg)) {
					request.setAttribute("script"	, "alert('수정되었습니다.');");
					request.setAttribute("redirect"	, "/seller/sale/list.web");
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
	 * @since 2024-10-04
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sale/modify.web")
	public ModelAndView modify(HttpServletRequest request, HttpServletResponse response, SaleDto saleDto, SaleDtlImgDto saleDtlImgDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			saleDto.setSeq_sle(saleDto.getSeq_sle());
			saleDtlImgDto.setSeq_sle(saleDto.getSeq_sle());
			
			SaleDto _saleDto = saleSrvc.select(saleDto);
			List<SaleDtlImgDto> imgList = saleSrvc.selectImg(saleDtlImgDto);
			
			mav.addObject("saleDto", _saleDto);
			mav.addObject("imgList", imgList);
			mav.addObject("infoImg", imgList.get(imgList.size() - 1).getImg());
			
			mav.setViewName("seller/sale/modify");
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
	 * @since 2024-10-04
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	@RequestMapping(value = "/seller/sale/writeProc.web")
	public ModelAndView writeProc(HttpServletRequest request, HttpServletResponse response, SaleDto saleDto, FileUploadDto fileUploadDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");

		String message	= "";
		
		try {
			
			saleDto.setRegister(Integer.parseInt(getSession(request, "SEQ_SLL")));
			
			// 이미지(대표)
			String pathBase		= dynamicProperties.getMessage("seller.upload.path", "[UNDEFINED]");
			String maxSize		= dynamicProperties.getMessage("seller.upload.file.max5MB"			, "[UNDEFINED]");
			String allowedExt	= dynamicProperties.getMessage("seller.upload.file.extension.image"	, "[UNDEFINED]");
			
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
				
				saleDto.setImg(fileDto[0].getFileNameSave());
				
				
				if (saleSrvc.insert(saleDto, fileDto)) {
					request.setAttribute("script"	, "alert('등록되었습니다.');");
					request.setAttribute("redirect"	, "/seller/sale/list.web");
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
	 * @since 2024-10-04
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sale/write.web")
	public ModelAndView write(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			mav.setViewName("seller/sale/write");
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
	 * @since 2024-10-04
	 * <p>DESCRIPTION:</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@RequestMapping(value = "/seller/sale/list.web")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response, PagingDto pagingDto) {
		
		ModelAndView mav = new ModelAndView("redirect:/error.web");
		
		try {
			
			PagingListDto pagingListDto = saleSrvc.list(pagingDto);
			
			mav.addObject("paging"	, pagingListDto.getPaging());
			mav.addObject("list"	, pagingListDto.getList());
			
			mav.setViewName("seller/sale/list");
		}
		catch (Exception e) {
			logger.error("[" + this.getClass().getName() + ".list()] " + e.getMessage(), e);
		}
		finally {}
		
		return mav;
	}
}
