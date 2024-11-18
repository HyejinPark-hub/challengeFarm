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
 * History		: [NO][Programmer][lnb_마이페이지]
 *				: [20241002120000][kalguksu7022@gmail.com][CREATE: 권용신]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-lg-3 pc">
	<div class="shop__sidebar">
		<div class="shop__sidebar__accordion">
			<div class="accordion" id="accordionExample">
				<div class="card">
					<div id="collapseOne" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__categories">
								<ul class="nice-scroll">
									<li><a href="/seller/mypage/myInfo.web" class="menu-item" id="myInfo">내 정보</a></li>
									<li><a href="/seller/sale/list.web" class="menu-item" id="saleList">상품관리</a></li>
									<li><a href="/seller/mypage/sales/list.web" class="menu-item" id="saleManage">매출관리</a></li>
									<li><a href="/seller/center/board.web" class="menu-item" id="board">게시판</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	var currentPage = "${currentPage}";
	document.getElementById(currentPage).classList.add('active');
</script>