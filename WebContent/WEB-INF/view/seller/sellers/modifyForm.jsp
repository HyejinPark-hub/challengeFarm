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
 *				: [20240626130000][dhtjgml87@himedia.co.kr][CREATE: Initial Release][TODO: 정보수정 클릭시 비밀번호 확인 후 정보 변경 가능하도록]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page info="/WEB-INF/view/seller/sellers/modifyForm.jsp"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="/include/seller/header.jsp"%>
<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/seller/sellers/modifyForm.css" />
<script type="text/javascript" src="/js/uranus/seller/sellers/modifyForm.js"></script>
<script type="text/javascript" src="/js/uranus/jquery-3.7.1.min.js"></script>
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
	<header class="header">
		<%@ include file="/include/seller/top.jsp"%>
	</header>
	
	<section class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__text">
						<h4>내 정보</h4>
						<div class="breadcrumb__links">
							<a href="/index.jsp">메인</a> <span>내 정보</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="shop spad">
		<div class="container">
			<div style="display: flex; align-items: flex-start;">
				<%@ include file="/include/seller/lnbMyPage.jsp"%>
			</div>
			
			<article class="join" style="margin-left: 480px; margin-top: -260px; margin-bottom: 0;">
				<form id="frmMain" name="frmMain" method="POST">
					<div class="joinArea">
						<ul>
							
							<li>
								<label><b>아이디</b></label><br>
								<span>${sellerDto.id}</span>
							</li>
						
							<li>
								<label><b>성명</b></label><br>
								<span>${sellerDto.sll_nm}</span>
							</li>
							
							<li>
								<label for="confirmPasswd">비밀번호</label>
								<input type="password" id="confirmPasswd" name="confirmPasswd" required placeholder="※특수문자 포함 8자리 이상" />
							</li>
							
							<li>
								<label for="confirmPasswd_">비밀번호 확인</label>
								<input type="password" id="confirmPasswd_" name="confirmPasswd_" required />
							</li>
						
							<li>
								<label for="email">이메일(*)</label>
								<input type="text" id="email" name="email" style="width: 410px;" value="${sellerDto.email}" required />
							</li>
						
							<li>
								<label for="phone"><b>연락처(*)</b></label>
								<input type="text" id="phone" name="phone" style="width: 325px;" maxlength="11" value="${sellerDto.phone}" placeholder="- 제외하고 최대 11자리 입력" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
								<input type="button" value="번호 인증" id="btnPhone">
								<input type="text" id="checkNumber" placeholder="인증번호" style="display:none;">
							</li>
						
							<li>
								<label for="corp_nm">회사명(*)</label>
								<input type="text" id="corp_nm" name="corp_nm" value="${sellerDto.corp_nm}" required />
							</li>
						
							<li>
								<label for="corp_ceo">대표자명(*)</label>
								<input type="text" id="corp_ceo" name="corp_ceo" value="${sellerDto.corp_ceo}" required />
							</li>
							
								<li>
								<label><b>우편번호(*)</b></label>
								<input type="text" maxlength="5" id="post" value="${sellerDto.post}" name="post" required readonly />
								<input type="button" value="우편번호 찾기" onClick="execDaumPostcode();" />
							<br>
								<input type="text" size="40" required id="addr1" name="addr1" value="${sellerDto.addr1}" readonly placeholder="도로명 주소" />
								<input type="hidden" id="jibunAdd" />
								<input type="hidden" id="exliaAddress" />
								<input type="text" placeholder="상세 주소" required id="addr2" name="addr2" value="${sellerDto.addr2}" />
							</li>
							
							<li>
								<label for="intro">회사소개</label>
								<textarea name="intro" cols="46" rows="5" placeholder="회사소개를 입력해주세요" maxlength="1024"> ${sellerDto.intro}</textarea>
							</li>
						</ul>
					
						<div>
							<input type="button" class="submit-button" id="btnModify" value="수정하기" class="submit-button" onClick="checkModify();" style="width: 150px; height: 50px; margin-top: 10px; background-color: black; color: white; border: none; cursor: pointer; font-size: 15px; display: flex; align-items: center; justify-content: center; transition: background-color 0.3s;" onMouseOver="this.style.backgroundColor='gray';" onMouseOut="this.style.backgroundColor='black';" />
						</div>
					</div>
				</form>
			</article>
		</div>
	</section>

	<footer>
		<%@ include file="/include/common/footer.jsp"%>
	</footer>
</body>
</html>