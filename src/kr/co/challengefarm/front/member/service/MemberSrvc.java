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
 *				: [20240625105426][one4027one#himedia.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.member.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.challengefarm.front.member.dao.MemberDao;
import kr.co.challengefarm.front.member.dao.StatisticMemberDao;
import kr.co.challengefarm.front.member.dao.TermAgreeDao;
import kr.co.challengefarm.front.member.dto.MemberDto;
import kr.co.challengefarm.front.member.dto.StatisticMemberDto;
import kr.co.challengefarm.front.member.dto.TermAgreeDto;

/**
 * @version 1.0.0
 * @author one4027one#himedia.co.kr
 * 
 * @since 2024-08-01
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Service("kr.co.challengefarm.front.member.controller.service.MemberSrvc")
public class MemberSrvc {
	
	@Inject
	MemberDao memberDao;
	
	@Inject
	TermAgreeDao termAgreeDao;
	
	@Inject
	StatisticMemberDao statisticMemberDao;

	@Transactional("txFront")
	public boolean changePasswd(MemberDto memberDto) {
		
		if (memberDao.changePasswd(memberDto) == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	public int findPasswd(MemberDto memberDto) {
		return memberDao.findPasswd(memberDto);
	}
	
	public MemberDto findId(MemberDto memberDto) {
		return memberDao.findId(memberDto);
	}
	
	public int selectPhone(MemberDto memberDto) {
		return memberDao.selectPhone(memberDto);
	}
	
	public int selectDuplicate(MemberDto memberDto) {
		return memberDao.selectDuplicate(memberDto);
	}
	
	@Transactional("txFront")
	public boolean insert(MemberDto memberDto, String[] arrTermAgreement, String post) {
		
		int result = 0;
		
		// 신규 회원 번호(seq_mbr)
		memberDto.setSeq_mbr(memberDao.sequence());
		memberDto.setRegister(memberDto.getSeq_mbr());
		
		// 회원 정보
		result += memberDao.insert(memberDto);
		
		// 약관 정보
		TermAgreeDto termAgreeDto = new TermAgreeDto();
			
		for (int loop = 0; loop < 3; loop++) {
			
			termAgreeDto.setSeq_trm_agr(termAgreeDao.sequence());
			termAgreeDto.setSeq_mbr(memberDto.getSeq_mbr());
			termAgreeDto.setSeq_trm(loop + 1);
			termAgreeDto.setFlg_agr(arrTermAgreement[loop]);
			termAgreeDto.setRegister(memberDto.getSeq_mbr());
			
			result += termAgreeDao.insert(termAgreeDto);
		}
		
		// 통계 정보
		// [2024-08-13][pluto@himedia.co.kir][TODO: 추후 통계 정보가 확장될 경우 로직 개선필요]
		StatisticMemberDto statisticMemberDto = new StatisticMemberDto();
		statisticMemberDto.setSeq_mbr(memberDto.getSeq_mbr());
		statisticMemberDto.setPost(post);
		result += statisticMemberDao.insert(statisticMemberDto);
		
		// 회원(2개) + 약관(3개) + 통계(1개)
		if (result == 1 + 3 + 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}

	@Transactional("txFront")
	public boolean update(MemberDto memberDto) {
				
		if (memberDao.update(memberDto) == 1 && memberDao.update(memberDto) == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	@Transactional("txFront")
	public boolean updateState(MemberDto memberDto) {
				
		if (memberDao.updateState(memberDto) == 1) 
			return memberDao.updateState(memberDto) == 8;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}
	
	// 회원 탈퇴시(1 -> 8)
	@Transactional("txFront")
	public int deleteState(MemberDto memberDto) {
		// 회원 상태 업데이트
		return memberDao.deleteState(memberDto); // 업데이트된 행 수 반환
	}
	
	public MemberDto select(MemberDto memberDto) {
		return memberDao.select(memberDto);
	}
	
	public MemberDto selectPasswd(MemberDto memberDto) {
		return memberDao.selectPasswd(memberDto);
	}
	
	@Transactional("txFront")
	public boolean updatePasswd(MemberDto memberDto) {
		
		int result = memberDao.updatePasswd(memberDto);
		
		if (result == 1) return true;
		else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return false;
		}
	}

	public boolean checkPassword(int seq_mbr, String confirmPasswd) {
		return false;
	}

}