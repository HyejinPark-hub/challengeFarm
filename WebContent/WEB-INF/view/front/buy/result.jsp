<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/buy/result.jsp" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/front/header.jsp" %>
	<style>
		.buyResult {width:450px;margin:50px auto 100px;padding:30px 20px;text-align:center;}
		.buyResult h3 {margin:0 0 50px;}
		
		.resultArea {margin-bottom:50px;}
		.resultArea p {font-size:16px;}
		.resultArea P:first-child {margin: 10px 0 30px;}
		.resultArea P:last-child {font-size:14px;}
		.resultArea p span {font-weight:bold;font-size:24px;color:var(--primary);}
		
		.buyResult > div a {display:inline-block;width:49%;height:40px;margin-top:10px;line-height:40px;border:1px solid black;border-radius:10px;color:black;}
		.buyResult > div a:first-child {background:var(--primary);border-color:var(--primary);color:white;}
	</style>
	
	<script></script>
</head>
	
<body>
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	<!-- Header Section End -->
	
	<section class="content">
		<nav></nav>
		<article class="buyResult">
			<h3>결제 완료</h3>
			<form id="frmMain" name="frmMain" method="POST">
				<div class="resultArea">
					<%-- [TODO: 주문번호를 받아와야함 ${deal_num} --%>
					<p><span>1234567890</span> 주문건<br>결제가 완료되었습니다.</p>
					<p>주문내역 확인은 "마이페이지 > 결제내역"에서 확인가능합니다.</p>
				</div>
			</form>
			<div>
				<a href="#">주문 상세보기</a>
				<a href="/">메인으로 가기</a>
			</div>
		</article>
		<aside></aside>
	</section>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>