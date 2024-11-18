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
 *				: [20240626130000][dhtjgml87@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/WEB-INF/view/front/login/loginForm.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
	<script type="text/javascript" src="/js/uranus/common.js"></script>
	<script type="text/javascript" src="/js/uranus/front.js"></script>
	<style>
		.login {width:450px;margin:50px auto 100px;padding:30px 20px;text-align:center;}
		.login h3 {margin:0 0 50px;}
		
		.tab {display:flex;margin-bottom:40px;}
		.tab li {width:50%;cursor:pointer;padding-bottom:10px;box-sizing:border-box;}
		.tab li.active {border-bottom:2px solid black;font-weight:bold;}
		
		.loginArea {display:flex;justify-content:space-between;}
		.loginArea li input {width:250px;height:50px;}
		.loginArea li:nth-child(1) {margin-bottom:15px;}
		.loginArea > input {width:100px;color:white;background:black;border:none;}
		
		.login > div {display:flex;justify-content:space-between;}
		.login > div a {color:gray;}
		.login > div a:hover {color:#007bff;}
		
		.mbr {display:block;}
		.sll {display:none;}
		
		.saveID {margin:20px 0 40px;text-align:left;}
		
		@media all and (max-width:479px) {
			.login {width:100%;}
			.loginArea ul {width:calc(100% - 135px);}
			.loginArea li input {width:100%}
			
			.login > div span {width:50%;}
		}
	</style>
	<script>
		// 로그인 타입 (1: 구매자, 2: 판매자)
		var loginType = 1;
		
		window.onload = function () {
			if ("${url}") {
				alert("로그인이 필요합니다.");
			}
			
			if (getCookie("checkedID") == 'Y') {
				$("#checkID").prop("checked", true);
				
				if (getCookie("loginType") == "member") {
					changeTab(1);
					$("#email").val(getCookie("loginId"));
				} else {
					changeTab(2);
					$("#id").val(getCookie("loginId"));
				}
			} else {
				$("#checkID").prop("checked", false);
				changeTab(1);
			}
			
			$("#frmMain input").keydown(function(e) {
				if (e.keyCode == 13) {
					checkForm();
				}
			});
		}

		function changeTab(type) {
			
			loginType = type;
			
			if (getCookie("checkedID") == 'Y' && getCookie("loginType") == 'member') {
				$("#id, #passwd").val("");
			} else if (getCookie("checkedID") == 'Y' && getCookie("loginType") == 'seller') {
				$("#email, #passwd").val("");
			} else {
				$("#email, #id, #passwd").val("");
			}
			
			if (type == 1) {
				$(".tab li").eq(0).addClass("active");
				$(".tab li").eq(1).removeClass("active");
				$("#email").show();
				$("#id").hide();
				$(".mbr").css("display","block");
				$(".sll").css("display","none");
			}
			else {
				$(".tab li").eq(1).addClass("active");
				$(".tab li").eq(0).removeClass("active");
				$("#email").hide();
				$("#id").show();
				$(".mbr").css("display","none");
				$(".sll").css("display","block");
			}
		}

		function checkForm() {
			
			var frmMain		= $("#frmMain");
			
			// 구매자 로그인 (이메일 형식 7자리 이상 / @필수)
			if (loginType == 1) {
				if ($("#email").val().length <=7 || $("#email").val().indexOf("@") <= 0) {
					alert("이메일을 확인하세요!");
					document.getElementById("email").focus().select();
					return;
				}
				frmMain.attr("action", "/front/login/loginProc.web");
			}
			// 판매자 로그인 (5자리 이상 / @XX)
			else if (loginType == 2) {
				if ($("#id").val().length <=5 || $("#id").val().indexOf("@") >= 0) {
					alert("아이디를 확인하세요!");
					document.getElementById("id").focus().select();
					return;
				}
				frmMain.attr("action", "/seller/login/loginProc.web");
			}
			
			// 비밀번호 확인
			if (document.getElementById("passwd").value.length < 8) {
				alert("비밀번호를 확인하세요!");
				document.getElementById("passwd").focus();
				return;
			}
			
			frmMain.submit();
		}
	</script>
</head>
<body>
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	
	<section class="content">
		<nav></nav>
		<article class="login">
			<h3>로그인</h3>
			<form id="frmMain" name="frmMain" method="POST">
				<ul class="tab">
					<li onclick="changeTab(1)">구매자</li>
					<li onclick="changeTab(2)">판매자</li>
				</ul>
				<div class="loginArea">
					<ul>
						<li>
							<input type="text" id="email" name="email" value="" maxlength="32" required placeholder="이메일" autocomplete=off />
							<input type="text" id="id" name="id" value="" maxlength="32" required placeholder="아이디" autocomplete=off style="display:none;" />
						</li>
						<li>
							<input type="password" id="passwd" name="passwd" value="" maxlength="16" required placeholder="비밀번호" />
						</li>
					</ul>
					<input type="button" value="로그인" onClick="checkForm();">
				</div>
				<div class="saveID">
					<input type="checkbox" id="checkID" name="checkID" value="Y"> <label for="checkID">아이디 저장</label>
				</div>
			</form>
			<div>
				<span class="mbr"><a href="/front/member/findId.web">아이디 찾기</a></span>
				<span class="mbr"><a href="/front/member/findPasswd.web">비밀번호 찾기</a></span>
				<span class="sll"><a href="/seller/sellers/findId.web">아이디 찾기</a></span>
				<span class="sll"><a href="/seller/sellers/findPasswd.web">비밀번호 찾기</a></span>
				<span class="mbr"><a href="/front/member/agree.web">구매자 회원가입</a></span>
				<span class="sll"><a href="/seller/sellers/agree.web">판매자 회원가입</a></span>
			</div>
		</article>
		<aside></aside>
	</section>
	
	<%@ include file="/include/common/footer.jsp" %>
	
	<!-- Search Begin -->
	<div class="search-model">
		<div class="h-100 d-flex align-items-center justify-content-center">
			<div class="search-close-switch">+</div>
			<form class="search-model-form">
				<input type="text" id="search-input" placeholder="Search here.....">
			</form>
		</div>
	</div>
	<!-- Search End -->
</body>
</html>