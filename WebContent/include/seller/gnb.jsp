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
 *				: [20240627120000][pluto@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
	<ul>
		<li class="gnb mo">
			<a href="/seller/mypage/">마이페이지</a>
			<ul class="dropdown">
				<li><a href="/seller/mypage/myInfo.web" class="menu-item" id="myInfo">내 정보</a></li>
				<li><a href="javascript:alert('추후 개발 예정');">매출관리</a></li>
				<li><a href="javascript:alert('추후 개발 예정');">주문관리</a></li>
				<li><a href="javascript:alert('추후 개발 예정');">상품관리</a></li>
				<li><a href="/seller/mypage/review/list.web" class="menu-item" id="reviewList">리뷰 관리</a></li>
			</ul>
		</li>
	</ul>