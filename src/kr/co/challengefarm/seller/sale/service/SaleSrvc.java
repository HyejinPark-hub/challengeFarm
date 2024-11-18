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
 * File			: SaleSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004164433][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sale.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.common.dto.FileDto;
import kr.co.challengefarm.seller.common.dto.PagingDto;
import kr.co.challengefarm.seller.common.dto.PagingListDto;
import kr.co.challengefarm.seller.sale.dao.SaleDao;
import kr.co.challengefarm.seller.sale.dto.SaleDtlImgDto;
import kr.co.challengefarm.seller.sale.dto.SaleDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-04
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.seller.sale.service.SaleSrvc")
public class SaleSrvc {

	@Inject
	SaleDao saleDao;

	public boolean update(SaleDto saleDto, FileDto[] fileDto, String chgMainImg, String chgDtlImg, String chgInfoImg) {
		
		int result		= 0;
		int imgResult	= 0;
		int delDetail	= 0;
		int delInfo		= 0;
		
		result += saleDao.update(saleDto);
		
		SaleDtlImgDto saleDtlImgDto = new SaleDtlImgDto();
		
		for (int loop = 1; loop < fileDto.length; loop++) {
			if (fileDto[loop].getFileSize() > 0) {
				
				String flgInfo = null;
				
				if (chgDtlImg.equals("Y")) {
					saleDtlImgDto.setSeq_sle(saleDto.getSeq_sle());
					delDetail = saleDao.deleteDtlImg(saleDtlImgDto);
				}
				if (chgInfoImg.equals("Y")) {
					saleDtlImgDto.setSeq_sle(saleDto.getSeq_sle());
					delInfo = saleDao.deleteInfoImg(saleDtlImgDto);
				}
				
				if ((chgDtlImg.equals("Y") && delDetail >= 1)
						|| (chgInfoImg.equals("Y") && delInfo == 1)
						|| !(chgDtlImg.equals("N") && chgInfoImg.equals("N"))) {
					saleDtlImgDto.setSeq_sle_img(saleDao.detailSequence());
					saleDtlImgDto.setSeq_sle(saleDto.getSeq_sle());
					saleDtlImgDto.setImg(fileDto[loop].getFileNameSave());
					saleDtlImgDto.setRegister(saleDto.getUpdater());
					if (chgInfoImg.equals("Y")) {
						if (loop == fileDto.length - 1)
							flgInfo = "Y";
					}
					saleDtlImgDto.setFlg_info(flgInfo);
					
					result += saleDao.insertImg(saleDtlImgDto);
					imgResult++;
				}
			}
		}
		
		if (result == imgResult + 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	public List<SaleDtlImgDto> selectImg(SaleDtlImgDto saleDtlImgDto) {
		return saleDao.selectImg(saleDtlImgDto);
	}
	
	public SaleDto select(SaleDto saleDto) {
		return saleDao.select(saleDto);
	}

	@Transactional("txSeller")
public boolean insert(SaleDto saleDto, FileDto[] fileDto) {
		
		int result		= 0;
		int imgResult	= 0;
		
		saleDto.setSeq_sle(saleDao.sequence());
		
		result += saleDao.insert(saleDto);
		
		SaleDtlImgDto saleDtlImgDto = new SaleDtlImgDto();
		
		for (int loop = 1; loop < fileDto.length; loop++) {
			if (fileDto[loop].getFileSize() > 0) {
				
				String flgInfo = null;
				
				saleDtlImgDto.setSeq_sle_img(saleDao.detailSequence());
				saleDtlImgDto.setSeq_sle(saleDto.getSeq_sle());
				saleDtlImgDto.setImg(fileDto[loop].getFileNameSave());
				saleDtlImgDto.setRegister(saleDto.getRegister());
				if (loop == fileDto.length - 1)
					flgInfo = "Y";
				saleDtlImgDto.setFlg_info(flgInfo);
				
				result += saleDao.insertImg(saleDtlImgDto);
				imgResult++;
			}
		}
		
		if (result == imgResult + 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	/**
	 * @param pagingDto [게시판 빈]
	 * @return PagingListDto
	 * 
	 * @since 2024-10-08
	 * <p>DESCRIPTION: 판매자 상품현황</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public PagingListDto list(PagingDto pagingDto) {
		
		PagingListDto pagingListDto = new PagingListDto();
		
		// 전체 라인(행) 수
		int totalLine = saleDao.count(pagingDto);
		// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
		int totalPage = (int) Math.ceil((double)totalLine / (double)pagingDto.getLinePerPage());
		pagingDto.setTotalLine(totalLine);
		pagingDto.setTotalPage(totalPage);
		if (totalPage == 0) pagingDto.setCurrentPage(1);
		
		pagingListDto.setPaging(pagingDto);
		pagingListDto.setList(saleDao.list(pagingDto));
		
		return pagingListDto;
	}
}
