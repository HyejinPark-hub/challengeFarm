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
 * Program		: kr.co.himedia.ecommerce
 * Description	:
 * Environment	: JRE 1.7 or more
 * File			:
 * Notes		:
 * History		: [NO][Programmer][Description]
 *				: [20240726150000][pluto@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<ul style="text-align-last: center; padding-bottom: 40px;">
				<li style="display: inline; margin: 0 10px;"><a href="javascript:goList(1);" style="color: gray; font-size: 18px;<c:if test="${paging.cd_bbs_type == 1}"> color: black; font-weight: bold;</c:if>">공지사항</a></li>
				<li style="display: inline; margin: 0 10px;"><a href="javascript:goList(5);" style="color: gray; font-size: 18px;<c:if test="${paging.cd_bbs_type == 5}"> color: black; font-weight: bold;</c:if>">자주 찾는 질문(FAQ)</a></li>
				<li style="display: inline; margin: 0 10px;"><a href="javascript:goList(6);" style="color: gray; font-size: 18px;<c:if test="${paging.cd_bbs_type == 6}"> color: black; font-weight: bold;</c:if>">고객 문의</a></li>
			</ul>