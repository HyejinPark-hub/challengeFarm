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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page info="/WEB-INF/view/backoffice/index.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@ include file="/include/console/header.jsp" %>
	<script type="text/javascript" src="/js/uranus/console.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style>
		.join {width:450px;margin:50px auto 100px;padding:30px 20px;text-align:center;}
		.join h3 {margin:0 0 50px;}
		
		.joinArea {text-align:left;}
		
		input {font-size:15px;}
		input[type=text], input[type=password] {width:100%;padding-left:5px;}
		label {width:100%;margin:10px 0 3px;color:#5e5e5e;}
		label[for^=flg], label[for^=gender] {width:auto;margin:0 10px 0 5px;}
		#id, #email, #phone {width:calc(100% - 102.9px);}
		#checkNumber {margin-top:5px;}
		#post {width:60px;margin-right:10px;}
		#addr1 {margin:5px 0;}
		input::placeholder {color:#9e9e9e;}
		input[type=button] {width:90px;height:40px;border:1px solid #9e9e9e;}
		#post ~ input[type=button] {width:110px}
		
		.joinArea > div >input {display:block;width:300px;height:50px;margin:30px auto 0;line-height:50px;background:#f44336;color:white;border-radius:10px;border:none;}
		
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
		}
	</style>
	<script>
		var isDuplicate = true;			// 아이디 중복체크
		var isEDuplicate = true;		// 이메일 중복체크
		var isCertification = false;	// 연락처 중복체크
		
		window.onload = function () {
			// 아이디 중복체크
			$("#btnId").on("click", function(e) {
				
				// 이메일이 5자리 이하 또는 @가 있으면
				if ($("#id").val().length <= 4 || $("#id").val().indexOf("@") >= 0) {
					alert("아이디를(@ 미포함) 5자리 이상으로 입력하세요!");
					return false;
				}
				
				var myData = {id: $("#id").val()};
				
				$.ajax({
					type: "POST",
					// async: false,
					url: "/console/manager/checkIdDuplicate.json",
					dataType: "json",
					contentType: "application/json; charset=UTF-8",
					data: JSON.stringify(myData),
					success:function(res) {
						// 중복이 안 될 경우
						if (res != true) {
							if (confirm("사용 가능한 아이디입니다.\n이 아이디로 회원가입하시겠습니까?\n확인버튼을 누르시면 아이디 수정이 불가능합니다")) {
								isDuplicate = false;
								$("#id").attr("readonly",true);
							}
							else {
								alert("아이디를 다시 입력해주세요!");
								isDuplicate = true;
								$("#id").attr("readonly",false);
								$("#id").val("").focus();
							}
						}
						else {
							alert($("#id").val() + "는 중복됩니다! 다른 아이디를 입력하세요!");
							$("#id").val("").focus();
						}
					}
				});
			});
			// 이메일 중복체크
			$("#btnEmail").on("click", function(e) {
				
				// 이메일이 7자리 이하 또는 @가 없으면
				if ($("#email").val().length <=7 || $("#email").val().indexOf("@") <= 0) {
					alert("이메일을(@ 포함) 8자리 이상으로 입력하세요!");
					return false;
				}
				
				var myData = {email: $("#email").val()};
				
				$.ajax({
					type: "POST",
					// async: false,
					url: "/console/manager/checkEmailDuplicate.json",
					dataType: "json",
					contentType: "application/json; charset=UTF-8",
					data: JSON.stringify(myData),
					success:function(res) {
						// 중복이 안 될 경우
						if (res != true) {
							if (confirm("사용 가능한 이메일입니다.\n이 이메일로 회원가입하시겠습니까?\n확인버튼을 누르시면 이메일 수정이 불가능합니다")) {
								isEDuplicate = false;
								$("#email").attr("readonly",true);
							}
							else {
								alert("이메일을 다시 입력해주세요!");
								isEDuplicate = true;
								$("#email").attr("readonly",false);
								$("#email").val("").focus();
							}
						}
						else {
							alert($("#email").val() + "는 중복됩니다! 다른 이메일을 입력하세요!");
							$("#email").val("").focus();
						}
					}
				});
			});
			// 연락처 중복체크
			$("#btnPhone").on("click", function(e) {
				
				if (isCertification) {
					alert("이미 인증이 완료된 번호입니다");
					return false;
				}
				
				// 전화번호 11자리 입력
				if ($("#phone").val().length != 11) {
					alert("전화번호 11자리를 입력해주세요!");
					return false;
				}
				
				var myData = {phone: $("#phone").val()};
				
				$.ajax({
					type: "POST",
					url: "/console/manager/checkCertification.json",
					dataType: "json",
					contentType: "application/json; charset=UTF-8",
					data: JSON.stringify(myData),
					success:function(res) {
						// 중복된 번호가 없는 경우
						if (res != 0) {
							alert("해당 번호로 인증번호를 전송하였습니다.\n인증번호를 입력해주세요");
							$("#checkPhone").val(res);
							$("#checkNumber").show();
							$("#phone").attr("readonly", true);
							isCertification = true;
						}
						else {
							alert($("#phone").val() + "는 중복됩니다! 다른 번호를 입력하세요!");
							$("#phone").val("").focus();
							isCertification = false;
						}
					}
				});
			});
		}
	</script>
</head>
<body>
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		
		<div id="page-wrapper">
			<div id="page-inner">
				<section class="content">
					<nav></nav>
					<article class="join">
						<h3>회원가입</h3>
						<form id="frmMain" name="frmMain" method="POST">
							<input type="hidden" name="checkPhone" id="checkPhone">
							<div class="joinArea">
								<ul>
									<li>
										<label for="id">아이디(*)</label>
										<input type="text" id="id" name="id" required placeholder="admin" />
										<input type="button" value="중복 찾기" id="btnId" />
									</li>
									<li>
										<label for="passwd">비밀번호(*)</label>
										<input type="password" id="passwd" name="passwd" required placeholder="※특수문자 포함 8자리 이상" />
									</li>
									<li>
										<label for="passwd_">비밀번호 확인(*)</label>
										<input type="password" id="passwd_" name="passwd_" required />
									</li>
									<li>
										<label for="mng_nm">성명(*)</label>
										<input type="text" id="mng_nm" name="mng_nm" required />
									</li>
									<li>
										<label for="email">이메일(*)</label>
										<input type="text" id="email" name="email" required placeholder="example@chall.com" />
										<input type="button" value="중복 찾기" id="btnEmail" />
									</li>
									<li>
										<label for="phone">연락처(*)</label>
										<input type="text" id="phone" name="phone" maxlength="11" placeholder="- 제외하고 최대 11자리 입력" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
										<input type="button" value="번호 인증" id="btnPhone">
										<input type="text" id="checkNumber" placeholder="인증번호" style="display:none;">
										
									</li>
									<li>
										<label>우편번호(*)</label>
										<input type="text" maxlength="5" id="post" name="post" required readonly />
										<input type="button" value="우편번호 찾기" onClick="execDaumPostcode();" /><br />
										<input type="text" size="40" required id="addr1" name="addr1" readonly placeholder="도로명 주소" />
										<input type="hidden" id="jibunAdd" />
										<input type="hidden" id="extraAddress" />
										<span id="guide" style="color:#999; display:none"></span>
										<input type="text" placeholder="상세 주소" required id="addr2" name="addr2" />
									</li>
								</ul>
								<div>
									<input type="button" value="가입 하기" style="width:100px" onClick="checkRegister();"/>
								</div>
							</div>
						</form>
					</article>
				</section>
				
				<footer>
					<p>Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
				</footer>
			</div>
		</div>
	</div>
</body>
</html>