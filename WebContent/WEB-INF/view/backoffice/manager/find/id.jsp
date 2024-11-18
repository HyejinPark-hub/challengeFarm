<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/backoffice/manager/fine/id.jsp" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/console/header.jsp" %>
	<style>
		.findId {width:450px;margin:50px auto 100px;padding:30px 20px;text-align:center;}
		.findId h3 {margin:0 0 50px;}
		
		.findIdArea {justify-content:space-between;}
		.findIdArea li {display:flex;justify-content:space-between;align-items:center;}
		.findIdArea li span {display:inline-block;width:100px;text-align:left;}
		.findIdArea li input {width:300px;height:50px;text-indent:10px;}
		.findIdArea li:nth-child(1) {margin-bottom:15px;}
		.findIdArea > input {width:100px;color:white;background:black;border:none;}
		
		.findIdArea ~ input {display:inline-block;width:100%;height:40px;margin-top:50px;line-height:40px;border:none;border-radius:10px;color:white;background:#f44336;}
		
		.findId > div a {display:inline-block;width:100%;height:40px;margin-top:10px;line-height:40px;border:1px solid black;border-radius:10px;color:black;}
		
		
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
		function findId() {
			
			var data = {mng_nm: $("#mng_nm").val(), phone: $("#phone").val()};
			
			$.ajax({
				method: 'POST',
				url: '/console/manager/findIdProc.json',
				contentType: 'application/json',
				dataType: 'json', // 응답 데이터를 JSON으로 처리
				data: JSON.stringify(data),
				success:function(res) {
					if (res)
						alert("관리자님의 전화번호로 문자를 보냈으니 확인해주세요");
					else
						alert("입력된 정보를 다시 확인해주세요");
				}
			})
		}
	</script>
</head>
	
<body style="positon:relative;">
	<div id="wrapper">
		<%@ include file="/include/console/top.jsp" %>
		
		<div id="page-wrapper">
			<div id="page-inner">
				<article class="findId">
					<h3>아이디 찾기</h3>
					<form id="frmMain" name="frmMain" method="POST">
						<div class="findIdArea">
							<ul>
								<li>
									<span>이름</span>
									<input type="text" id="mng_nm" name="mng_nm" required placeholder="이름" autocomplete=off />
								</li>
								<li>
									<span>전화번호</span>
									<input type="text" id="phone" name="phone" maxlength="11" required placeholder="'-'제외 11자리" autocomplete=off />
								</li>
							</ul>
						</div>
						<input type="button" value="아이디 찾기" onClick="findId()">
					</form>
					<div>
						<a href="/console/manager/findPasswd.web">비밀번호 찾기</a>
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