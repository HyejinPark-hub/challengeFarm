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
 * History		: [NO][Programmer][lnb_여성 카테고리]
 *				: [20241002120000][kalguksu7022@gmail.com][CREATE: 권용신]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="col-lg-3">
	<div class="shop__sidebar">

		<div class="shop__sidebar__search">
			<form action="/front/sale/list.web">
				<input type="text" placeholder="Search..." name="searchWord" id="searchWord">
				<button type="submit">
					<span class="icon_search"></span>
				</button>
			</form>
		</div>
	
		<div class="shop__sidebar__accordion">
			<div class="accordion" id="accordionExample">
			
			<c:choose>
				<c:when test="${fn:startsWith(paging.cd_ctg, '1')}">
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseOne">카테고리</a>
					</div>
					<div id="collapseOne" class="collapse show" data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__categories">
								<ul class="nice-scroll">
									<li><a href="javascript:goList('11')">아우터</a></li>
									<li><a href="javascript:goList('12')">재킷/베스트</a></li>
									<li><a href="javascript:goList('13')">상의</a></li>
									<li><a href="javascript:goList('14')">하의</a></li>
									<li><a href="javascript:goList('15')">원피스</a></li>
									<li><a href="javascript:goList('16')">패션잡화</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseTwo">브랜드</a>
					</div>
					<div id="collapseTwo" class="collapse show" data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__brand">
								<ul>
									<li><a href="javascript:goBrandList('1','1')">빈폴</a></li>
									<li><a href="javascript:goBrandList('1','2')">라코스테</a></li>
									<li><a href="javascript:goBrandList('1','4')">리바이스</a></li>
									<li><a href="javascript:goBrandList('1','5')">꼼데가르송</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseThree">가격</a>
					</div>
					<div id="collapseThree" class="collapse show" data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__price">
								<ul>
									<li><a href="javascript:goPriceList('1','1')">₩0 - ₩25,000</a></li>
									<li><a href="javascript:goPriceList('1','2')">₩25,000 - ₩50,000</a></li>
									<li><a href="javascript:goPriceList('1','3')">₩50,000 - ₩100,000</a></li>
									<li><a href="javascript:goPriceList('1','4')">₩100,000 - ₩150,000</a></li>
									<li><a href="javascript:goPriceList('1','5')">₩150,000 - ₩300.000</a></li>
									<li><a href="javascript:goPriceList('1','6')">₩300,000+</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseFour">사이즈</a>
					</div>
					<div id="collapseFour" class="collapse show" data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__size">
								<label for="xs">XS <input type="radio" id="xs" name="size_nm" onclick="goSizeList('1','XS')"></label> 
								<label for="s">S <input type="radio" id="s" name="size_nm" onclick="goSizeList('1','S')"></label> 
								<label for="m">M <input type="radio" id="m" name="size_nm" onclick="goSizeList('1','M')"></label> 
								<label for="l">L <input type="radio" id="l" name="size_nm" onclick="goSizeList('1','L')"></label> 
								<label for="xl">XL <input type="radio" id="xl" name="size_nm" onclick="goSizeList('1','XL')"></label> 
								<label for="2xl">2XL <input type="radio" id="2xl" name="size_nm" onclick="goSizeList('1','2XL')"></label> 
								<label for="3xl">3XL <input type="radio" id="3xl" name="size_nm" onclick="goSizeList('1','3XL')"></label> 
								<label for="4xl">4XL <input type="radio" id="4xl" name="size_nm" onclick="goSizeList('1','4XL')"></label>
							</div>
						</div>
					</div>
				</div>
				</c:when>
				<c:otherwise>
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseOne">카테고리</a>
					</div>
					<div id="collapseOne" class="collapse show" data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__categories">
								<ul class="nice-scroll">
									<li><a href="javascript:goList('21')">아우터</a></li>
									<li><a href="javascript:goList('22')">재킷/베스트</a></li>
									<li><a href="javascript:goList('23')">상의</a></li>
									<li><a href="javascript:goList('24')">하의</a></li>
									<li><a href="javascript:goList('26')">패션잡화</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseTwo">브랜드</a>
					</div>
					<div id="collapseTwo" class="collapse show" data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__brand">
								<ul>
									<li><a href="javascript:goBrandList('2','1')">빈폴</a></li>
									<li><a href="javascript:goBrandList('2','2')">에잇세컨즈</a></li>
									<li><a href="javascript:goBrandList('2','3')">라코스테</a></li>
									<li><a href="javascript:goBrandList('2','4')">리바이스</a></li>
									<li><a href="javascript:goBrandList('2','5')">꼼데가르송</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseThree">가격</a>
					</div>
					<div id="collapseThree" class="collapse show" data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__price">
								<ul>
									<li><a href="javascript:goPriceList('2','1')">₩0 - ₩25,000</a></li>
									<li><a href="javascript:goPriceList('2','2')">₩25,000 - ₩50,000</a></li>
									<li><a href="javascript:goPriceList('2','3')">₩50,000 - ₩100,000</a></li>
									<li><a href="javascript:goPriceList('2','4')">₩100,000 - ₩150,000</a></li>
									<li><a href="javascript:goPriceList('2','5')">₩150,000 - ₩300.000</a></li>
									<li><a href="javascript:goPriceList('2','6')">₩300,000+</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseFour">사이즈</a>
					</div>
					<div id="collapseFour" class="collapse show" data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__size">
								<label for="xs">XS <input type="radio" id="xs" name="size_nm" onclick="goSizeList('2','XS')"></label> 
								<label for="s">S <input type="radio" id="s" name="size_nm" onclick="goSizeList('2','S')"></label> 
								<label for="m">M <input type="radio" id="m" name="size_nm" onclick="goSizeList('2','M')"></label> 
								<label for="l">L <input type="radio" id="l" name="size_nm" onclick="goSizeList('2','L')"></label> 
								<label for="xl">XL <input type="radio" id="xl" name="size_nm" onclick="goSizeList('2','XL')"></label> 
								<label for="2xl">2XL <input type="radio" id="2xl" name="size_nm" onclick="goSizeList('2','2XL')"></label> 
								<label for="3xl">3XL <input type="radio" id="3xl" name="size_nm" onclick="goSizeList('2','3XL')"></label> 
								<label for="4xl">4XL <input type="radio" id="4xl" name="size_nm" onclick="goSizeList('2','4XL')"></label>
							</div>
						</div>
					</div>
				</div>
				</c:otherwise>
			</c:choose>
			
			</div>
		</div>
	</div>
</div>
