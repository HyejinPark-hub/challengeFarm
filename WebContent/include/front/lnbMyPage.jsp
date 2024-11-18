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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<div class="col-lg-3 lnbMypage pc">
	<div class="shop__sidebar">
		<div class="shop__sidebar__accordion">
			<div class="accordion" id="accordionExample">
				<div class="card">
					<div id="collapseOne" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__categories">
								<ul class="nice-scroll">
									<li><a href="/front/mypage/myInfo.web" class="menu-item" id="myInfo">내 정보</a></li>
									<li><a href="/front/mypage/auction/myList.web" class="menu-item" id="myAuction">등록한 경매</a></li>
									<li><a href="/front/mypage/auction/joinList.web" class="menu-item" id="joinAuction">참여한 경매</a></li>
									<li><a href="/front/mypage/buyList.web" class="menu-item" id="buyList">구매내역</a></li>
									<li><a href="/front/mypage/heartList.web" class="menu-item" id="heartList"> 찜한상품</a></li>
									<li><a href="/front/mypage/review/list.web" class="menu-item" id="reviewList">리뷰내역</a></li>
									<li><a href="/front/mypage/question/list.web" class="menu-item" id="questionList">문의내역</a></li>
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
	var currentPageNm = "${currentPageNm}";
	document.getElementById(currentPageNm).classList.add('active');
</script>