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
 * File			: SaleDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241004164452][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sale.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.seller.common.dao.BaseDao;
import kr.co.challengefarm.seller.common.dto.PagingDto;
import kr.co.challengefarm.seller.sale.dto.SaleDtlImgDto;
import kr.co.challengefarm.seller.sale.dto.SaleDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-04
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.seller.sale.dao.SaleDao")
public class SaleDao extends BaseDao {

	public int deleteInfoImg(SaleDtlImgDto saleDtlImgDto) {
		return sqlSessionSeller.delete("kr.co.challengefarm.seller.mybatis.sale.Sale.deleteInfoImg", saleDtlImgDto);
	}
	
	public int deleteDtlImg(SaleDtlImgDto saleDtlImgDto) {
		return sqlSessionSeller.delete("kr.co.challengefarm.seller.mybatis.sale.Sale.deleteDtlImg", saleDtlImgDto);
	}
	
	public int update(SaleDto saleDto) {
		return sqlSessionSeller.update("kr.co.challengefarm.seller.mybatis.sale.Sale.update", saleDto);
	}
	
	public List<SaleDtlImgDto> selectImg(SaleDtlImgDto saleDtlImgDto) {
		return sqlSessionSeller.selectList("kr.co.challengefarm.seller.mybatis.sale.Sale.selectImg", saleDtlImgDto);
	}
	
	public SaleDto select(SaleDto saleDto) {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sale.Sale.select", saleDto);
	}
	
	public int detailSequence() {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sale.Sale.detailSequence");
	}

	public int insertImg(SaleDtlImgDto saleDtlImgDto) {
		return sqlSessionSeller.insert("kr.co.challengefarm.seller.mybatis.sale.Sale.insertImg", saleDtlImgDto);
	}
	
	public int sequence() {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sale.Sale.sequence");
	}
	
	public int insert(SaleDto saleDto) {
		return sqlSessionSeller.insert("kr.co.challengefarm.seller.mybatis.sale.Sale.insert", saleDto);
	}
	
	public int count(PagingDto pagingDto) {
		return sqlSessionSeller.selectOne("kr.co.challengefarm.seller.mybatis.sale.Sale.count", pagingDto);
	}
	
	public List<SaleDto> list(PagingDto pagingDto) {
		
		return sqlSessionSeller.selectList("kr.co.challengefarm.seller.mybatis.sale.Sale.list", pagingDto);
	}
}
