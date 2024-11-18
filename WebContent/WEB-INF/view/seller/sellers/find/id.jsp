<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/seller/sellers/fine/id.jsp" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/front/header.jsp" %>
	<style>
		.findId {width:450px;margin:50px auto 100px;padding:30px 20px;text-align:center;}
		.findId h3 {margin:0 0 50px;}
		
		.findIdArea {justify-content:space-between;}
		.findIdArea li {display:flex;justify-content:space-between;align-items:center;}
		.findIdArea li span {display:inline-block;width:100px;text-align:left;}
		.findIdArea li input {width:300px;height:50px;text-indent:10px;}
		.findIdArea li:not(:last-child) {margin-bottom:15px;}
		.findIdArea > input {width:100px;color:white;background:black;border:none;}
		
		.findIdArea ~ input {display:inline-block;width:100%;height:40px;margin-top:50px;line-height:40px;border:none;border-radius:10px;color:white;background:var(--blue);}
		
		.findId > div a {display:inline-block;width:100%;height:40px;margin-top:10px;line-height:40px;border:1px solid black;border-radius:10px;color:black;}
	</style>
	
	<script>
		function findId() {
			
			var data = {sll_nm: $("#sll_nm").val(), corp_nm: $("#corp_nm").val(), corp_num: $("#corp_num").val(), phone: $("#phone").val()};
			
			$.ajax({
				method: 'POST',
				url: '/seller/sellers/findIdProc.json',
				contentType: 'application/json',
				dataType: 'json', // 응답 데이터를 JSON으로 처리
				data: JSON.stringify(data),
				success:function(res) {
					if (res)
						alert("판매자님의 전화번호로 문자를 보냈으니 확인해주세요");
					else
						alert("입력된 정보를 다시 확인해주세요");
				}
			})
		}
	</script>
</head>
	
<body style="positon:relative;">
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	<!-- Header Section End -->
	
	<section class="content">
		<nav></nav>
		<article class="findId">
			<h3>아이디 찾기</h3>
			<form id="frmMain" name="frmMain" method="POST">
				<div class="findIdArea">
					<ul>
						<li>
							<span>이름</span>
							<input type="text" id="sll_nm" name="sll_nm" required placeholder="이름" autocomplete=off />
						</li>
						<li>
							<span>회사명</span>
							<input type="text" id="corp_nm" name="corp_nm" required placeholder="회사명" autocomplete=off />
						</li>
						<li>
							<span>사업자번호</span>
							<input type="text" id="corp_num" name="corp_num" required placeholder="000-00-00000" autocomplete=off />
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
				<a href="/seller/sellers/findPasswd.web">비밀번호 찾기</a>
				<a href="/front/login/loginForm.web">로그인 하러가기</a>
			</div>
		</article>
		<aside></aside>
	</section>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>