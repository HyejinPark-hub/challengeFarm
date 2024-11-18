<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/center/board/notice/view.jsp" %>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
</head>
<style>
	table {
		caret-color: transparent; 
	}
	
	input[type=button] {display:block;width:120px;height:50px;margin:20px auto 0;line-height:50px;background:#007bff;color:white;border-radius:10px;border:none;}

	#modifyBtn {display:block;width:50px;height:30px;margin:5px auto 0;line-height:30px;background:#007bff;color:white;border-radius:10px;border:none;}
	
	.shopping__cart__table table tbody tr td {padding:0; }
	.shopping__cart__table table tbody tr td.product__cart__item .product__cart__item__text h6 {font-weight:10; padding-top: 3px; padding-bottom: 10px;}
</style>
<script>
/*
function goWriteForm() {
	
	// NULL 방지 at 서버
	document.getElementById("seq_bbs").remove();
	
	var frmMain = document.getElementById("frmMain");
	
	frmMain.action="/front/center/board/writeForm.web";
	frmMain.submit();
}

function goView(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("seq_bbs").value = value;
	
	frmMain.action="/front/center/board/view.web";
	frmMain.submit();
}

function goList(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("searchWord").value = "";
	document.getElementById("currentPage").value = "1";
	document.getElementById("cd_bbs_type").value = value;
	
	frmMain.action="/front/center/board/list.web";
	frmMain.submit();
}

function goPage(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("currentPage").value = value;
	
	frmMain.action="/front/center/board/list.web";
	frmMain.submit();
}
*/
</script>
<body>
<header>
	<%@ include file="/include/front/top.jsp" %>
</header>
<form id="frmMain" method="POST">
<input type="hidden" name="seq_bbs"		id="seq_bbs"/>
<input type="hidden" name="cd_bbs_type" id="cd_bbs_type" value="${paging.cd_bbs_type}" />
<input type="hidden" name="currentPage" id="currentPage" value="${paging.currentPage}" />
<input type="hidden" name="flg_reply" id="flg_reply" />
<input type="hidden" name="cd_ctg" id="cd_ctg" />
	<header class="header">
		<section class="breadcrumb-option" style="padding-bottom: 0px;">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="breadcrumb__text">
							<h4 style=" font-size: 2.0em;">공지사항</h4>
						</div>
					</div>
				</div>
			</div>
		</section>
	</header>
	<section class="shopping-cart spad" style=" padding-top: 30px" >
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
				</div>
				<div class="col-lg-12">
					<div class="shopping__cart__table">
						<table>
							<thead>
									<tr>
										<td colspan="4">
											<div style="height: 3px; background-color: black; margin: 2px 0;"></div>
											<span style="font-weight: bold; font-size: 25px;">${boardDto.title}</span>
											<div style="width: 100%; text-align: justify;">
											<span style="color: gray; padding-left:10px">${boardDto.dt_reg}</span>
											<span style="color: gray; float: right; padding-right:10px">${boardDto.readed}</span>
											<span style="float: right; padding-right:5px;">
												<img src="/img/icon/readed.png" alt="readed.png">
											</span>
											</div>
											<div style ="height: 0.1px; margin: 10px; background-color:#ccc">
											</div>
										</td>
									</tr>
							</thead>
							<tbody>
								<tr>
								<td colspan="4" style="padding-left:10px">
									<c:out value="${boardDto.content}" escapeXml="false" />
								</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<a href="javascript:history.back()" style= "color: gray ;" >목록으로 돌아가기</a>
		</div>
	</section>
	<%@ include file="/include/common/footer.jsp" %>
</form>	
</body>
</html>