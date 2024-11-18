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
 * File			: SellerSrvc.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241002101341][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.seller.sellers.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.seller.sellers.dao.SellerDao;
import kr.co.challengefarm.seller.sellers.dto.SellerDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-02
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.seller.sellers.service")
public class SellerSrvc {

	@Inject
	SellerDao sellerDao;

	@Transactional("txSeller")
	public boolean changePasswd(SellerDto sellerDto) {
		if (sellerDao.changePasswd(sellerDto) == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	public int findPasswd(SellerDto sellerDto) {
		return sellerDao.findPasswd(sellerDto);
	}
	
	public SellerDto findId(SellerDto sellerDto) {
		return sellerDao.findId(sellerDto);
	}
	
	public int selectPhone(SellerDto sellerDto) {
		return sellerDao.selectPhone(sellerDto);
	}
	
	public int selectDuplicate(SellerDto sellerDto) {
		return sellerDao.selectDuplicate(sellerDto);
	}
	
	public boolean insert(SellerDto sellerDto) {

		// 신규 판매자 번호(seq_sll)
		sellerDto.setSeq_sll(sellerDao.sequence());
		sellerDto.setRegister(sellerDto.getSeq_sll());
		
		if (sellerDao.insert(sellerDto) == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	@Transactional("txFront")
	public boolean update(SellerDto sellerDto) {
				
		if (sellerDao.update(sellerDto) == 1 && sellerDao.update(sellerDto) == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	// 회원 탈퇴시(1 -> 8)
	@Transactional("txFront")
	public int deleteState(SellerDto sellerDto) {
		// 회원 상태 업데이트
		return sellerDao.deleteState(sellerDto); // 업데이트된 행 수 반환
	}
	
	public SellerDto select(SellerDto sellerDto) {
		return sellerDao.select(sellerDto);
	}
	
	public SellerDto selectPasswd(SellerDto sellerDto) {
		return sellerDao.selectPasswd(sellerDto);
	}
	
	@Transactional("txFront")
	public boolean updatePasswd(SellerDto sellerDto) {
		
		int result = sellerDao.updatePasswd(sellerDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	
	
}
