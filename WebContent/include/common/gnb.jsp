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
		<li><a href="/front/about.web">소개</a></li>
		<li>
			<a href="javascript:goList('1')">여성</a>
			<ul class="dropdown">
				<li><a href="javascript:goList('11')">아우터</a></li>
				<li><a href="javascript:goList('12')">재킷/베스트</a></li>
				<li><a href="javascript:goList('13')">상의</a></li>
				<li><a href="javascript:goList('14')">하의</a></li>
				<li><a href="javascript:goList('15')">원피스</a></li>
				<li><a href="javascript:goList('16')">패션잡화</a></li>
			</ul>
		</li>
		<li>
			<a href="javascript:goList('2')">남성</a>
			<ul class="dropdown">
				<li><a href="javascript:goList('21')">아우터</a></li>
				<li><a href="javascript:goList('22')">재킷/베스트</a></li>
				<li><a href="javascript:goList('23')">상의</a></li>
				<li><a href="javascript:goList('24')">하의</a></li>
				<li><a href="javascript:goList('26')">패션잡화</a></li>
			</ul>
		</li>
		<li>
			<a href="/front/auction/list.web">경매</a>
		</li>
	</ul>