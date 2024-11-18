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
<%@ page info="/WEB-INF/view/front/member/modifyForm.jsp"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="/include/front/header.jsp"%>
<link rel="stylesheet" href="/css/mypage/main.css" type="text/css">
<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/member/modifyForm.css" />
<script type="text/javascript" src="/js/uranus/member/modifyForm.js"></script>
<script type="text/javascript" src="/js/uranus/jquery-3.7.1.min.js"></script>
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
	<header class="header">
		<%@ include file="/include/front/top.jsp"%>
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
				<%@ include file="/include/front/lnbMyPage.jsp"%>
			</div>
			
			<article class="join" style="margin-left: 480px; margin-top: -260px; margin-bottom: 0;">
				<form id="frmMain" name="frmMain" method="POST">
					<input type="hidden" name="_flg_sms" id="_flg_sms" value="${memberDto.flg_sms}" />
					<input type="hidden" name="_flg_email" id="_flg_email" value="${memberDto.flg_email}" />
					<div class="joinArea">
						<ul>
							<li>
								<label><b>성명</b></label><br>${memberDto.mbr_nm} /
								<c:choose>
									<c:when test="${memberDto.gender == 'M'}">
									<span class="gender">남성</span>
								</c:when>
								<c:otherwise>
									<span class="gender">여성</span>
								</c:otherwise>
								</c:choose>
							</li>
						
							<li>
								<label><b>이메일</b></label>
								<span>${memberDto.email}</span>
							</li>
							
							<li>
								<label><b>새 비밀번호(*)</b></label>
								<input type="password" id="confirmPasswd" name="confirmPasswd" required placeholder="※특수문자 포함 8자리 이상" />
							</li>
							
							<li>
								<label><b>새 비밀번호 확인(*)</b></label>
								<input type="password" id="confirmPasswd_" name="confirmPasswd_" required placeholder="새 비밀번호를 다시 입력하세요" />
							</li>
							
							<li>
								<label for="phone"><b>연락처(*)</b></label>
								<input type="text" id="phone" name="phone"  style="width: 325px;" maxlength="11" value="${memberDto.phone}" placeholder="- 제외하고 최대 11자리 입력" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
								<input type="button" value="번호 인증" id="btnPhone">
								<input type="text" id="checkNumber" placeholder="인증번호" style="display:none;">
							</li>
							
							<li>
								<label><b>우편번호(*)</b></label>
								<input type="text" maxlength="5" id="post" value="${memberDto.post}" name="post" required readonly />
								<input type="button" value="우편번호 찾기" onClick="execDaumPostcode();" />
							<br>
								<input type="text" size="40" required id="addr1" name="addr1" value="${memberDto.addr1}" readonly placeholder="도로명 주소" />
								<input type="hidden" id="jibunAdd" />
								<input type="hidden" id="exliaAddress" />
								<input type="text" placeholder="상세 주소" required id="addr2" name="addr2" value="${memberDto.addr2}" />
							</li>
							
							<li style="margin-top: 5px;">
								<label style="margin-right: 30px;"><b>마케팅 수신 동의</b></label>
							<p>
								SMS <input type="checkbox" name="flg_sms" id="flg_sms" value="Y" <c:if test="${memberDto.flg_sms == 'Y'}"> checked</c:if> />
								Email <input type="checkbox" name="flg_email" id="flg_email" value="Y" <c:if test="${memberDto.flg_email == 'Y'}"> checked</c:if> />
							</p>
							</li>
						</ul>
					
						<div>
							<input type="button" class="submit-button" id="btnModify" value="수정하기"  onClick="checkModify();" style="width: 150px; height: 50px; margin-top: 10px; background-color: black; color: white; border: none; cursor: pointer; font-size: 15px; display: flex; align-items: center; justify-content: center; transition: background-color 0.3s;" onMouseOver="this.style.backgroundColor='gray';" onMouseOut="this.style.backgroundColor='black';" />
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