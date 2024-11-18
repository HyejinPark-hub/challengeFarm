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
 *				: [20241002100000][dhtjgml87@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/WEB-INF/view/seller/sellers/registerForm.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
	<script type="text/javascript" src="/js/uranus/seller.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
	<style>
		.join {width:450px;margin:50px auto 100px;padding:30px 20px;text-align:center;}
		.join h3 {margin:0 0 50px;}
		
		.joinArea {text-align:left;}
		
		input {font-size:15px;}
		input[type=text], input[type=password] {width:100%;padding-left:5px;}
		label {width:100%;margin:10px 0 3px;}
		label[for^=flg], label[for^=gender] {width:auto;margin:0 10px 0 5px;}
		#id {width:calc(100% - 84px);}
		#post {width:60px;}
		#addr1 {margin:5px 0;}
		input[id^=corp_num],input[id=corp_birthday] {padding:0;text-align:center;}
		#corp_num1 {width:45px;}
		#corp_num2 {width:35px;}
		#corp_num3 {width:60px;margin-right:30px;}
		#corp_birthday {width:100px;margin-left:30px;}
		textarea {width:100%;height:150px;resize:none;}
		
		.joinArea > div >input {display:block;width:300px;height:50px;margin:30px auto 0;line-height:50px;background:#007bff;color:white;border-radius:10px;border:none;}
		
		@media all and (max-width:479px) {
			.join {width:100%;}
			#corp_num3 {margin-right:10px;}
			#corp_birthday {margin-left:10px;}
		}
	</style>
	<script>
		var isDuplicate = true;
		var today;

		$(document).ready(function(){

			var now		= new Date();
			var year	= now.getFullYear();				//연도
			var month	= now.getMonth()+1;					//월
			var date	= ('0' + now.getDate()).slice(-2);	//일
			
			today = year.toString() + month.toString() + date;
			
			$("p").eq(3).text(date);
			$("#btnId").on("click", function(e) {
				
				// 이메일이 7자리 이하 또는 @가 없으면
				if ($("#id").val().length <=5 || $("#id").val().indexOf("@") >= 0) {
					alert("이메일/아이디를(@ 미포함) 8자리 이상으로 입력하세요!");
					return false;
				}
				
				var myData = {id: $("#id").val()};
				
				$.ajax({
					type: "POST",
					// async: false,
					url: "/seller/sellers/checkDuplicate.json",
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
								alert("이메일을 다시 입력해주세요!");
								$("#id").attr("readonly",false);
								$("#id").val("").focus();
							}
						}
						else {
							alert($("#id").val() + "는 중복됩니다! 다른 이메일을 입력하세요!");
							$("#id").val("").focus();
						}
					}
				});
			});
		})
	</script>
</head>
<body>
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	
	<section class="content">
		<nav></nav>
		<article class="join">
			<h3>회원가입</h3>
			<form id="frmMain" name="frmMain" method="POST">
				<input type="hidden" name="term_1" value="${term.substring(0,1)}">
				<input type="hidden" name="term_2" value="${term.substring(1,2)}">
				<input type="hidden" name="term_3" value="${term.substring(2,3)}">
				<div class="joinArea">
					<ul>
						<li>
							<label for="">아이디(*)</label>
							<input type="text" id="id" name="id" required />
							<input type="button" value="중복찾기" id="btnId" />
						</li>
						<li>
							<label for="">비밀번호(*)</label>
							<input type="password" id="passwd" name="passwd" required placeholder="※특수문자 포함 8자리 이상" />
						</li>
						<li>
							<label for="">비밀번호 확인(*)</label>
							<input type="password" id="passwd_" name="passwd_" required />
						</li>
						<li>
							<label for="">성명(*)</label>
							<input type="text" id="sll_nm" name="sll_nm" required />
						</li>
						<li>
							<label for="">이메일(*)</label>
							<input type="text" id="email" name="email" required />
							
						</li>
						<li>
							<label for="">연락처(*)</label>
							<input type="text" id="phone" name="phone" maxlength="11" placeholder="- 제외하고 최대 11자리 입력" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
						</li>
						<li>
							<label for="">회사명(*)</label>
							<input type="text" id="corp_nm" name="corp_nm" required />
							
						</li>
						<li>
							<label for="">사업자등록번호 / 개업년월일(*)</label>
							<input type="hidden" id="corp_num"  name="corp_num" />
							<input type="text"   id="corp_num1" name="corp_num1" maxlength="3" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
							- <input type="text" id="corp_num2" name="corp_num2" maxlength="2" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
							- <input type="text" id="corp_num3" name="corp_num3" maxlength="5" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
							/ <input placeholder="YYYYMMDD" type="text" id="corp_birthday" name="corp_birthday" maxlength="8" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
						</li>
						<li>
							<label for="">대표자명(*)</label>
							<input type="text" id="corp_ceo" name="corp_ceo" required />
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
						<li>
							<label for="">회사소개</label>
							<textarea name="intro" cols="30" rows="3" placeholder="회사소개를 입력해주세요"maxlength="1024"></textarea>
						</li>
					</ul>
					<div>
						<input type="button" value="가입 하기" onClick="checkRegister();"/>
					</div>
				</div>
			</form>
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