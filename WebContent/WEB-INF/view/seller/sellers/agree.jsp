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
 *				: [20240626130000][dhtjgml87@himedia.co.kr][CREATE: Initial Release]
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page info="/WEB-INF/view/seller/sellers/agree.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/include/front/header.jsp" %>
	<style>
		.agree {width:550px;margin:50px auto 100px;padding:30px 20px;text-align:center;}
		.agree h3 {margin:0 0 50px;}
		
		.agreeArea {text-align:left;}
		
		#allTerm ~ label {font-weight:bold;}
		
		textarea {width:100%;height:200px;padding:5px 5px 0 3px;resize:none;overflow-y:scroll;
				/* firefox - scrollbar style */
				scrollbar-width: 3px;
				scrollbar-color: #ccc;
		}
		/* chrome & edge & safari & opera - scrollbar style */
		textarea::-webkit-scrollbar {
			width: 5px;
			transition: width 2s;
		}
		textarea::-webkit-scrollbar-thumb {
			background-color: #ccc;
			border-radius: 5px;
		}
		
		input[type=button] {display:block;width:300px;height:50px;margin:30px auto 0;line-height:50px;background:#007bff;color:white;border-radius:10px;border:none;}
		
		@media all and (max-width:479px) {
			.agree {width:100%;}
		}
	</style>
	<script>
		window.onload = function () {
			
			// 전체 동의 클릭시
			$("#allTerm").on("click", function() {
				console.log($(this).prop("checked"));
				if ($(this).prop("checked")) {
					$("input[name^=term]").prop("checked", true);
				}
				else {
					$("input[name^=term]").prop("checked", false);
				}
			});
			
			// 각 동의 항목 클릭시
			$("input[name^=term]").on("click", function() {
				var chkLength = $("input[name^=term]:checked").length;		// 전체 동의 제외 체크된 체크박수 수
				
				if (chkLength == 3) $("#allTerm").prop("checked", true);
				else $("#allTerm").prop("checked", false);
			})
		}
		
		function goRegister() {
			$frm = $("#frmMain");
			
			if ($("input[name=term_1]").prop("checked")) {
				$frm.attr("action", "/seller/sellers/registerForm.web");
				$frm.submit();
			}
			else {
				alert("필수 약관에 동의해주세요!");
			}
		}
	</script>
</head>
<body>
	<header class="header">
		<%@ include file="/include/front/top.jsp" %>
	</header>
	
	<section class="content">
		<nav></nav>
		<article class="agree">
			<h3>이용약관</h3>
			<form id="frmMain" name="frmMain" method="POST">
				<div class="agreeArea">
					<p>
						<input type="checkbox" id="allTerm">
						<label for="allTerm">전체 동의</label>
					</p>
					<p>
						<input type="checkbox" id="term_1" name="term_1" value="Y">
						<label for="term_1">[필수] 이용 약관</label>
						<textarea>
제1조 (목적)
본 약관은 (주)Uranus(이하 “회사”)가 제공하는 Challenge Farm에 판매자로 가입하여 회사가 제공하는 전자상거래 관련 서비스 및 기타 서비스(이하 “서비스”)를 이용하여 재화 또는 용역 등(이하 "상품 등")을 판매하는 자(이하 “판매자”) 간의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.

제2조 (정의)
이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1) “판매자센터”란 회사가 판매자에게 제공하는 판매 운영관리 서비스로, 판매자는 판매자센터에서 상품관리, 주문관리, 정산관리 등의 기능을 사용할 수 있습니다.
2) "판매자 할인"이란 판매자가 판매자의 부담으로 구매자에게 제공하는 모든 할인 수단을 말합니다. 판매자할인에는 상품에 설정하는 각종 상품 할인(판매자 즉시할인, 소문내면 할인, 톡딜 할인)과 판매자 할인쿠폰이 있습니다.
3) “판매자 즉시할인”은 판매자가 판매자센터에서 특정 상품의 할인액 또는 할인율을 직접 입력하여 구매자가 상품대금에서 할인 받을 수 있는 할인 수단을 말합니다.
4) "이용자"란 회사가 제공하는 모바일 어플리케이션 또는 모바일 웹 및 PC웹 사이트 등에서 스토어를 이용하는 사용자를 말합니다.
5) "구매자"란 판매자가 판매하는 상품을 구입할 의사를 회사가 온라인으로 제공하는 양식에 맞추어 밝힌 이용자를 말합니다.
6) “스토어”란 판매자센터를 통해 판매자가 등록하는 상품 등을 노출하는 서비스 단위를 말합니다.
7) “API 서비스”는 회사와 제휴 관계의 외부 전자상거래 솔루션을 통해 스토어의 상품과 주문을 관리할 수 있도록 상품등록, 상품수정, 주문 등을 연동하는 API를 제공하고 운영하는 것을 말합니다.
8) “API 인증키”란 관련 시스템이 API 이용 승낙을 받은 판매자임을 식별할 수 있도록 회사가 판매자별로 할당하는 고유한 값을 말합니다.

제3조 (약관의 명시 및 변경)
1) 회사는 본 약관의 내용, 상호, 대표자 성명, 연락처(전화, 전자우편주소 등), 사업자등록번호 등을 판매자가 쉽게 알 수 있도록 판매자센터 서비스 화면에 게시합니다.
2) 회사는 “전자상거래 등에서의 소비자보호에 관한 법률(이하 “전상법”)”, “정보통신망 이용촉진 및 정보보호 등에 관한 법률”, “소비자보호법” 등 관계 법령에 위배되지 않는 범위에서 본 약관을 개정할 수 있습니다.
3) 회사가 본 약관을 개정할 경우에는 적용일자 및 변경사유를 명시하여 현행 약관과 함께 서비스 내의 적절한 장소에 개정약관의 적용일자 칠(7)일 전부터 적용일자 이후 상당한 기간 동안 공지합니다. 다만, 변경 내용이 판매자에게 불리하거나 서비스 이용료‧수수료율 변경 등 중요한 계약 내용이 변경되는 경우에는 적용일자 삼십(30)일 전부터 적용일 이후 상당한 기간 동안 공지합니다. 또한, 변경 내용이 판매자에게 불리하거나 회사가 필요하다고 판단되는 경우, 판매자가 가입 시 기재한 이메일 주소 또는 카카오톡 메시지로 개별 고지 합니다.
4) 회사가 전항에 따라 개정약관을 공지 또는 통지하면서 판매자에게 약관 변경 적용일까지 거부의사를 표시하지 아니할 경우, 약관의 변경에 동의한 것으로 간주한다는 뜻을 명확하게 공지 또는 통지하였음에도 판매자가 명시적으로 거부의사를 표명하지 아니한 경우 판매자가 개정약관에 동의한 것으로 봅니다.
5) 판매자가 개정약관의 내용에 동의하지 않는 경우 회사는 해당 판매자에 대하여 개정약관의 내용을 적용할 수 없으며, 이 경우 판매자는 이용계약을 해지할 수 있습니다. 다만, 회사가 개정약관에 동의하지 않은 판매자에게 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 회사는 해당 판매자와의 이용계약을 해지할 수 있습니다.

제4조 (약관의 효력)
1) 회사는 본 약관에 규정되지 않은 세부적인 내용에 대해 <Challenge Farm 가이드>(이하 “가이드”)에서 정할 수 있고, 해당 내용을 판매자센터를 통하여 게시합니다.
2) 본 약관에 의해 판매자로 가입하고자 하는 자는 이용자가 동의하는 <Challenge Farm 이용약관>의 내용을 숙지하고, 이용자와 회사 간의 권리∙의무관계에 대해 이를 확인하고 준수할 것임을 확인합니다.
3) 제1항 및 제2항에 따른 <가이드>, <Challenge Farm 이용약관>은 이 약관과 더불어 서비스 이용계약(이하 “이용계약”)의 일부를 구성하고, 이 약관과 <가이드>에서 정하지 않은 사항은 <Challenge Farm 이용약관>을 따르며 <Challenge Farm 이용약관>에서 정하지 않은 사항은 관련 법령과 상관례, 판매자가 동의한 <Challenge Farm 약관>에 따릅니다.
4) 이 약관과 관련하여 당사자가 서로 합의하여 추가로 작성한 계약서, 협정서, 약정서 등과 같은 개별 계약 등은 이용계약의 일부를 구성합니다. 이 경우 개별 계약과 본 약관이 상충하는 경우 개별 계약이 우선 적용됩니다.
						</textarea>
					</p>
					<p>
						<input type="checkbox" id="term_2" name="term_2" value="Y">
						<label for="term_2">[필수] 스토어의 이용 및 관리</label>
						<textarea>
1) 스토어를 통한 상품 등의 등록 및 판매는 회사의 판매자 가입 승인 이후에 가능하며, 판매자는 상품 등에 대한 정보를 판매자센터를 통하여 직접 등록, 관리하여야 합니다. 이때 판매하는 상품 등의 종류와 범위, 판매 가격, 거래조건은 서비스 이용료, 배송비, 각종 부가서비스 이용료 등을 고려하여 판매자가 스스로 결정하고, 회사는 이에 부당하게 관여하지 아니합니다. 다만 회사는 상품대금 결제 방식, 상품 배송 방식, 취소 반품 교환 방식 등 구매자 피해방지에 관한 사항을 약관 등으로 정할 수 있습니다.
2) 판매자는 상품 등을 등록 시 ➀ 품목별 재화 등에 관한 정보, ➁ 거래조건에 관한 정보 등 ‘전자상거래 등에서의 상품 등의 정보제공에 관한 고시’(이하 ‘상품정보제공 고시’)에서 정한 정보를 입력하여야 하고, 상품 등을 등록 후 상품정보제공 고시가 변경되는 경우 그에 맞추어 관련 정보를 수정, 보완하여야 합니다.
3) 판매자는 등록 상품에 특별한 거래조건이 있거나 추가되는 비용이 있는 경우 구매자가 이를 알 수 있도록 명확하게 기재하여야 합니다.
4) 판매자는 상품 등의 재고 수량 등 수시로 변동되는 사항에 대한 데이터를 판매자센터를 통해 적절히 관리하여야 하며, 판매자센터에 허위의 데이터를 기재할 수 없습니다.
5) 판매자는 스토어 이용시 필요한 스토어 정보를 입력함에 있어 <가이드>의 내용을 준수해야 합니다.
6) 회사는 판매자 센터 시스템의 정상적이고 효율적인 운영을 위하여, 판매자에 대한 사전통지로써 판매자 당 상품 등록 건수를 제한할 수 있습니다. 구체적인 제한 시기, 내용, 방법 등은 판매자가 알 수 있도록 사전에 판매자 센터를 통해 게시합니다.
7) 회사는 판매자가 등록한 상품 또는 스토어 정보 등에 대하여 본 약관 및 <가이드> 등을 준수하지 않은 경우 구매자 편의 개선 등을 위하여 별도 통지 없이 일부 서비스 등에서 노출 제외 처리를 할 수 있습니다. 단, 판매자가 이를 개선하는 경우 노출 제외 처리를 즉시 해제합니다.
8) 판매자가 회사의 판매자센터를 통하지 않고 제3자의 프로그램을 이용하여 상품 등의 등록, 주문 조회, 배송 처리 등의 업무를 하는 경우, 그 과정에서 유발되는 각종 기술적, 법적 문제에 대해 회사는 아무런 책임을 지지 아니하며 이로 인해 발생되는 모든 손해에 대해 판매자가 전적으로 부담합니다.
9) 판매자는 판매자센터를 주문 조회, 배송 처리 등의 회사가 정한 목적에 한하여 이용할 수 있으며, 판매자센터를 통해 제공된 정보를 관련법령 및 이 약관과 개인정보처리방침에서 정의하는 것 이외의 목적으로 제3자에게 제공할 수 없습니다.
10) 판매자는 구매자의 문의에 성실, 정확히 답변해야 하며, 판매자의 부정확하거나 불성실한 답변으로 인하여 발생하는 모든 책임과 의무는 판매자 본인에게 있습니다.
11) 구매자가 작성한 문의글 또는 상품평을 삭제하는 경우 판매자가 해당 글에 대해 작성한 답변글도 삭제될 수 있습니다. 단, 관계법령에 따라 삭제된 게시글은 작성일로부터 3년간 보관됩니다.
12) 회사는 상품 리뷰에 대한 삭제 또는 임시조치 기준, 판매자의 리뷰 게시 중단 요청 절차 등의 구체적인 정책을 수립하고 판매자센터 또는 안전거래센터를 통해서 판매자에게 안내 합니다.
13) 판매자가 상품 등을 등록 후 1년 이상 거래내역이 없는 상품의 경우 회사는 별도 통지 없이 검색의 효율성 제고 및 구매자 편의 개선을 위해 해당 상품을 삭제하거나 판매중지 처리할 수 있습니다.
14) 판매자가 휴업 또는 폐업한 경우 상품 등의 전시 및 등록 또는 수정이 제한될 수 있습니다.
15) 회사는 이용자의 검색에 따라 판매자 또는 판매자의 상품이 노출되는 순서에 고려되는 주요 기준(노출 순서가 결정되는 구체적인 방식, 절차, 알고리즘 등은 제외합니다. 서비스 정책에 따라 주요 기준은 변경될 수 있으며, 회사는 주요 기준 외에도 노출 순서에 적절한 기준을 반영할 수 있습니다)을 판매자센터 또는 서비스화면을 통해 안내합니다.
16) API 서비스를 이용하고자 하는 판매자는 API 인증키를 발급 받아야 하며, 발급 받은 인증키를 이용하여 API 서비스를 제공 받을 수 있습니다.
17) 기타 스토어의 이용 및 관리에 대한 구체적인 내용은 <가이드>에 따릅니다.
						</textarea>
					</p>
					<p>
						<input type="checkbox" id="term_3" name="term_3" value="Y">
						<label for="term_3">[필수] 개인정보</label>
						<textarea>
1) 판매자는 서비스의 이용에 따라 취득한 구매자 등 타인의 개인정보를 법률, 이 약관 또는 회사의 개인정보처리방침에서 정한 목적 이외의 용도로 사용하거나 제3자에게 제공하는 등 외부에 유출할 수 없으며, 관련 법령 등에 따라 철저히 보호하여야 합니다.
2) 판매자는 회사가 제공하는 구매자의 정보에 대해 기본 계약의 제공 목적에 직접 해당하는 업무 외에 다른 용도로 사용할 수 없으며, 제3자에게 임의로 제공하거나 누설하지 않습니다.
3) 회사는 구매자의 개인정보 등을 보호하기 위하여 주문처리를 목적으로 판매자에게 공개되어 있는 구매자의 개인정보를 일부 비공개 처리하여 제공하거나, 상당 기간이 경과한 후 일부 또는 전부를 비공개 조치할 수 있습니다. 이에 대한 구체적인 내용은 안전거래 가이드에 따릅니다.
4) 회사는 판매자가 관계 법령에서 정하는 기간 동안 카카오계정 로그인 혹은 접속한 기록이 없는 경우, 카카오계정 휴면 정책에 따라 처리합니다.
5) 판매자가 고의 또는 과실로 본 조를 위반하여 구매자 등으로부터 분쟁이 발생하는 경우 자신의 노력과 비용으로 회사를 면책시켜야 하며, 민/형사 상 일체의 법적 책임을 부담하여야 합니다.
						</textarea>
					</p>
				</div>
				<input type="button" onclick="goRegister()" value="다음">
			</form>
		</article>
		<aside></aside>
	</section>
	
	<%@ include file="/include/common/footer.jsp" %>
		
</body>
</html>