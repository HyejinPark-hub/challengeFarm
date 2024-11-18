<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/seller/center/board/faq/list.jsp" %>
<%@ taglib prefix="c"					uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="plutozoneUtilTag"	uri="/WEB-INF/tld/com.plutozone.util.tld" %>
<%@ taglib prefix="fmt"					uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/seller/header.jsp" %>
</head>
<style>
	table {
		caret-color: transparent; 
	}
	
	/*input[type=button] {display:block;width:120px;height:50px;margin:20px auto 0;line-height:50px;background:#007bff;color:white;border-radius:10px;border:none;}*/

	#modifyBtn {display:block;width:50px;height:30px;margin:5px auto 0;line-height:30px;background:#007bff;color:white;border-radius:10px;border:none;}
	
	.shopping__cart__table table tbody tr td {padding:0; }
	.shopping__cart__table table tbody tr td.product__cart__item .product__cart__item__text h6 {font-weight:10; padding-top: 3px; padding-bottom: 10px;}
</style>
<script>

	function goList(value) {
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("searchWord").value = "";
		document.getElementById("currentPage").value = "1";
		document.getElementById("cd_bbs_type").value = value;
		
		frmMain.action="/seller/center/board/list.web";
		frmMain.submit();
	}
	
	function goPage(value) {
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("currentPage").value = value;
		
		frmMain.action="/seller/sale/list.web";
		frmMain.target = "";
		frmMain.submit();
	}
	
	function goModify(value){
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("seq_sle").value = value;
		
		frmMain.action="/seller/sale/modify.web";
		frmMain.submit();
		
	}
	
	function goStateList(value){
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("cd_state_sale").value = value;
		document.getElementById("currentPage").value = "1";
		
		frmMain.action="/seller/sale/list.web";
		frmMain.submit();
		
	}
	
	function goSortList(value){
		
		var frmMain = document.getElementById("frmMain");
		
		document.getElementById("sale_sort").value = value;
		document.getElementById("currentPage").value = "1";
		
		frmMain.action="/seller/sale/list.web";
		frmMain.submit();
		
	}
	
	function goSearchList(){
		
		var frmMain = document.getElementById("frmMain");
		
		frmMain.action="/seller/sale/list.web";
		frmMain.submit();
		
	}
	
	function goLinePerPage(value){
		
		var frmMain = document.getElementById("frmMain");
		document.getElementById("currentPage").value = "1";
		document.getElementById("linePerPage").value = "";
		document.getElementById("linePerPage").value = value;
		
		frmMain.action="/seller/sale/list.web";
		frmMain.submit();
		
	}
	
	function toggleContent(seq) {
		
		console.log("Clicked item with seq:", seq);
		const contentRow = document.getElementById("content-" + seq);
		console.log("Content row:", contentRow); // 여기에 추가된 로그
		if (contentRow) {
			if (contentRow.style.display === "none" || contentRow.style.display === "") {
				contentRow.style.display = "table-row";
			} else {
				contentRow.style.display = "none";
			}
		} else {
			console.error(`No content found for seq: ${seq}`); // 오류 로그 추가
		}
	}

</script>
<body>
<header class="header">
	<%@ include file="/include/seller/top.jsp" %>
</header>
<section class="breadcrumb-option" style="padding:40px 0;">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb__text">
					<h4 style=" font-size: 2.0em;">FAQ</h4>
				</div>
			</div>
		</div>
	</div>
</section>
<form id="frmMain" method="POST">
<input type="hidden" name="cd_bbs_type"	id="cd_bbs_type"	value="${paging.cd_bbs_type}" />
<input type="hidden" name="currentPage"	id="currentPage"	value="${paging.currentPage}" />
<input type="hidden" name="seq_bbs"		id="seq_bbs"		value="${boardDto.seq_bbs}" />
	<!-- Shopping Cart Section Begin -->
	<section class="shopping-cart spad" >
		<%@ include file="/include/seller/lnbCenter.jsp" %>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
				<div class="shop__product__option__right" style="margin-top: -40px; ">
						<input type="hidden" name="searchWord" id="searchWord" value="${paging.searchWord}" style="border: none; border-bottom: 2px solid black; outline: none;">
						<a href="javascript:goSearchList()" class="search-switch">
						</a>
					</div>
				</div>
				<div class="col-lg-12">
					<div class="shopping__cart__table">
						<table>
							<thead>
									<tr>
										<td colspan="4">
											<div style="height: 3px; background-color: black; margin: 2px 0;"></div>
										</td>
									</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list}">
										<tr>
											<td colspan="8" style="text-align: center; padding: 50px">등록된 게시글이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
									<c:forEach items="${list}" var="list">
										<tr style ="border-bottom: 1px solid #ccc;">
											<td>
												<div>
													<h6 style=" text-align: center; font-weight: bold;">Q</h6>
												</div>
											</td>	
											<td style="padding: 20px">
												<div>
													<h6 style=" font-weight: bold; cursor: pointer;" onclick="toggleContent(${list.seq_bbs}); ">${list.title}</h6>
												</div>
											</td>
										</tr>	
										<tr id="content-${list.seq_bbs}" style="display:none;">
											<td colspan="4">
												<div style="padding: 50px; border: 1px solid #ccc;border-top:none;">
													${list.content}
												</div>
											</td>
										</tr>
									</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/include/common/footer.jsp" %>
</form>	
</body>
</html>