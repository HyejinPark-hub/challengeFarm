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
 * History		: [NO][Programmer][lnb_경매]
 *				: [20241004120000][kalguksu7022@gmail.com][CREATE: 권용신]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<div class="col-lg-3">
	<div class="shop__sidebar">
		<div class="shop__sidebar__search">
			<form action="/front/auction/list.web">
				<input type="text" placeholder="Search..." name="searchWord" id="searchWord">
				<button type="submit">
					<span class="icon_search"></span>
				</button>
			</form>
		</div>
		<div class="shop__sidebar__accordion">
			<div class="accordion" id="accordionExample">
					
					<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseThree">경매 시작 가격</a>
					</div>
					<div id="collapseOne" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__price">
								<ul>
									<li><a href="javascript:goPriceList('1')">₩0 - ₩50,000</a></li>
									<li><a href="javascript:goPriceList('2')">₩50,000 - ₩150,000</a></li>
									<li><a href="javascript:goPriceList('3')">₩150,000 - ₩300,000</a></li>
									<li><a href="javascript:goPriceList('4')">₩300,000 - ₩500,000</a></li>
									<li><a href="javascript:goPriceList('5')">₩500,000 - ₩800,000</a></li>
									<li><a href="javascript:goPriceList('6')">₩800,000+</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseOne">경매 상품 구매년도</a>
					</div>
					<div id="collapseTwo" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__categories">
								<ul class="nice-scroll">
									<li><a href="javascript:goBuyYearList('2024')">2024년</a></li>
									<li><a href="javascript:goBuyYearList('2023')">2023년</a></li>
									<li><a href="javascript:goBuyYearList('2022')">2022년</a></li>
									<li><a href="javascript:goBuyYearList('2021')">2021년</a></li>
									<li><a href="javascript:goBuyYearList('2020')">2020년</a></li>
									<li><a href="javascript:goBuyYearList('2019')">2019년 이전</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>			
			
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseOne">경매 상품 상태</a>
					</div>
					<div id="collapseThree" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__categories">
								<ul class="nice-scroll">
									<li><a href="javascript:goActStateList('1')">최상</a></li>
									<li><a href="javascript:goActStateList('2')">상</a></li>
									<li><a href="javascript:goActStateList('3')">중</a></li>
									<li><a href="javascript:goActStateList('4')">하</a></li>
									<li><a href="javascript:goActStateList('5')">최하</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
												
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseSix">낙찰여부</a>
					</div>
					<div id="collapseFour" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__tags">
								<a href="javascript:goSuccessList('')">낙찰전</a> 
								<a href="javascript:goSuccessList('Y')">낙찰</a> 
								<a href="javascript:goSuccessList('N')">유찰</a> 
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>
