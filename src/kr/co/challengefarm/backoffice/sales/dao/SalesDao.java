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
 * File			: SalesDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241111113744][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.sales.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.backoffice.common.dao.BaseDao;
import kr.co.challengefarm.backoffice.common.dto.PagingDto;
import kr.co.challengefarm.backoffice.sales.dto.SalesDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-11-11
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.backoffice.sales.dao.SalesDao")
public class SalesDao extends BaseDao {

	public List<SalesDto> detailList(SalesDto salesDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.sales.Sales.detailList", salesDto);
	}
	
	public List<SalesDto> select(SalesDto salesDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.sales.Sales.select", salesDto);
	}
	
	public List<SalesDto> list(PagingDto pagingDto) {
		return sqlSessionBackoffice.selectList("kr.co.challengefarm.backoffice.mybatis.sales.Sales.list", pagingDto);
	}
	
	public int count(PagingDto pagingDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.sales.Sales.count", pagingDto);
	}
}
