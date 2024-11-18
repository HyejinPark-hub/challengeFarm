<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/seller/center/board/notice/list.jsp" %>
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

function goWriteForm() {
	
	// NULL 방지 at 서버
	document.getElementById("seq_bbs").remove();
	
	var frmMain = document.getElementById("frmMain");
	
	frmMain.action="/seller/center/board/writeForm.web";
	frmMain.submit();
}

function goView(value) {
	
	var frmMain = document.getElementById("frmMain");
	
	document.getElementById("seq_bbs").value = value;
	
	frmMain.action="/seller/center/board/view.web";
	frmMain.submit();
}

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
	
	frmMain.action="/seller/center/board/list.web";
	frmMain.submit();
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
					<h4 style=" font-size: 2.0em;">공지사항</h4>
				</div>
			</div>
		</div>
	</div>
</section>
<form id="frmMain" method="POST">
<input type="hidden" name="seq_bbs"		id="seq_bbs"/>
<input type="hidden" name="cd_bbs_type" id="cd_bbs_type" value="${paging.cd_bbs_type}" />
<input type="hidden" name="currentPage" id="currentPage" value="${paging.currentPage}" />
<input type="hidden" name="flg_reply" id="flg_reply" />
<input type="hidden" name="cd_ctg" id="cd_ctg" />
	<!-- Shopping Cart Section Begin -->
	<section class="shopping-cart spad" >
		<%@ include file="/include/seller/lnbCenter.jsp" %>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="shop__product__option__right" style="margin-top: -40px; ">
						<input type="hidden" name="searchWord" id="searchWord" value="${paging.searchWord}" style="border: none; border-bottom: 2px solid black; outline: none;">
						<a href="javascript:goSearchList()" class="search-switch">
						<!--<img src="/img/icon/search.png" alt="" style="position: absolute; right: 15px;"> -->
						</a>
					</div>
				</div>
				<div class="col-lg-12">
					<div class="shopping__cart__table">
						<table>
							<thead>
									<tr>
										<td colspan="5">
											<div style="height: 3px; background-color: black; margin: 2px 0;"></div>
										</td>
									</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list}">
										<tr>
											<td colspan="4" style="text-align: center; padding: 50px">등록된 게시글이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach items="${list}" var="item">
											<tr>
												<td style= "text-align: center;">
													<c:choose>
														<c:when test="${empty item.flg_reply}">
															[공지]
														</c:when>
														<c:otherwise>
															${item.flg_reply}
														</c:otherwise>
													</c:choose>
												</td>
												<td style="padding:20px">
													<a href="javascript:goView(${item.seq_bbs});" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; 
														<c:if test="${item.flg_top == 'Y'}">
															font-weight: bold; color: black;
														</c:if>
														<c:if test="${item.flg_top != 'Y'}">
															color: black; 
														</c:if>
														">
														${item.title}
													</a>
												</td>
												<td  style="padding-bottom: 0px; padding-top: 0px; font-weight: bold;color: gray; font-size: 13px; text-align: center;">
													${item.dt_reg}
												</td>
												<td style="text-align:right; padding-bottom:4px"> 
													<img src="/img/icon/readed.png" alt="readed.png">
												</td>
												<td style="padding-bottom: 0px; padding-top: 0px; font-weight: bold;color: gray; font-size: 13px; text-align:center">
															${item.readed}
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
			<div class="row">
				<div class="col-lg-12">
					<div class="product__pagination">
						<plutozoneUtilTag:page styleID="front_image" currentPage="${paging.currentPage}" linePerPage="${paging.linePerPage}" totalLine="${paging.totalLine}" scriptFunction="goPage" />
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="/include/common/footer.jsp" %>
</form>	
</body>
</html>