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
	<nav class="navbar navbar-default top-navbar" role="navigation">
		<div class="navbar-header">
			<c:if test="${not empty sessionScope.SEQ_MNG}">
			<button type="button" class="navbar-toggle waves-effect waves-dark" data-toggle="collapse" data-target=".sidebar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			</c:if>
			<a class="navbar-brand waves-effect waves-dark" href="/console/index.web" style="background:#f44336 url(/img/logo/black.png) no-repeat left center / 75%;"></a>
			<c:if test="${not empty sessionScope.SEQ_MNG}">
			<div id="sideNav">
				<i class="material-icons dp48">toc</i>
			</div>
			</c:if>
		</div>
		
		<c:if test="${not empty sessionScope.SEQ_MNG}">
		<ul class="nav navbar-top-links navbar-right">
			<li>
				<a class="dropdown-button waves-effect waves-dark" href="#!" data-activates="dropdown1">
					<i class="fa fa-user fa-fw"></i> <b>${sessionScope.NAME}</b> <i class="material-icons right">arrow_drop_down</i>
				</a>
			</li>
		</ul>
		</c:if>
	</nav>
	<ul id="dropdown1" class="dropdown-content">
		<li><a href="/console/manager/modifyForm.web"><i class="fa fa-user fa-fw"></i> My Profile</a></li>
		<li><a href="/console/login/logout.web"><i class="fa fa-sign-out fa-fw"></i> Logout</a></li>
	</ul>