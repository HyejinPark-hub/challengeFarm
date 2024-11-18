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
 * File			: QuestionListSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241106182324][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.front.center.dto.BoardDto;
import kr.co.challengefarm.front.center.dto.BoardFileDto;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.front.mypage.dao.QuestionListDao;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-11-06
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.front.mypage.service.QuestionListSrvc")
public class QuestionListSrvc {
	
	@Inject
	QuestionListDao questionListDao;
	
	@Transactional("txFront")
	public boolean deleteFlag(BoardDto boardDto) {
		
		int result = questionListDao.deleteFlag(boardDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	@Transactional("txFront")
	public boolean update(BoardDto boardDto) {
		
		int result = questionListDao.update(boardDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	public BoardDto select(BoardDto boardDto) {
		return questionListDao.select(boardDto);
	}
	
	public List<BoardFileDto> selectFile(BoardFileDto boardFileDto) {
		List<BoardFileDto> fileList = questionListDao.selectFile(boardFileDto);
		return fileList;
	}
	
	public BoardDto selectReply(BoardDto boardDto) {
		return questionListDao.selectReply(boardDto);
	}
	
	public PagingListDto list(PagingDto pagingDto) {
		
		PagingListDto pagingListDto = new PagingListDto();
		
		// 전체 라인(행) 수
		int totalLine = questionListDao.count(pagingDto);
		// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
		int totalPage = (int) Math.ceil((double)totalLine / (double)pagingDto.getLinePerPage());
		pagingDto.setTotalLine(totalLine);
		pagingDto.setTotalPage(totalPage);
		if (totalPage == 0) pagingDto.setCurrentPage(1);
		
		pagingListDto.setPaging(pagingDto);
		pagingListDto.setList(questionListDao.list(pagingDto));
		
		return pagingListDto;
	}

}
