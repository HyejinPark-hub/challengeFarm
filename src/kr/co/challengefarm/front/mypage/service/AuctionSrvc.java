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
 * File			: AuctionSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241029131309][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.common.dto.FileDto;
import kr.co.challengefarm.front.mypage.dao.AuctionDao;
import kr.co.challengefarm.front.auction.dto.AuctionDtlImgDto;
import kr.co.challengefarm.front.auction.dto.AuctionDto;
import kr.co.challengefarm.front.auction.dto.BidDto;
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
@Service("kr.co.challengefarm.front.mypage.service.AuctionSrvc")
public class AuctionSrvc {

	@Inject
	AuctionDao auctionDao;

	public AuctionDto state(BidDto bidDto) {
		return auctionDao.state(bidDto);
	}
	
	public List<BidDto> listBid(BidDto bidDto) {
		return auctionDao.listBid(bidDto);
	}
	
	public PagingListDto joinList(PagingDto pagingDto) {
		
		PagingListDto pagingListDto = new PagingListDto();
		
		// 전체 라인(행) 수
		int totalLine = auctionDao.joinCount(pagingDto);
		// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
		int totalPage = (int) Math.ceil((double)totalLine / (double)pagingDto.getLinePerPage());
		pagingDto.setTotalLine(totalLine);
		pagingDto.setTotalPage(totalPage);
		if (totalPage == 0) pagingDto.setCurrentPage(1);
		
		pagingListDto.setPaging(pagingDto);
		pagingListDto.setList(auctionDao.joinList(pagingDto));
		
		return pagingListDto;
	}
	
	public PagingListDto list(PagingDto pagingDto) {
		
		PagingListDto pagingListDto = new PagingListDto();
		
		// 전체 라인(행) 수
		int totalLine = auctionDao.count(pagingDto);
		// 전체 페이지 수 = 전체 라인(행) 수 / 페이징할 라인수
		int totalPage = (int) Math.ceil((double)totalLine / (double)pagingDto.getLinePerPage());
		pagingDto.setTotalLine(totalLine);
		pagingDto.setTotalPage(totalPage);
		if (totalPage == 0) pagingDto.setCurrentPage(1);
		
		pagingListDto.setPaging(pagingDto);
		pagingListDto.setList(auctionDao.list(pagingDto));
		
		return pagingListDto;
	}

	@Transactional("txFront")
	public boolean update(AuctionDto auctionDto, FileDto[] fileDto, String chgMainImg, String chgDtlImg) {
		
		int result		= 0;
		int imgResult	= 0;
		int delDetail	= 0;
		
		result += auctionDao.update(auctionDto);
		
		AuctionDtlImgDto auctionDtlImgDto = new AuctionDtlImgDto();
		
		for (int loop = 1; loop < fileDto.length; loop++) {
			if (fileDto[loop].getFileSize() > 0) {
				
				if (chgDtlImg.equals("Y")) {
					auctionDtlImgDto.setSeq_act(auctionDto.getSeq_act());
					delDetail = auctionDao.deleteDtlImg(auctionDtlImgDto);
				}
				
				if ((chgDtlImg.equals("Y") && delDetail >= 1)
						|| !(chgDtlImg.equals("N"))) {
					auctionDtlImgDto.setSeq_act_img(auctionDao.detailSequence());
					auctionDtlImgDto.setSeq_act(auctionDto.getSeq_act());
					auctionDtlImgDto.setImg(fileDto[loop].getFileNameSave());
					auctionDtlImgDto.setRegister(auctionDto.getUpdater());
					
					result += auctionDao.insertImg(auctionDtlImgDto);
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
	
	public List<AuctionDtlImgDto> selectImgs(AuctionDto auctionDto) {
		return auctionDao.selectImgs(auctionDto);
	}
	
	public AuctionDto select(AuctionDto auctionDto) {
		return auctionDao.select(auctionDto);
	}
	
	@Transactional("txFront")
	public boolean insert(AuctionDto auctionDto, FileDto[] fileDto) {
		
		int result		= 0;
		int imgResult	= 0;
		
		auctionDto.setSeq_act(auctionDao.sequence());
		
		result += auctionDao.insert(auctionDto);
		
		AuctionDtlImgDto auctionDtlImgDto = new AuctionDtlImgDto();
		
		for (int loop = 1; loop < fileDto.length; loop++) {
			if (fileDto[loop].getFileSize() > 0) {
				
				auctionDtlImgDto.setSeq_act_img(auctionDao.detailSequence());
				auctionDtlImgDto.setSeq_act(auctionDto.getSeq_act());
				auctionDtlImgDto.setImg(fileDto[loop].getFileNameSave());
				auctionDtlImgDto.setRegister(auctionDto.getRegister());
				
				result += auctionDao.insertImg(auctionDtlImgDto);
				imgResult++;
			}
		}
		
		if (result == imgResult + 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
}
