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
<%@ page info="/WEB-INF/view/backoffice/login/loginForm.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/console/header.jsp" %>
	
	<style>
		.login {width:450px;margin:100px auto 300px;padding:30px 20px;text-align:center;}
		.login h3 {margin:0 0 50px;}
		
		.tab {display:flex;margin-bottom:40px;}
		.tab li {width:50%;cursor:pointer;padding-bottom:10px;box-sizing:border-box;}
		.tab li.active {border-bottom:2px solid black;font-weight:bold;}
		
		.loginArea {display:flex;justify-content:space-between;}
		.loginArea li input {width:250px;height:50px;margin-bottom:0;}
		.loginArea > input {width:100px;color:white;background:black;border:none;}
		
		.login > div {display:flex;justify-content:space-between;margin-top:50px;}
		.login > div a {color:gray;}
		.login > div a:hover {color:#007bff;}
		
		
		@media (max-width: 768px) {
			#page-wrapper {position:unset;}
		}
		
		@media (min-width: 768px) {
			#page-wrapper {position:unset;margin:0;min-height:calc(100vh - 60px);}
			#page-inner {margin:0;min-height:inherit;}
			.navbar {position:unset;}
		}
		
		@media (max-width: 480px) {
			.top-navbar, #page-wrapper {position:unset;}
			.login {width:auto;}
			.loginArea li input {width:190px;height:30px;}
			.loginArea > input {width:90px;}
		}
	</style>
	
	<script>
		window.onload = function() {
			
			$("#frmMain input").keydown(function(e) {
				if (e.keyCode == 13) {
					checkForm();
				}
			});
		}
		
		function checkForm() {
			
			var frmMain = $("#frmMain");
			
			// 아이디 확인
			if ($("#id").val().length <= 4 || $("#id").val().indexOf("@") >= 0) {
				alert("아이디를 확인하세요!");
				$("#id").focus().select();
				return;
			}
			
			// 비밀번호 확인
			if ($("#passwd").val().length < 8) {
				alert("비밀번호를 확인하세요!");
				$("#passwd").focus();
				return;
			}

			frmMain.attr("action", "/console/login/loginProc.web");
			frmMain.submit();
		}
	</script>
</head>
<body>
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
	
		<div id="page-wrapper">
			<div id="page-inner">
				<article class="login">
					<h3>로그인</h3>
					<form id="frmMain" name="frmMain" method="POST">
						<div class="loginArea">
							<ul>
								<li>
									<input type="text" id="id" name="id" value="" maxlength="32" required placeholder="아이디" autocomplete=off />
								</li>
								<li>
									<input type="password" id="passwd" name="passwd" value="" maxlength="16" required placeholder="비밀번호" />
								</li>
							</ul>
							<input type="button" value="로그인" onClick="checkForm();">
						</div>
					</form>
					<div>
						<span><a href="/console/manager/findId.web">아이디 찾기</a></span>
						<span><a href="/console/manager/findPasswd.web">비밀번호 찾기</a></span>
						<span><a href="/console/manager/registerForm.web">회원가입</a></span>
					</div>
				</article>
			
				<footer>
					<p>Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
				</footer>
			</div>
		</div>
	</div>
</body>
</html>