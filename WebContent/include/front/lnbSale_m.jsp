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
 * History		: [NO][Programmer][lnb_남성 카테고리]
 *				: [20241002120000][kalguksu7022@gmail.com][CREATE: 권용신]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-lg-3">
	<div class="shop__sidebar">
		
		<div class="shop__sidebar__search">
			<form action="#">
				<input type="text" placeholder="Search...">
				<button type="submit">
					<span class="icon_search"></span>
				</button>
			</form>
		</div>
		
		<div class="shop__sidebar__accordion">
			<div class="accordion" id="accordionExample">
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseOne">카테고리</a>
					</div>
					<div id="collapseOne" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__categories">
								<ul class="nice-scroll">
									<li><a href="#">아우터</a></li>
									<li><a href="#">재킷/베스트</a></li>
									<li><a href="#">상의</a></li>
									<li><a href="#">하의</a></li>
									<li><a href="#">패션잡화</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseTwo">브랜드</a>
					</div>
					<div id="collapseTwo" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__brand">
								<ul>
									<li><a href="#">빈폴</a></li>
									<li><a href="#">에잇세컨즈</a></li>
									<li><a href="#">라코스테</a></li>
									<li><a href="#">리바이스</a></li>
									<li><a href="#">꼼데가르송</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseThree">가격</a>
					</div>
					<div id="collapseThree" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__price">
								<ul>
									<li><a href="#">₩0 - ₩25,000</a></li>
									<li><a href="#">₩25,000 - ₩50,000</a></li>
									<li><a href="#">₩50,000 - ₩100,000</a></li>
									<li><a href="#">₩100,000 - ₩150,000</a></li>
									<li><a href="#">₩150,000 - ₩300.000</a></li>
									<li><a href="#">₩300,000+</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseFour">사이즈</a>
					</div>
					<div id="collapseFour" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__size">
								<label for="xs">xs <input type="radio" id="xs">
								</label> <label for="sm">s <input type="radio" id="sm">
								</label> <label for="md">m <input type="radio" id="md">
								</label> <label for="xl">xl <input type="radio" id="xl">
								</label> <label for="2xl">2xl <input type="radio" id="2xl">
								</label> <label for="xxl">xxl <input type="radio" id="xxl">
								</label> <label for="3xl">3xl <input type="radio" id="3xl">
								</label> <label for="4xl">4xl <input type="radio" id="4xl">
								</label>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseFive">색상</a>
					</div>
					<div id="collapseFive" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__color">
								<label class="c-1" for="sp-1"> <input type="radio"
									id="sp-1">
								</label> <label class="c-2" for="sp-2"> <input type="radio"
									id="sp-2">
								</label> <label class="c-3" for="sp-3"> <input type="radio"
									id="sp-3">
								</label> <label class="c-4" for="sp-4"> <input type="radio"
									id="sp-4">
								</label> <label class="c-5" for="sp-5"> <input type="radio"
									id="sp-5">
								</label> <label class="c-6" for="sp-6"> <input type="radio"
									id="sp-6">
								</label> <label class="c-7" for="sp-7"> <input type="radio"
									id="sp-7">
								</label> <label class="c-8" for="sp-8"> <input type="radio"
									id="sp-8">
								</label> <label class="c-9" for="sp-9"> <input type="radio"
									id="sp-9">
								</label>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card">
					<div class="card-heading">
						<a data-toggle="collapse" data-target="#collapseSix">태그</a>
					</div>
					<div id="collapseSix" class="collapse show"
						data-parent="#accordionExample">
						<div class="card-body">
							<div class="shop__sidebar__tags">
								<a href="#">상품</a> 
								<a href="#">상의</a> 
								<a href="#">하의</a> 
								<a href="#">패션잡화</a>
							</div>
						</div> 
					</div>
				</div>
			
			</div>
		</div>
	</div>
</div>