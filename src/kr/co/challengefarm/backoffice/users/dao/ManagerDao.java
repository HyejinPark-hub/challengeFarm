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
 * File			: ManagerDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241024120602][dhtjgml87#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.backoffice.users.dao;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.backoffice.common.dao.BaseDao;
import kr.co.challengefarm.backoffice.users.dto.ManagerDto;
import kr.co.challengefarm.front.member.dto.MemberDto;

/**
 * @version 1.0.0
 * @author dhtjgml87#gmail.com
 * 
 * @since 2024-10-24
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.backoffice.users.dao.ManagerDao")
public class ManagerDao extends BaseDao {

	public int changePasswd(ManagerDto managerDto) {
		return sqlSessionBackoffice.update("kr.co.challengefarm.backoffice.mybatis.users.Manager.changePasswd", managerDto);
	}
	
	public int findPasswd(ManagerDto managerDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.users.Manager.findPasswd", managerDto);
	}
	
	public ManagerDto findId(ManagerDto managerDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.users.Manager.findId", managerDto);
	}
	
	public int selectCertification(ManagerDto managerDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.users.Manager.selectCertification", managerDto);
	}

	public int selectEmailDuplicate(ManagerDto managerDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.users.Manager.selectEmailDuplicate", managerDto);
	}
	
	public int selectIdDuplicate(ManagerDto managerDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.users.Manager.selectIdDuplicate", managerDto);
	}
	
	public int sequence() {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.users.Manager.sequence");
	}
	
	public int insert(ManagerDto managerDto) {
		return sqlSessionBackoffice.insert("kr.co.challengefarm.backoffice.mybatis.users.Manager.insert", managerDto);
	}
	
	public ManagerDto select(ManagerDto managerDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.users.Manager.select", managerDto);
	}
	
	public ManagerDto selectPasswd(ManagerDto managerDto) {
		return sqlSessionBackoffice.selectOne("kr.co.challengefarm.backoffice.mybatis.users.Manager.selectPasswd", managerDto);
	}
	
	public int updatePasswd(ManagerDto managerDto) {
		return sqlSessionBackoffice.update("kr.co.challengefarm.backoffice.mybatis.users.Manager.updatePasswd", managerDto);
	}

}
