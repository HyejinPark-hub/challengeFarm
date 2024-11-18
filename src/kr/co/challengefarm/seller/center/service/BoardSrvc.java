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
 * File			: BoardSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241014121420][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.center.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import kr.co.challengefarm.seller.center.dao.BoardDao;
import kr.co.challengefarm.seller.center.dto.BoardDto;import kr.co.challengefarm.seller.center.dto.BoardFileDto;
import kr.co.challengefarm.seller.common.dto.PagingDto;
import kr.co.challengefarm.seller.common.dto.PagingListDto;

/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-10-14
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.seller.center.service.BoardSrvc")
public class BoardSrvc {
	
	@Inject
	BoardDao boardDao;
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return BoardDto
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 보기(답변)</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public BoardDto selectReply(BoardDto boardDto) {
		return boardDao.selectReply(boardDto);
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return boolean
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 삭제</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@Transactional("txSeller")
	public boolean delete(BoardDto boardDto) {
		
		int result = boardDao.delete(boardDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return boolean
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 등록</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@Transactional("txSeller")
	public boolean insert(BoardDto boardDto) {
		
		
		// 신규 글 번호(seq_bbs)
		boardDto.setSeq_bbs(boardDao.sequence());
		
		int result = boardDao.insert(boardDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return boolean
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 수정</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@Transactional("txSeller")
	public boolean update(BoardDto boardDto) {
		
		int result = boardDao.update(boardDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return boolean
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 삭제(처리)</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	@Transactional("txSeller")
	public boolean deleteFlag(BoardDto boardDto) {
		
		int result = boardDao.deleteFlag(boardDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return boolean
	 * 
	 * @since 2024-10-25
	 * <p>DESCRIPTION: 첨부파일 삭제(처리)</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	/*
	 public void deleteFile(BoardDto boardDto) {
	        boardDao.deleteFile(boardDto);
	    }
	*/
	 
	@Transactional
	public boolean deleteFile(BoardDto boardDto) {
		try{
			int result = boardDao.deleteFile(boardDto);
			
			return result == 1;
		}catch (Exception e) {
			
			return false;
		}
	}
	 
	/**
	 * @param boardDto [게시판 빈]
	 * @return BoardDto
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 보기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */

	 public BoardDto select(BoardDto boardDto) {
		
		int result = boardDao.readed(boardDto);
		
		// 정상적으로 조회수가 증가되면 표시할 게시물 정보를 리턴
		if (result == 1) {
			return boardDao.select(boardDto);
		}
		// 정상적으로 조회수가 증가 안 되면 NULL을 리턴
		else {
			return null;
		}
	}	
	
	
	
	/** 나중에 시간남으면 쓰려고 만들어놓음
	 * 
	 * @param boardFileDto
	 * @return
	 */
	public List<BoardFileDto> selectFile(BoardFileDto boardFileDto) {
		List<BoardFileDto> fileList = boardDao.selectFile(boardFileDto);
		
		if(!fileList.isEmpty()) {
			
		}
		return fileList;
	}
	
	
	/**
	 * @param pagingDto [게시판 빈]
	 * @return PagingListDto
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 목록</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public PagingListDto list(PagingDto pagingDto) {
		
		PagingListDto pagingListDto = new PagingListDto();
		
		// 전체 라인(행) 수
		int totalLine = boardDao.count(pagingDto);
		// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
		int totalPage = (int) Math.ceil((double)totalLine / (double)pagingDto.getLinePerPage());
		pagingDto.setTotalLine(totalLine);
		pagingDto.setTotalPage(totalPage);
		if (totalPage == 0) pagingDto.setCurrentPage(1);
		
		pagingListDto.setPaging(pagingDto);
		pagingListDto.setList(boardDao.list(pagingDto));
		
		return pagingListDto;
	}
}
