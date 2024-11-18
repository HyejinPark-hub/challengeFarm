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
 * File			: SellerDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241002101316][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sellers.dao;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.seller.common.dao.BaseDao;
import kr.co.challengefarm.seller.sellers.dto.SellerDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-02
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.seller.sellers.dao")
public class SellerDao extends BaseDao {

	public int changePasswd(SellerDto sellerDto) {
		return sqlSessionSeller.update("kr.co.challengefarm.seller.mybatis.sellers.Seller.changePasswd", sellerDto);
	}
	
	public int findPasswd(SellerDto sellerDto) {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sellers.Seller.findPasswd", sellerDto);
	}
	
	public SellerDto findId(SellerDto sellerDto) {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sellers.Seller.findId", sellerDto);
	}
	
	public int sequence() {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sellers.Seller.sequence");
	}
	
	public int selectPhone(SellerDto sellerDto) {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sellers.Seller.selectPhone", sellerDto);
	}
	
	public int selectDuplicate(SellerDto sellerDto) {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sellers.Seller.selectDuplicate", sellerDto);
	}
	
	public int insert(SellerDto sellerDto) {
		return sqlSessionSeller.insert("kr.co.challengefarm.seller.mybatis.sellers.Seller.insert", sellerDto);
	}
	
	public int update(SellerDto sellerDto) {
		return sqlSessionSeller.update("kr.co.challengefarm.seller.mybatis.sellers.Seller.update", sellerDto);
	}
	
	public int updateState(SellerDto sellerDto) {
		return sqlSessionSeller.update("kr.co.challengefarm.seller.mybatis.sellers.Seller.updateState", sellerDto);
	}
	
	public int deleteState(SellerDto sellerDto) {
		return sqlSessionSeller.update("kr.co.challengefarm.seller.mybatis.sellers.Seller.deleteState", sellerDto);
	}
	
	public SellerDto select(SellerDto sellerDto) {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sellers.Seller.select", sellerDto);
	}
	
	public SellerDto selectPasswd(SellerDto sellerDto) {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sellers.Seller.selectPasswd", sellerDto);
	}
	
	public int updatePasswd(SellerDto sellerDto) {
		return sqlSessionSeller.update("kr.co.challengefarm.seller.mybatis.sellers.Seller.updatePasswd", sellerDto);
	}
	
	
}
