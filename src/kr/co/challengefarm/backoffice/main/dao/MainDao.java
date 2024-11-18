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
 * File			: MainDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241024184127][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.main.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.backoffice.common.dao.BaseDao;
import kr.co.challengefarm.backoffice.sale.dto.SaleDto;
import kr.co.challengefarm.front.buy.dto.BuyDetailDto;
import kr.co.challengefarm.front.main.dto.VisitorDto;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.seller.sellers.dto.SellerDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-24
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.backoffice.main.dao.MainDao")
public class MainDao extends BaseDao {

	public List<BuyDetailDto> salesList(BuyDetailDto buyDetailDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.main.Main.salesList", buyDetailDto);
	}
	
	public List<MemberDto> outList(MemberDto memberDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.main.Main.outList", memberDto);
	}
	
	public List<MemberDto> joinList(MemberDto memberDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.main.Main.joinList", memberDto);
	}
	
	public List<VisitorDto> visitorList(VisitorDto visitorDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.main.Main.visitorList", visitorDto);
	}
	
	public List<SellerDto> saleList(SellerDto sellerDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.main.Main.saleList", sellerDto);
	}
	
	public int visit(VisitorDto visitorDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.main.Main.visit", visitorDto);
	}

	public int sale(SaleDto saleDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.main.Main.sale", saleDto);
	}
	
	public int seller(SellerDto sellerDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.main.Main.seller", sellerDto);
	}
	
	public int member(MemberDto memberDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.main.Main.member", memberDto);
	}
}
