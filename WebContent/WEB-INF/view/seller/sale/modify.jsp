<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/center/board/faq/list.jsp" %>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/seller/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	
	<script>
		window.onload = function() {
			
			if (${saleDto.cd_ctg.substring(0,1)} == 2) $(".onlyW").hide();
			else $(".onlyW").show();
			
			var sizeNm = "${saleDto.size_nm}";
			var eachNm = sizeNm.split("/");
			var sizeValue = "${saleDto.size_detail}";
			var eachSize = sizeValue.split(",");
			var countStock = "${saleDto.count_stock}";
			var eachCount = countStock.split("/");
			var sizeTable = "";
			
			
			for (var loop = 0; loop < eachSize.length; loop++) {
				
				sizeTable += "<table>" +
								"<tr>" +
									"<th><input type='text' value='사이즈' readonly></th>" +
									"<td><input type='text' value='" + eachNm[loop] + "'class='eachSize' placeholder='XS'> <input type='text' value='" + eachCount[loop] + "' class='eachCount' placeholder='재고 수량' > <span onClick='remove(this, \"\")'>x 전체삭제</span></td>" +
								"</tr>";
				
				var eachValue = eachSize[loop].split("&");
				
				for (var loop2 = 0; loop2 < eachValue.length; loop2++) {

					sizeTable += "<tr>" +
									"<th><input type='text' class='name' value='" + eachValue[loop2].split("/")[0] + "' placeholder='총장'></th>" +
									"<td><input type='text' class='value' class='eachSize' value='" + eachValue[loop2].split("/")[1] + "' placeholder='100'> <span onClick='remove(this,\"y\")'> x 상세삭제</span></td>" +
								 "</tr>";
				}
				sizeTable +=	"<tr><td colspan='2' onClick='plusDtlSize(this)' class='plusDtl'>+ 상세사이즈</td></tr>" +
							"</table>";
			}
			$("p.pButton").before(sizeTable);
		}
		
		var size = "<table>" +
						"<tr>" +
							"<th><input type='text' value='사이즈' readonly></th>" +
							"<td><input type='text' class='eachSize' placeholder='XS'> <input type='text' class='eachCount' placeholder='재고 수량' > <span onClick='remove(this, \"\")'>x 전체삭제</span></td>" +
						"</tr>" +
						"<tr>" +
							"<th><input type='text' class='name' placeholder='총장'></th>" +
							"<td><input type='text' class='value' placeholder='100'></td>" +
						"</tr>" +
						"<tr><td colspan='2' onClick='plusDtlSize(this)' class='plusDtl'>+ 상세사이즈</td></tr" +
					"</table>";
			
		var dtlSize =	"<tr>" +
							"<th><input type='text' class='name' placeholder='총장'></th>" +
							"<td><input type='text' class='value' placeholder='100'> <span onClick='remove(this,\"y\")'> x 상세삭제</span></td>"
						"</tr>";
		
		function plusSize(t) {
			$(t).before(size);
		}
		
		function plusDtlSize(t) {
			$(t).parent("tr").before(dtlSize);
			}
		
		function remove(t, dtl) {
			if (dtl == "") $(t).parents("table").remove();
			else $(t).parents("tr").remove();
		}
		
		function category(type, ctg, t) {
			
			$("input[name=cd_ctg]").val("");
			
			if (ctg == 1) {
				$(".sub").css("display","block");
				$(".onlyW").css("display","inline-block");
				$(".cd_ctg span").removeClass("active");
			}
			else if (ctg == 2) {
				$(".onlyW").hide();
				$(".sub").show;
				$(".cd_ctg span").removeClass("active");
			}
			else {
				$(t).siblings("span").removeClass("active");
				$("input[name=cd_ctg]").val(ctg);
			}
			
			$(t).addClass("active");
		}
		
		var maxSize = 5 * 1024 * 1024; // 5MB
		
		function readURL(input) {
			$(".mainImg > div > div").show();
			
			if (input.files && input.files[0]) {
				if (input.files[0].size > maxSize) {
					alert("첨부파일은 5MB 이내로 등록 가능합니다");
					$(input).val("");
					$(".mainImg > div > div").hide();
				}
				else {
					var reader = new FileReader();
					reader.onload = function(e) {
						$("#preview").attr("src",e.target.result);
					};
					reader.readAsDataURL(input.files[0]);
				}
			} else {
				document.getElementById('preview').src = "";
			}
		}
		
		function readDtlURL(input){
			$("#previewDtl").show();
			
			var inputIndex = $(input).attr("data-value");
			
			if (input.files.length == 0) {
				$("#previewDtl .dtlImg_" + inputIndex).hide();
			}
			else if (input.files && input.files[0]) {
				if (input.files[0].size > maxSize) {
					alert("첨부파일은 5MB 이내로 등록 가능합니다");
					$(input).val("");
					$("#previewDtl").hide();
				} else {
					var reader = new FileReader();
					reader.onload = function(e) {
						$("#previewDtl .dtlImg_" + inputIndex).attr("src",e.target.result);
						$("#previewDtl .dtlImg_" + inputIndex).show();
					};
					reader.readAsDataURL(input.files[0]);
				}
			} else {
				document.getElementById('previewDtl').src = "";
			}
		}
		
		function readInfoURL(input) {
			$(".infoImg > div > div").show();
			
			if (input.files && input.files[0]) {
				if (input.files[0].size > maxSize) {
					alert("첨부파일은 5MB 이내로 등록 가능합니다");
					$(input).val("");
					$(".infoImg > div > div").hide();
				} else {
					var reader = new FileReader();
					reader.onload = function(e) {
						$("#previewInfo").attr("src",e.target.result);
					};
					reader.readAsDataURL(input.files[0]);
				}
			} else {
				document.getElementById('preview').src = "";
			}
		}
		
		var imgCount = 2;
		function plusImg(t) {
			if (imgCount < 11) {
				var imgTag = "<input type='file' name='files[" + imgCount + "]' id='files_" + imgCount + "' onchange='readDtlURL(this);' data-value='" + imgCount + "' accept='image/gif, image/jpeg, image/png' style='width:100%;margin-top:5px;'>";
				$(t).before(imgTag);
				imgCount++;
			}
			else {
				alert("이미지는 최대 10개까지 등록 가능합니다");
			}
		}
		
		function modifyImg(t, type) {
			
			if (type == 'list') {
				var modifyHtml =	"<input type='file' name='files[0]' id='files_0' onchange='readURL(this);' accept='image/gif, image/jpeg, image/png' value='${saleDto.img}' required>" +
									"<div><img id='preview'></div>";
				$("input[name=chgMainImg]").val("Y");
			}
			else if(type == 'detail') {
				var imgHtml = "";
				for (var loop = 1; loop <= 10; loop++) {
					imgHtml += "<img class='dtlImg_" + loop + "'>";
				}
				var modifyHtml =	"<div id='previewDtl'>" +
										"<input type='file' name='files[1]' id='files_1' onchange='readDtlURL(this);' data-value='1' accept='image/gif, image/jpeg, image/png'>" +
										"<p class='pButton' onClick='plusImg(this)'>+ 이미지 추가</p>" +
										"<div id='previewDtl'>" +
											imgHtml +
										"</div>" +
									"</div>";
				$("input[name=chgDtlImg]").val("Y");
			}
			else if (type == 'info') {
				var modifyHtml =	"<input type='file' name='files[11]' id='files_11' onchange='readInfoURL(this);' accept='image/gif, image/jpeg, image/png'>" +
									"<div><img id='previewInfo'></div>";
				$("input[name=chgInfoImg]").val("Y");
			}
			$(t).after(modifyHtml);
		}
		
		function complete() {
		
			if ($("#sle_nm").val() == "") {
				alert("상품명을 입력해주세요");
				$("#sle_nm").focus();
				return;
			}
			if ($("#cd_ctg").val() == "") {
				alert("카테고리를 선택해주세요");
				return;
			}
			if ($("#price_cost").val() == "" || $("#price_cost").val() <= 0) {
				alert("가격을 입력해주세요");
				$("#price_cost").focus();
				return;
			}
			if ($("#discount").val() == "" || $("#discount").val() < 0) {
				alert("할인율을 입력해주세요\n정상가로 판매할 상품은 0을 입력해주세요");
				$("#discount").focus();
				return;
			}
			if ($("#desces").val() == "") {
				alert("상품 설명을 입력해주세요");
				$("#desces").focus();
				return;
			}
			if ($("#color").val() == "") {
				alert("색상을 입력해주세요");
				$("#color").focus();
				return;
			}
			if ($("#merterial").val() == "") {
				alert("소재를 입력해주세요");
				$("#merterial").focus();
				return;
			}
			if ($("#files_0").val() == "") {
				alert("리스트 이미지를 선택해주세요");
				$("#img").focus();
				return;
			}
			if ($(".dtlImg input[name^=files]").length == 1 && $("#files_1").val() == "") {
				alert("미리보기 이미지를 하나 이상 선택해주세요");
				return;
			} else if ($(".dtlImg input[name^=files]").val() == "") {
				if (!confirm("미리보기 이미지에 선택되지 않은 항목이 있습니다.\n이대로 진행하시겠습니까?'")) {
					return
				}
			}
			if ($("#files_11").val() == "") {
				alert("상품 정보 이미지를 선택해주세요");
				$("#img").focus();
				return;
			}
			
			var totalSize = [];
			var eachSize = [];
			var detailSize = [];
			var totalCount = [];
			var table = $(".size table");
			
			for (var i = 0; i < table.length; i++) {
				var tr = table.eq(i).find("tr");
				
				for (var j = 0; j < tr.length - 1; j++) {
					
					if (j > 0) {
						var dtlValue = tr.eq(j).find(".name").val() + "/" + tr.eq(j).find(".value").val();
						eachSize.push(dtlValue);
						if (tr.eq(j).find(".name").val() == "" || tr.eq(j).find(".value").val() == "") {
							alert("상세 사이즈를 모두 입력해주세요");
							return;
						}
					}
					else {
						var value = tr.find(".eachSize").val().toUpperCase();
						if (value == "") {
							alert("상세 사이즈를 모두 입력해주세요");
							return;
						}
						totalSize.push(value);	
					}
				}

				var _eachCount = tr.find(".eachCount").val();
				if (_eachCount == "") {
					alert("재고 수량을 모두 입력해주세요");
					return;
				}
				totalCount.push(_eachCount);
				detailSize.push(eachSize.join("&"));
				eachSize = [];
			}
			$("#size_nm").val(totalSize.join("/"));
			$("#size_detail").val(detailSize.join(","));
			$("#count_stock").val(totalCount.join("/"));
			
			if ($("#size_nm").val() == "") {
				alert("사이즈를 입력해주세요");
				$("#size").focus();
				return;
			}
			if ($("table input").val() == "" || $("table:nth-child(1) tr").length == 1) {
				alert("상세사이즈를 입력해주세요");
				return;
			}
			if ($("#dt_sale_start").val() == "") {
				alert("판매시작일을 입력해주세요");
				$("#dt_sale_start").focus();
				return;
			}
			
			$("#frmMain").attr("action", "/seller/sale/modifyProc.web");
			$("#frmMain").submit();
		}
	</script>
</head>
	
<body>
	<!-- Header Section Begin -->
	<header class="header">
		<%@ include file="/include/seller/top.jsp" %>
	</header>
	<!-- Header Section End -->
	
	<div class="container">
		<nav></nav>
		<article class="saleWrite">
			<h3>상품 수정</h3>
			<form id="frmMain" name="frmMain" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="seq_sle" value="${saleDto.seq_sle}">
				<input type="hidden" name="cd_ctg" id="cd_ctg" value="${saleDto.cd_ctg}">
				<input type="hidden" name="size_nm" id="size_nm" value="${saleDto.size_nm}">
				<input type="hidden" name="size_detail" id="size_detail" value="${saleDto.size_detail}">
				<input type="hidden" name="chgMainImg" value="N">
				<input type="hidden" name="chgDtlImg"  value="N">
				<input type="hidden" name="chgInfoImg" value="N">
				<input type="hidden" name="count_stock" id="count_stock" value="${saleDto.count_stock}">
				<div class="write">
					<div class="sle_nm">
						<p>상품명</p>
						<div><input type="text" name="sle_nm" id="sle_nm" placeholder="상품명을 입력해주세요." value="${saleDto.sle_nm}" required></div>
					</div>
					<div class="cd_ctg">
						<p>카테고리</p>
						<div>
							<div class="main">
								<span onClick="category('main',1,this)"<c:if test="${saleDto.cd_ctg.substring(0,1) == 1}"> class="active"</c:if>>여성</span>
								<span onClick="category('main',2,this)"<c:if test="${saleDto.cd_ctg.substring(0,1) == 2}"> class="active"</c:if>>남성</span>
							</div>
							<div class="sub">
								<span onClick="category('sub',11,this)"<c:if test="${saleDto.cd_ctg.substring(1,2) == 1}"> class="active"</c:if>>아우터</span>
								<span onClick="category('sub',12,this)"<c:if test="${saleDto.cd_ctg.substring(1,2) == 2}"> class="active"</c:if>>재킷/베스트</span>
								<span onClick="category('sub',13,this)"<c:if test="${saleDto.cd_ctg.substring(1,2) == 3}"> class="active"</c:if>>상의</span>
								<span onClick="category('sub',14,this)"<c:if test="${saleDto.cd_ctg.substring(1,2) == 4}"> class="active"</c:if>>하의</span>
								<span onClick="category('sub',15,this)" class="<c:if test="${saleDto.cd_ctg.substring(1,2) == 5}">active</c:if> onlyW">원피스</span>
								<span onClick="category('sub',16,this)"<c:if test="${saleDto.cd_ctg.substring(1,2) == 6}"> class="active"</c:if>>패션잡화</span>
							</div>
						</div>
					</div>
					<div class="price_cost">
						<p>가격 / 할인율(%)</p>
						<input type="text" name="price_cost" id="price_cost" placeholder="가격을 입력해주세요" value="${saleDto.price_cost}" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
						<input type="text" name="discount" id="discount" maxlength="3" placeholder="ex)10" value="${saleDto.discount}" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					</div>
					<div class="desces">
						<p>상품 설명</p>
						<textarea name="desces" id="desces" placeholder="상품 설명을 입력해주세요" required maxlength="2048">${saleDto.desces}</textarea>
					</div>
					<div class="color">
						<p>색상</p>
						<input type="text" name="color" id="color" placeholder="색상을 입력해주세요" value="${saleDto.color}" required>
					</div>
					<div class="merterial">
						<p>소재</p>
						<input type="text" name="merterial" id="merterial" placeholder="소재를 입력해주세요" value="${saleDto.merterial}" required>
					</div>
					<div class="mainImg">
						<p>리스트 이미지</p>
						<div>
							<div id="viewList">
								<p> 기존 등록 이미지</p>
								<img src="/img/sale/${saleDto.img}">
							</div>
							<p class="modifyImg" onClick="modifyImg(this, 'list')">이미지 수정하기</p>
							<p class="explain">* 상품 리스트에 보여질 대표 이미지를 등록해주세요</p>
						</div>
					</div>
					<div class="dtlImg">
						<p>미리보기 및<br>상품 이미지</p>
						<div>
							<div id="viewDtl">
								<p>기존 등록 이미지</p>
								<c:forEach items="${imgList}" var="imgList" varStatus="status">
									<c:if test="${not status.last}">
										<img class="dtlImg" src="/img/sale/${imgList.img}">
									</c:if>
								</c:forEach>
							</div>
							<p class="modifyImg" onClick="modifyImg(this, 'detail')">이미지 수정하기</p>
							<p class="explain">
								* 상세페이지에서 보여질 옷 이미지를 등록해주세요<br>
								* 해당 이미지는 상단 썸네일과 하단 상품정보 두 곳에서 보여집니다<br>
								* 이미지는 등록된 순서대로 보여집니다.
							</p>
						</div>
					</div>
					<div class="infoImg">
						<p>상품 정보 이미지</p>
						<div>
							<div id="viewInfo">
								<p>기존 등록 이미지</p>
								<img src="/img/sale/${infoImg}">
							</div>
							<p class="modifyImg" onClick="modifyImg(this, 'info')">이미지 수정하기</p>
							<p class="explain">
								* 상세페이지에 보여질 상품 정보 이미지를 등록해주세요.<br>
								* 해당 이미지는 상품이미지 하단에 보여집니다.<br>
								* 하나의 이미지를 등록해 주세요
							</p>
						</div>
					</div>
					<div class="size">
						<p>사이즈</p>
						<div>
							<p class="pButton" onClick="plusSize(this)">+ 사이즈 추가</p>
						</div>
					</div>
					<div class="dt_sale_start">
						<p>판매 시작일</p>
						<input type="date" name="dt_sale_start" id="dt_sale_start" value="${saleDto.dt_sale_start.substring(0,10)}" required>
					</div>
				</div>
				<div id="btnArea">
					<input type="button" value="수정" onClick="complete()">
					<a href="javascript:history.back()">취소</a>
				</div>
			</form>
		</article>
	</div>
	
	<!-- Footer Section Begin -->
	<%@ include file="/include/common/footer.jsp" %>
	<!-- Footer Section End -->
</body>
</html>