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
 *				: [20241107174014][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.auction.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.backoffice.auction.dto.AuctionDtlImgDto;
import kr.co.challengefarm.backoffice.auction.dto.AuctionDto;
import kr.co.challengefarm.backoffice.common.dao.BaseDao;
import kr.co.challengefarm.backoffice.common.dto.PagingDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-11-07
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.backoffice.auction.dao.AuctionDao")
public class AuctionDao extends BaseDao {

	public int update(AuctionDto auctionDto) {
		return sqlSessionBackoffice.update("kr.co.challengefarm.backoffice.mybatis.auction.Auction.update", auctionDto);
	}
	
	public List<AuctionDtlImgDto> selectImg(AuctionDto auctionDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.auction.Auction.selectImg", auctionDto);
	}
	
	public AuctionDto select(AuctionDto auctionDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.auction.Auction.select", auctionDto);
	}
	
	public List<AuctionDto> list(PagingDto pagingDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.auction.Auction.list", pagingDto);
	}
	
	public int count(PagingDto pagingDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.auction.Auction.count", pagingDto);
	}
}
