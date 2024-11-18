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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="header__top">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-7">
					<div class="header__top__left">
						<p>무료 배송, 30일 반품 또는 환불 보장.</p>
					</div>
				</div>
				
				
				<div class="col-lg-6 col-md-5">
					<div class="header__top__right">
						<div class="header__top__links">
							<a href="/front/login/loginForm.web">로그인</a>
							<a href="#">가입</a>
							<a href="/front/mypage/index.web">마이페이지</a>
							<%--
							<c:if test="${not empty sessionScope.SEQ_MBR}">
								<a href="#">Sign in</a>
								<a href="#">Join</a>
							</c:if>
							<c:if test="${empty sessionScope.SEQ_MBR}">
								<a href="#"><img src="/img/icon/heart.png" alt="" title="마이페이지"></a>
								<a href="#"><img src="/img/icon/cart.png" alt="" title="장바구니"> <span>0</span></a>
							</c:if>
							--%>
						</div>
						<div class="header__top__hover"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-lg-3 col-md-3">
				<div class="header__logo">
					<a href="/index.jsp"><img src="/img/logo.png" alt=""></a>
				</div>
			</div>
			<div class="col-lg-6 col-md-6">
				<nav class="header__menu mobile-menu">
					<%@ include file="/include/common/gnb.jsp" %>
				</nav>
			</div>
			<div class="col-lg-3 col-md-3">
				<div class="header__nav__option">
					<a href="#" class="search-switch"><img src="/img/icon/search.png" alt=""></a>
				</div>
			</div>
		</div>
		<div class="canvas__open"><i class="fa fa-bars"></i></div>
	</div>