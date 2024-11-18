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
 *				: [20241030115901][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.auction.service;

import java.util.List;
import java.util.Properties;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.front.auction.dao.AuctionDao;
import kr.co.challengefarm.front.auction.dto.AuctionDtlImgDto;
import kr.co.challengefarm.front.auction.dto.AuctionDto;
import kr.co.challengefarm.front.auction.dto.BidDto;
import kr.co.challengefarm.front.auction.dto.ChatDto;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.common.dto.PagingListDto;
import kr.co.challengefarm.util.security.SKwithAES;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-30
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.front.auction.service.AuctionSrvc")
public class AuctionSrvc {

	@Autowired
	Properties staticProperties;
	
	@Inject
	AuctionDao auctionDao;

	public List<ChatDto> list(ChatDto chatDto) {
		return auctionDao.list(chatDto);
	}
	
	@Transactional("txFront")
	public boolean insertChat(ChatDto chatDto) {
		int result = 0;
		
		chatDto.setSeq_act_cht(auctionDao.chatSequence());
		
		result = auctionDao.insertChat(chatDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	@Transactional("txFront")
	public boolean giveUp(BidDto bidDto) {
		int result = 0;

		bidDto.setUpdater(bidDto.getSeq_mbr());
		result = auctionDao.giveUp(bidDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	@Transactional("txFront")
	public boolean update(BidDto bidDto) {
		int result = 0;
		
		if (bidDto.getProcess().equals("rebid")) {
			bidDto.setFlg_giveup("N");
		}
		bidDto.setUpdater(bidDto.getSeq_mbr());
		result = auctionDao.update(bidDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	@Transactional("txFront")
	public boolean insert(BidDto bidDto) {
		int result = 0;
		
		bidDto.setSeq_bid(auctionDao.sequence());
		bidDto.setRegister(bidDto.getSeq_mbr());
		
		result = auctionDao.insert(bidDto);
		
		if (result == 1) return true;
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
		
		List<AuctionDto> actionList = auctionDao.list(pagingDto);
		
		String staticKey	= staticProperties.getProperty("front.enc.user.aes256.key", "[UNDEFINED]");
		SKwithAES aes		= new SKwithAES(staticKey);
		
		String seller = "";
		
		for (int loop = 0; loop < actionList.size(); loop++) {
		
			try {
				seller	= aes.decode(actionList.get(loop).getSeller());
			} catch (Exception e) {
				e.printStackTrace();
			}
			actionList.get(loop).setSeller(seller);
		}
		
		pagingListDto.setList(actionList);
		
		return pagingListDto;
	}
}
