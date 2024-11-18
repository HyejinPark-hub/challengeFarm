<%
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
 * Program		: kr.co.challengefarm
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			:
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20241018120000][dhtjgml87@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>

				<script>
					function goGNBList(value) {
						$("#gnb_cd_ctg").val(value);
						
						$("#frmList").attr("action", "/front/sale/list.web");
						$("#frmList").submit();
						
					}
				</script>
				<form name="frmList" id="frmList" method="post">
					<input type="hidden" name="gnb_cd_ctg" id="gnb_cd_ctg">
				</form>
			
				<ul>
					<li><a href="/front/about.web">소개</a></li>
					<li>
						<a href="javascript:goGNBList('1')">여성</a>
						<ul class="dropdown">
							<li><a href="javascript:goGNBList('11')">아우터</a></li>
							<li><a href="javascript:goGNBList('12')">재킷/베스트</a></li>
							<li><a href="javascript:goGNBList('13')">상의</a></li>
							<li><a href="javascript:goGNBList('14')">하의</a></li>
							<li><a href="javascript:goGNBList('15')">원피스</a></li>
							<li><a href="javascript:goGNBList('16')">패션잡화</a></li>
						</ul>
					</li>
					<li>
						<a href="javascript:goGNBList('2')">남성</a>
						<ul class="dropdown">
							<li><a href="javascript:goGNBList('21')">아우터</a></li>
							<li><a href="javascript:goGNBList('22')">재킷/베스트</a></li>
							<li><a href="javascript:goGNBList('23')">상의</a></li>
							<li><a href="javascript:goGNBList('24')">하의</a></li>
							<li><a href="javascript:goGNBList('26')">패션잡화</a></li>
						</ul>
					</li>
					<li>
						<a href="/front/auction/list.web">경매</a>
					</li>
					<li class="gnb mo">
						<a href="/front/mypage/">마이페이지</a>
						<ul class="nice-scroll">
							<li><a href="/front/mypage/myInfo.web">내 정보</a></li>
							<li><a href="/front/mypage/auction/myList.web">등록한 경매</a></li>
							<li><a href="/front/mypage/auction/joinList.web">참여한 경매</a></li>
							<li><a href="/front/mypage/buyList.web">구매 상품</a></li>
							<li><a href="/front/mypage/heartList.web">찜한 상품</a></li>
							<li><a href="/front/mypage/review/list.web">리뷰 관리</a></li>
							<li><a href="/front/center/board/question/list.web">문의 내역</a></li>
						</ul>
					</li>
					<li class="gnb mo">
						<a href="/front/basket/">장바구니</a>
					</li>
					<li>
						<a href="/front/center/board.web">게시판</a>
					</li>
				</ul>
	