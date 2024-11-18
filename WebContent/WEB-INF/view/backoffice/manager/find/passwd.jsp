<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/backoffice/manager/find/passwd.jsp" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/console/header.jsp" %>
	<style>
		.findPasswd {width:450px;margin:50px auto 100px;padding:30px 20px;text-align:center;}
		.findPasswd h3 {margin:0 0 50px;}
		
		.findPasswdArea {justify-content:space-between;}
		.findPasswdArea ul:first-child {margin-bottom:15px;}
		.findPasswdArea ul:last-child {display:none;margin-top:50px;}
		.findPasswdArea li {display:flex;justify-content:space-between;align-items:center;}
		.findPasswdArea li span {display:inline-block;width:100px;text-align:left;}
		.findPasswdArea li input {width:300px;height:50px;text-indent:10px;}
		.findPasswdArea li:not(:last-child) {margin-bottom:15px;}
		.findPasswdArea > input {width:100px;color:white;background:black;border:none;}
		
		.findPasswdArea ~ input {display:inline-block;width:100%;height:40px;margin:50px 0 10px;line-height:40px;border:none;border-radius:10px;color:white;background:#f44336;}
		.findPasswdArea ~ input:last-child {display:none;}
		
		.findPasswd > div a {display:inline-block;width:100%;height:40px;margin-top:10px;line-height:40px;border:1px solid black;border-radius:10px;color:black;}
		
		
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
		function findPasswd() {
			
			if ($("#mng_nm").val() == "" || $("#phone").val() == "" || $("#id").val() == "") {
				alert("정보를 모두 입력해주세요!");
				return;
			}
			
			var data = {mng_nm: $("#mng_nm").val(), phone: $("#phone").val(), id: $("#id").val()};
			
			$.ajax({
				method: 'POST',
				url: '/console/manager/findPasswdProc.json',
				contentType: 'application/json',
				dataType: 'json', // 응답 데이터를 JSON으로 처리
				data: JSON.stringify(data),
				success:function(res) {
					if (res) {
						$(".chgpasswd").show();
						$(".managerInfo").hide();
						$(".findPasswdArea ~ input").hide();
						$(".findPasswdArea ~ input:last-child").show();
						$("#certification").val(res);
						alert("관리자님의 전화번호로 인증번호를 보냈으니 확인해주세요");
					} else {
						alert("입력된 정보를 다시 확인해주세요");
					}
				}
			})
		}
		
		function changePasswd() {
			
			if ($("#passwd").val() == "" || $("#_passwd").val() == "" || $("#_certification").val() == "") {
				alert("정보를 모두 입력해주세요!");
				return;
				
			} else if ($("#passwd").val() != $("#_passwd").val()) {
				alert("비밀번호가 다릅니다!\n다시 입력해주세요");
				return;
				
			} else if ($("#certification").val() != $("#_certification").val()) {
				alert("인증번호가 다릅니다!\n다시 입력해주세요");
				return;
			}
			
			var data = {mng_nm: $("#mng_nm").val(), phone: $("#phone").val(), id: $("#id").val(), passwd: $("#passwd").val()};
			
			$.ajax({
				method: 'POST',
				url: '/console/manager/changePasswd.json',
				contentType: 'application/json',
				dataType: 'json', // 응답 데이터를 JSON으로 처리
				data: JSON.stringify(data),
				success:function(res) {
					if (res) {
						alert("비밀번호가 변경되었습니다.\n로그인 화면으로 이동합니다");
						location.href = "/console/login/loginForm.web";
					} else {
						alert("비밀번호 변경에 실패했습니다.\n관리자에게 문의하세요");
					}
				}
			})
		}
	</script>
</head>
	
<body>

	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		
		<div id="page-wrapper">
			<div id="page-inner">
				<article class="findPasswd">
					<h3>비밀번호 찾기</h3>
					<form id="frmMain" name="frmMain" method="POST">
						<input type="hidden" name="certification" id="certification">
						<div class="findPasswdArea">
							<ul class="managerInfo">
								<li>
									<span>이름</span>
									<input type="text" id="mng_nm" name="mng_nm" required placeholder="이름" autocomplete=off />
								</li>
								<li>
									<span>전화번호</span>
									<input type="text" id="phone" name="phone" maxlength="11" required placeholder="'-'제외 11자리" autocomplete=off />
								</li>
								<li>
									<span>아이디</span>
									<input type="text" id="id" name="id" maxlength="32" required placeholder="아이디" autocomplete=off />
								</li>
							</ul>
							<ul class="chgpasswd">
								<li>
									<span>변경할<br>비밀번호</span>
									<input type="password" id="passwd" name="passwd" required placeholder="비밀번호" autocomplete=off />
								</li>
								<li>
									<span>비밀번호<br> 확인</span>
									<input type="password" id="_passwd" name="_passwd" required placeholder="비밀번호 확인" autocomplete=off />
								</li>
								<li>
									<span>인증번호</span>
									<input type="text" id="_certification" name="_certification" required placeholder="인증번호 4자리" autocomplete=off />
								</li>
							</ul>
						</div>
						<input type="button" value="인증번호 전송" onClick="findPasswd()">
						<input type="button" value="비밀번호 변경" onClick="changePasswd()">
					</form>
					<div>
						<a href="/console/login/loginForm.web">로그인 하러가기</a>
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