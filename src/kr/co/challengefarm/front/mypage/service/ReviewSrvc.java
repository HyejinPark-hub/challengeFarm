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
 * File			: ReviewSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241022165229][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.common.dto.FileDto;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.mypage.dao.ReviewDao;
import kr.co.challengefarm.front.mypage.dto.ReviewDto;
import kr.co.challengefarm.front.sale.dto.SaleDto;


/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-10-22
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.front.mypage.service.ReviewSrvc")
public class ReviewSrvc {
	
	@Inject
	ReviewDao reviewDao;
	
	public boolean insert(ReviewDto reviewDto, FileDto[] fileDto) {
		
		int result		= 0;
		
		reviewDto.setSeq_rev(reviewDao.sequence());
		
		result += reviewDao.insert(reviewDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}

	public SaleDto select(SaleDto saleDto) {
		return reviewDao.select(saleDto);
	}
	
	public PagingListDto list(PagingDto pagingDto) {
		PagingListDto pagingListDto = new PagingListDto();
		
		// 전체 라인(행) 수
		int totalLine = reviewDao.count(pagingDto);
		// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
		int totalPage = (int) Math.ceil((double)totalLine / (double)pagingDto.getLinePerPage());
		pagingDto.setTotalLine(totalLine);
		pagingDto.setTotalPage(totalPage);
		if (totalPage == 0) pagingDto.setCurrentPage(1);
		
		pagingListDto.setPaging(pagingDto);
		pagingListDto.setList(reviewDao.list(pagingDto));
		
		return pagingListDto;
	}
	
}
