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
 * File			: BuyListSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241021104647][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.mypage.dao.BuyListDao;
import kr.co.challengefarm.front.mypage.dto.BuyListDto;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-10-21
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.front.mypage.service.BuyListSrvc")
public class BuyListSrvc {

	@Inject
	BuyListDao buyListDao;
	
	public List<BuyListDto> buyDetailList(BuyListDto buyListDto) {
		return buyListDao.buyDetailList(buyListDto);
	}
	
	
	public PagingListDto list(PagingDto pagingDto) {
		
		PagingListDto pagingListDto = new PagingListDto();
		
		// 전체 라인(행) 수
		int totalLine = buyListDao.count(pagingDto);
		// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
		int totalPage = (int) Math.ceil((double)totalLine / (double)pagingDto.getLinePerPage());
		pagingDto.setTotalLine(totalLine);
		pagingDto.setTotalPage(totalPage);
		if (totalPage == 0) pagingDto.setCurrentPage(1);
		
		pagingListDto.setPaging(pagingDto);
		pagingListDto.setList(buyListDao.list(pagingDto));
		
		return pagingListDto;
	}
}
