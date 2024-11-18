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
 * File			: MemberSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241002101341][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.users.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.backoffice.users.dao.MemberListDao;
import kr.co.challengefarm.backoffice.users.dto.MemberListDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-02
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.backoffice.users.service.memberListSrvc")
public class MemberListSrvc {

	@Inject
	MemberListDao memberListDao;

	public MemberListDto select(MemberListDto memberListDto) {
		return memberListDao.select(memberListDto);
	}
	
	public List<MemberListDto> list() {
		return memberListDao.selectAll();
	}
	
	public List<MemberListDto> list_cancel() {
		return memberListDao.selectAll_cancel();
	}

	@Transactional("txBackoffice")
	public boolean update(MemberListDto memberListDto) {
		
		int result = memberListDao.update(memberListDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
}
