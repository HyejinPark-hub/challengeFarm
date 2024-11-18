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
 * File			: DetailsDto.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004130855][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.buy.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.front.common.dao.BaseDao;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.front.mypage.dto.ReviewDto;
import kr.co.challengefarm.front.buy.dto.BuyDetailDto;
import kr.co.challengefarm.front.buy.dto.BuyDto;
import kr.co.challengefarm.front.buy.dto.BuyImgDto;
import kr.co.challengefarm.front.buy.dto.BuyMasterDto;
import kr.co.challengefarm.front.buy.dto.DeliveryDto;


/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-10-11
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.front.buy.dao.BuyDao")
public class BuyDao extends BaseDao {

	public int update(BuyMasterDto buyMasterDto) {
		return sqlSessionFront.update("kr.co.challengefarm.front.mybatis.buy.BuyMaster.update", buyMasterDto);
	}
	
	public int delivery(DeliveryDto deliveryDto) {
		return sqlSessionFront.insert("kr.co.challengefarm.front.mybatis.buy.Delivery.insert", deliveryDto);
	}
	
	public int sequenceDelivery() {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.buy.Delivery.sequence");
	}
	
	public int sequenceMaster() {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.buy.BuyMaster.sequence");
	}
	
	public int sequenceDetail() {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.buy.BuyDetail.sequence");
	}
	
	public int insertMaster(BuyMasterDto buyMasterDto) {
		return sqlSessionFront.insert("kr.co.challengefarm.front.mybatis.buy.BuyMaster.insert", buyMasterDto);
	}
	
	public int insertDetail(BuyDetailDto buyDetailDto) {
		return sqlSessionFront.insert("kr.co.challengefarm.front.mybatis.buy.BuyDetail.insert", buyDetailDto);
	}
	
	public MemberDto info(BuyDto buyDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.buy.Buy.info", buyDto);
	}
	
	public BuyDto select(BuyDto buyDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.buy.Buy.select", buyDto);
	}

	public List<BuyImgDto> selectImg(BuyImgDto buyImgDto) {
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.buy.Buy.selectImg", buyImgDto);
	}

	public int count(PagingDto pagingDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.buy.Buy.count", pagingDto);
	}

	public List<ReviewDto> reviewlist(PagingDto pagingDto) {
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.buy.Buy.reviewlist", pagingDto);
	}
}
