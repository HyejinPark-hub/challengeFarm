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
 * File			: QuestionListDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241106182444][hyebongssss@gmail.co.kr][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.mypage.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.front.center.dto.BoardDto;
import kr.co.challengefarm.front.center.dto.BoardFileDto;
import kr.co.challengefarm.front.common.dao.BaseDao;
import kr.co.challengefarm.front.common.dto.PagingDto;
import kr.co.challengefarm.front.mypage.dto.QuestionListDto;

/**
 * @version 1.0.0
 * @author hyebongssss@gmail.co.kr
 * 
 * @since 2024-11-06
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.front.mypage.dao.QuestionListDao")
public class QuestionListDao extends BaseDao {
	
	public int deleteFlag(BoardDto boardDto) {
		return sqlSessionFront.update("kr.co.challengefarm.front.mybatis.mypage.QuestionList.deleteFlag", boardDto);
	}
	
	public int update(BoardDto boardDto) {
		return sqlSessionFront.update("kr.co.challengefarm.front.mybatis.mypage.QuestionList.update", boardDto);
	}
	
	public BoardDto select(BoardDto boardDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.QuestionList.select", boardDto);
	}
	
	public List<BoardFileDto> selectFile(BoardFileDto boardFileDto) {
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.mypage.QuestionList.selectFile", boardFileDto);
	}
	
	public BoardDto selectReply(BoardDto boardDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.QuestionList.selectReply", boardDto);
	}
	
	public int count(PagingDto pagingDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.mypage.QuestionList.count", pagingDto);
	}
	
	public List<QuestionListDto> list(PagingDto pagingDto) {
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.mypage.QuestionList.list", pagingDto);
	}

}
