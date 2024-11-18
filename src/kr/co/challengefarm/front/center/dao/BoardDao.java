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
 * File			: BaordDao.java
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241014121401][kogr0131#gmail.com][CREATE: Initial Release]
 */
package kr.co.challengefarm.front.center.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.challengefarm.front.center.dto.BoardDto;
import kr.co.challengefarm.front.center.dto.BoardFileDto;
import kr.co.challengefarm.front.common.dao.BaseDao;
import kr.co.challengefarm.front.common.dto.PagingDto;

/**
 * @version 1.0.0
 * @author kogr0131#gmail.com
 * 
 * @since 2024-10-14
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
@Repository("kr.co.challengefarm.front.center.dao.BoardDao")
public class BoardDao extends BaseDao {
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return BoardDto
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 보기(답변)</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public BoardDto selectReply(BoardDto boardDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.center.Board.selectReply", boardDto);
	}
	
	public int count(PagingDto pagingDto) {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.center.Board.count", pagingDto);
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return int
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 삭제</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public int delete(BoardDto boardDto) {
		return sqlSessionFront.delete("kr.co.challengefarm.front.mybatis.center.Board.delete", boardDto);
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return int
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 등록</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public int insert(BoardDto boardDto) {
		return sqlSessionFront.insert("kr.co.challengefarm.front.mybatis.center.Board.insert", boardDto);
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return BoardDto
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 삭제(처리)</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public int deleteFlag(BoardDto boardDto) {
		return sqlSessionFront.update("kr.co.challengefarm.front.mybatis.center.Board.deleteFlag", boardDto);
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return int
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 수정</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public int update(BoardDto boardDto) {
		return sqlSessionFront.update("kr.co.challengefarm.front.mybatis.center.Board.update", boardDto);
	}
	
	/**
	 * @param boardDto [게시판 빈]
	 * @return BoardDto
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 보기</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public BoardDto select(BoardDto boardDto) {
		
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.center.Board.select", boardDto);
		
		/*
		BoardDto _boardDto = null;
		
		switch (boardDto.getCd_bbs_type()) {
			case 1 :
				break;
			
			case 2 :
				break;
				
			case 3 :
				if (boardDto.getSeq_bbs() == 10) {
					_boardDto = new BoardDto();
					_boardDto.setSeq_bbs(10);
					_boardDto.setTitle("고객 문의-1");
					_boardDto.setCategory("01");
					_boardDto.setContent("내용-1");
					_boardDto.setDt_reg("2024-06-23");
				}
				else if (boardDto.getSeq_bbs() == 11){
					_boardDto = new BoardDto();
					_boardDto.setSeq_bbs(11);
					_boardDto.setTitle("고객 문의-2");
					_boardDto.setCategory("01");
					_boardDto.setContent("내용-2");
					_boardDto.setDt_reg("2024-06-24");
				}
				else if (boardDto.getSeq_bbs() == 13){
					_boardDto = new BoardDto();
					_boardDto.setSeq_bbs(13);
					_boardDto.setTitle("고객 문의-3");
					_boardDto.setCategory("05");
					_boardDto.setContent("내용-3");
					_boardDto.setDt_reg("2024-06-25");
				}
				break;
			default:
		}
		
		return _boardDto;
		*/
	}
	
	/**
	 * @param pagingDto [페이징 빈]
	 * @return List<BoardDto>
	 * 
	 * @since 2024-10-14
	 * <p>DESCRIPTION: 고객센터 목록</p>
	 * <p>IMPORTANT:</p>
	 * <p>EXAMPLE:</p>
	 */
	public List<BoardFileDto> selectFile(BoardFileDto boardFileDto) {
			
			return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.center.Board.selectFile", boardFileDto);
	}
	
	public List<BoardDto> list(PagingDto pagingDto) {
		
		return sqlSessionFront.selectList("kr.co.challengefarm.front.mybatis.center.Board.list", pagingDto);
		
		/*
		List<BoardDto> list = new ArrayList<BoardDto>();
		
		BoardDto _boardDto = null;
		
		switch (boardDto.getCd_bbs_type()) {
			case 1 :
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(1);
				_boardDto.setTitle("공지사항-1");
				_boardDto.setContent("내용-1");
				_boardDto.setDt_reg("2024-06-23");
				list.add(_boardDto);
				
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(2);
				_boardDto.setTitle("공지사항-2");
				_boardDto.setContent("내용-2");
				_boardDto.setDt_reg("2024-06-24");
				list.add(_boardDto);
				
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(3);
				_boardDto.setTitle("공지사항-3");
				_boardDto.setContent("내용-3");
				_boardDto.setDt_reg("2024-06-25");
				list.add(_boardDto);
				break;
				
			case 2 :
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(4);
				_boardDto.setTitle("FAQ-1");
				_boardDto.setContent("내용-1");
				_boardDto.setDt_reg("2024-06-23");
				list.add(_boardDto);
				
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(5);
				_boardDto.setTitle("FAQ-2");
				_boardDto.setContent("내용-2");
				_boardDto.setDt_reg("2024-06-24");
				list.add(_boardDto);
				
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(6);
				_boardDto.setTitle("FAQ-3");
				_boardDto.setContent("내용-3");
				_boardDto.setDt_reg("2024-06-25");
				list.add(_boardDto);
				
				
				break;
			case 3 :
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(10);
				_boardDto.setTitle("고객 문의-1");
				_boardDto.setContent("내용-1");
				_boardDto.setDt_reg("2024-06-23");
				list.add(_boardDto);
				
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(11);
				_boardDto.setTitle("고객 문의-2");
				_boardDto.setContent("내용-2");
				_boardDto.setDt_reg("2024-06-24");
				list.add(_boardDto);
				
				_boardDto = new BoardDto();
				_boardDto.setSeq_bbs(13);
				_boardDto.setTitle("고객 문의-3");
				_boardDto.setContent("내용-3");
				_boardDto.setDt_reg("2024-06-25");
				list.add(_boardDto);
				
				break;
			default:
		}
		
		return list;
		*/
	}
	public int readed(BoardDto boardDto) {
		return sqlSessionFront.update("kr.co.challengefarm.front.mybatis.center.Board.readed", boardDto);
	}
	
	public int sequence() {
		return sqlSessionFront.selectOne("kr.co.challengefarm.front.mybatis.center.Board.sequence");
	}

}