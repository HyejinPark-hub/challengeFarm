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
 * File			: MyInfoDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241001144235][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.challengefarm.front.common.dao.BaseDao;
import kr.co.challengefarm.front.mypage.dto.MyInfoDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-01
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.front.mypage.dao.MyInfoDao")
public class MyInfoDao extends BaseDao {
	
	@Autowired // @Inject 대신 @Autowired 사용
	private SqlSession sqlSessionFront;
	
	public MyInfoDto select(MyInfoDto myInfoDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.MyInfo.select", myInfoDto);
	}
		
}