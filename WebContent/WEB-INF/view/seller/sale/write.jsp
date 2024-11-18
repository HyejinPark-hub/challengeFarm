<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/front/center/board/faq/list.jsp" %>
<!DOCTYPE html>
<html lang="kr">
<head>
	<%@ include file="/include/seller/header.jsp" %>
	<link rel="stylesheet" type="text/css" title="common stylesheet" href="/css/sale/main.css" />
	
	<script>
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
							"<td><input type='text' class='value' placeholder='100'><span onClick='remove(this,\"y\")'> x 상세삭제</span></td>"
						"</tr>";
				
		window.onload = function (){
			
		}
		
		function plusSize(t) {
			$(t).before(size);
		}
		
		function plusDtlSize(t) {
			$(t).parent("tr").before(dtlSize);
		}
		
		function remove(t, dtl) {
			if (dtl == "")
				$(t).parents("table").remove();
			else
				$(t).parents("tr").remove();
		}
		
		function category(type, ctg, t) {

			$("input[name=cd_ctg]").val("");
			$(".sub").css("display","block");
			
			if (ctg == 1) {
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
			var countStock = [];
			var table = $(".size table");
			
			for (var i = 0; i < table.length; i++) {
				var tr = table.eq(i).find("tr");
				
				for (var j = 0; j < tr.length - 1; j++) {
					
					if (j > 0) {
						var dtlValue = tr.eq(j).find(".name").val() + "/" + tr.eq(j).find(".value").val();		// 총장/1
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

				var eachCount = tr.find(".eachCount").val();
				if (eachCount == "") {
					alert("재고 수량을 모두 입력해주세요");
					return;
				}
				countStock.push(eachCount);
				detailSize.push(eachSize.join("&"));
				
				eachSize = [];
			}
			$("#size_nm").val(totalSize.join());
			$("#size_detail").val(detailSize.join(","));
			$("#count_stock").val(countStock.join("/"));
			
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
			
			$("#frmMain").attr("action", "/seller/sale/writeProc.web");
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
			<h3>상품 등록</h3>
			<form id="frmMain" name="frmMain" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="cd_ctg" id="cd_ctg">
				<input type="hidden" name="size_nm" id="size_nm">
				<input type="hidden" name="size_detail" id="size_detail">
				<input type="hidden" name="count_stock" id="count_stock">
				<div class="write">
					<div class="sle_nm">
						<p>상품명</p>
						<div><input type="text" name="sle_nm" id="sle_nm" placeholder="상품명을 입력해주세요." required></div>
					</div>
					<div class="cd_ctg">
						<p>카테고리</p>
						<div>
							<div class="main">
								<span onClick="category('main',1,this)">여성</span>
								<span onClick="category('main',2,this)">남성</span>
							</div>
							<div class="sub" style="display:none;">
								<span onClick="category('sub',11,this)">아우터</span>
								<span onClick="category('sub',12,this)">재킷/베스트</span>
								<span onClick="category('sub',13,this)">상의</span>
								<span onClick="category('sub',14,this)">하의</span>
								<span onClick="category('sub',15,this)" class="onlyW" style="display:none;">원피스</span>
								<span onClick="category('sub',16,this)">패션잡화</span>
							</div>
						</div>
					</div>
					<div class="price_cost">
						<p>가격 / 할인율(%)</p>
						<input type="text" name="price_cost" id="price_cost" placeholder="가격을 입력해주세요" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
						<input type="text" name="discount" id="discount" maxlength="3" placeholder="ex)10" required oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
					</div>
					<div class="desces">
						<p>상품 설명</p>
						<textarea name="desces" id="desces" placeholder="상품 설명을 입력해주세요" required maxlength="2048"></textarea>
					</div>
					<div class="color">
						<p>색상</p>
						<input type="text" name="color" id="color" placeholder="색상을 입력해주세요" required>
					</div>
					<div class="merterial">
						<p>소재</p>
						<input type="text" name="merterial" id="merterial" placeholder="소재를 입력해주세요" required>
					</div>
					<div class="mainImg">
						<p>리스트 이미지</p>
						<div>
							<input type="file" name="files[0]" id="files_0" onchange="readURL(this);" accept="image/gif, image/jpeg, image/png" required>
							<div style="display:none;"><img id="preview"></div>
							<p class="explain">* 상품 리스트에 보여질 대표 이미지를 등록해주세요</p>
						</div>
					</div>
					<div class="dtlImg">
						<p>미리보기 및<br>상품 이미지</p>
						<div>
							<input type="file" name="files[1]" id="files_1" onchange="readDtlURL(this);" data-value="1" accept="image/gif, image/jpeg, image/png">
							<p class="pButton" onClick="plusImg(this)">+ 이미지 추가</p>
							<div id="previewDtl" style="display:none;">
								<img class="dtlImg_1">
								<img class="dtlImg_2">
								<img class="dtlImg_3">
								<img class="dtlImg_4">
								<img class="dtlImg_5">
								<img class="dtlImg_6">
								<img class="dtlImg_7">
								<img class="dtlImg_8">
								<img class="dtlImg_9">
								<img class="dtlImg_10">
							</div>
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
							<input type="file" name="files[11]" id="files_11" onchange="readInfoURL(this);" accept="image/gif, image/jpeg, image/png">
							<div style="display:none;"><img id="previewInfo"></div>
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
						<input type="date" name="dt_sale_start" id="dt_sale_start" required>
					</div>
				</div>
				<div id="btnArea">
					<input type="button" value="등록" onClick="complete()">
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