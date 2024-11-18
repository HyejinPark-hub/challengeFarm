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
 * File			: AuctionDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241029131320][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.front.auction.dto.AuctionDtlImgDto;
import kr.co.challengefarm.front.auction.dto.AuctionDto;
import kr.co.challengefarm.front.auction.dto.BidDto;
import kr.co.challengefarm.front.common.dao.BaseDao;
import kr.co.challengefarm.front.common.dto.PagingDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-29
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.front.mypage.dao.AuctionDao")
public class AuctionDao extends BaseDao {

	public AuctionDto state(BidDto bidDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.Auction.state", bidDto);
	}
	
	public List<BidDto> listBid(BidDto bidDto) {
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.mypage.Auction.listBid", bidDto);
	}
	
	public int joinCount(PagingDto pagingDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.Auction.joinCount", pagingDto);
	}
	
	public List<AuctionDto> joinList(PagingDto pagingDto) {
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.mypage.Auction.joinList", pagingDto);
	}
	
	public int count(PagingDto pagingDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.Auction.count", pagingDto);
	}
	
	public List<AuctionDto> list(PagingDto pagingDto) {
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.mypage.Auction.list", pagingDto);
	}
	
	public int deleteDtlImg(AuctionDtlImgDto auctionDtlImgDto) {
		return sqlSessionFront.delete("kr.co.challengefarm.front.mybatis.mypage.Auction.deleteDtlImg", auctionDtlImgDto);
	}
	
	public int update(AuctionDto auctionDto) {
		return sqlSessionFront.update("kr.co.challengefarm.front.mybatis.mypage.Auction.update", auctionDto);
	}
	
	public List<AuctionDtlImgDto> selectImgs(AuctionDto auctionDto) {
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.mypage.Auction.selectImgs", auctionDto);
	}
	
	public AuctionDto select(AuctionDto auctionDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.Auction.select", auctionDto);
	}
	
	public int insertImg(AuctionDtlImgDto auctionDtlImgDto) {
		return sqlSessionFront.insert("kr.co.challengefarm.front.mybatis.mypage.Auction.insertImg", auctionDtlImgDto);
	}
	
	public int detailSequence() {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.Auction.detailSequence");
	}
	
	public int insert(AuctionDto auctionDto) {
		return sqlSessionFront.insert("kr.co.challengefarm.front.mybatis.mypage.Auction.insert", auctionDto);
	}
	
	public int sequence() {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.Auction.sequence");
	}
}
