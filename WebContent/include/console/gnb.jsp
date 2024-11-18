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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar-default navbar-side" role="navigation">
	<div class="sidebar-collapse">
		<ul class="nav" id="main-menu">
			<li><a href="/console/" class="waves-effect waves-dark" id="home"><i class="fa fa-dashboard"></i>홈</a></li>
			<li><a href="/console/sales/list.web" class="waves-effect waves-dark" id="salesList"><i class="fa fa-desktop"></i>매출</a></li>
			<li><a href="/console/sale/list.web" class="waves-effect waves-dark" id="saleList"><i class="fa fa-qrcode"></i>상품</a></li>
			<li><a href="/console/auction/list.web" class="waves-effect waves-dark" id="auctionList"><i class="fa fa-qrcode"></i>경매</a></li>
			<li><a href="#" class="waves-effect waves-dark" id="board"><i class="fa fa-qrcode"></i>게시판<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
						<li>
							<a href="/console/center/board.web">공지사항</a>
						</li>
						<li>
							<a href="/console/center/board/faq/list.web">FAQ</a>
						</li>
						<li>
							<a href="/console/center/board/question/list.web">고객문의</a>
						</li>
					</ul>
			</li>
			<li>
				<a href="#" class="waves-effect waves-dark" id="usersList"><i class="fa fa-sitemap"></i>회원<span class="fa arrow"></span></a>
				<ul class="nav nav-second-level">
					<li>
						<a href="#">구매자<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="/console/users/memberList.web">가입 현황</a></li>
							<li><a href="/console/users/memberList_cancel.web">탈퇴 현황</a></li>
						</ul>
					</li>
					<li>
						<a href="#">판매자<span class="fa arrow"></span></a>
						<ul class="nav nav-third-level">
							<li><a href="/console/users/sellerList.web">가입 현황</a></li>
							<li><a href="/console/users/sellerList_cancel.web">탈퇴 현황</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li><a href="/console/users/managerList.web" class="waves-effect waves-dark" id="managerList"><i class="fa fa-edit"></i>관리자 현황</a></li>
		</ul>
	</div>
	
	<script>
		var currentPageNm = "${currentPageNm}";
		document.getElementById(currentPageNm).classList.add('active-menu');
	</script>

</nav>
	