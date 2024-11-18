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
<%@ page info="/WEB-INF/view/front/member/agree.jsp" %>
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
				$frm.attr("action", "/front/member/registerForm.web");
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
						<label for="term_1">[필수]온라인사이트 이용약관</label>
						<textarea>
제1조 (목적)
이 약관은 Uranus 주식회사(이하 "회사"라 합니다)의 패션부문이 운영하는 
인터넷 쇼핑몰 Challenge Farm (이하 "CF”라 합니다)에서 제공하는 
인터넷 관련 서비스(이하 "서비스"라 합니다)를 이용함에 있어 
"회사"와 "이용자"의 권리 · 의무 및 책임사항을 규정함을 목적으로 합니다.

제2조 (정의)
① "CF"라 함은 "회사"가 “Challenge Farm”이라는 명칭 하에 재화 또는 용역(이하 "재화 등"이라 합니다)을 "이용자"에게 제공하기 위하여 컴퓨터, 모바일 등 정보통신설비를 이용하여 "재화 등"을 거래할 수 있도록 설정한 한글로 운영되는 가상의 영업장을 말합니다.
② "이용자"라 함은 “CF”에 접속하여 이 약관에 따라 "회사"가 제공하는 "재화 등"의 "서비스"를 받는 "회원" 및 "비회원"을 말합니다.
③ "회원"이라 함은 "회사"가 운영하는 “CF”에 "회원" 등록을 한 자로서, 계속적으로 “CF”의 "서비스"를 제공받으며 이용할 수 있는 자를 말합니다.
④ "비회원"이라 함은 "회사"가 운영하는 “CF”에서 모두 "회원" 가입을 하지 않고 “CF”이 제공하는 "서비스"를 이용하는 자를 말합니다.
⑤ "영업일"이라 함은 토요일과 공휴일(관공서공휴일규정에 따름)을 제외한 일자를 의미합니다. 단, 본 약관에서 "영업일"이 아닌 "일"로 기재된 경우, 각 기간의 말일이 토요일 또는 공휴일에 해당하더라도 동 기간은 그 날로 만료합니다.

제3조 (약관 등의 명시와 설명 및 개정)
① "회사"는 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호, 전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자 등을 "이용자"가 쉽게 알 수 있도록 “CF”의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 "이용자"가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.
② "회사"는 "이용자"가 이 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회, 배송책임, 환불조건 등과 같은 중요한 내용을 "이용자"가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 "이용자"의 확인을 구하여야 합니다.
③ "회사"는 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」, 「개인정보보호법」 등 관련 법령을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.
④ "회사"가 이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행 약관과 함께 “CF”의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, "이용자"에게 불리하게 이 약관의 내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "회사"는 개정 전 내용과 개정 후 내용을 명확하게 비교하여 "이용자"가 알기 쉽도록 표시합니다.
⑤ "회사"가 이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다.
⑥ 이 약관에서 정하지 아니한 사항에 관하여는 “CF”에 게재하는 기타의 약관, 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제 등에 관한 법률」, 공정거래위원회가 정하는 「전자상거래 등에서의 소비자 보호지침」 등의 관계법령 또는 상 관례에 따릅니다.						
						</textarea>
					</p>
					<p>
						<input type="checkbox" id="term_2" name="term_2" value="Y">
						<label for="term_2">[선택]제 3자 개인 정보 제공 동의</label>
						<textarea>
Challenge Farm 회원가입을 신청하시는 고객분께 개인정보보호법에 근거하여 수집하는 개인정보 항목 및 이용목적, 보유 및 이용기간, 동의 거부 시 불이익을 안내 드립니다. 자세히 읽어보시고 동의해주시기 바랍니다.

1. 수집하는 개인정보 항목
(1) 개인정보의 수집항목
1) 회사는 회원가입, 원활한 고객상담 및 서비스의 제공을 위해 아래와 같은 개인정보를 수집하고 있습니다.
<온라인 전용 회원>
- 필수사항 : 이름, 휴대폰번호, 이메일, 아이디, 비밀번호

2) 서비스 이용과정 또는 처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
- 서비스 이용기록, 접속로그, 쿠키, 접속IP정보, 앱아이디, 앱버전, 앱 인스톨날짜, 앱 업데이트 날짜, 디바이스명, OS명, OS 버전, 국가코드, 사용하는 언어, 사용자 번호
※ 이벤트 등을 통해 추가적인 개인정보를 수집하여야 할 경우, 회사는 수집항목에 대해 필수/선택을 구분하여 해당 페이지 및 서면 등에서 개인정보의 수집목적, 보유기간 등을 고객에게 고지하고 별도의 추가적 동의를 받도록 하겠습니다.

2. 개인정보의 수집 및 이용목적
회사는 다음의 목적을 위해 개인정보를 처리합니다. 회사가 수집한 개인정보는 다음의 목적 이외의 용도로는 사용하지 않으며, 이용 목적이 변경될 경우 회사는 개인정보 보호법 등 관련 법령에 따라 고객으로부터 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

(1) 홈페이지 회원가입 및 관리 : (회원가입을 하는 경우에 한함) 회원제 서비스 이용에 따른 본인확인, 불량회원의 부정이용 방지와 비인가 사용방지, 가입의사 확인, 가입 및 가입횟수 제한, 탈퇴 후 재가입시 신규 가입 혜택(포인트 지급 등 일체) 중복제공 방지, 회원자격 유지 • 관리, 분쟁조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달
(2) 재화 또는 서비스의 제공 : 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 콘텐츠 제공, 물품(상품 또는 경품)배송 또는 청구서 등 발송, 금융거래, 본인인증, 구매 및 대금결제, 요금추심, 새로운 서비스 안내, 신상품이나 이벤트 정보안내, 재입고 알림 서비스 제공, 해외 배송 통관 업무 진행
(3) 고충처리 : 민원인의 신원확인, 요청 • 제휴, 단체주문 문의 • 제보사항 확인, 사실조사를 위한 연락 • 통지, 처리결과 통보 등
(4) 서비스 개선 및 맞춤서비스 제공 : 접속빈도, 인구통계학적 특성에 따른 쇼핑몰 내 광고 게재 및 서비스 품질 개선을 위한 목적
(5) 상품문의 및 재고문의에 대한 응대 목적
(6) A/S처리 : 구매상품의 A/S 접수, 이력관리를 위한 목적
(7) 회원/비회원 부정 방지: Challenge Farm을 이용하여 부당한 이득을 취하는 등 통상적인 전자상거래관행에 부합하지 않는 거래상의 부정한 행위 방지

3. 개인정보의 처리 및 보유기간
회사는 법령에 따른 개인정보보유 이용기간 또는 고객으로부터 개인정보를 수집할 때 동의 받은 개인정보 보유 이용기간 내에서 개인정보를 처리 및 보유합니다. 회사가 동의 받은 개인정보의 처리 및 보유기간은 아래와 같습니다.

□ 홈페이지 회원의 가입 및 관리 : 회원 탈퇴 시까지 다만, (i) 관계 법령위반에 따른 수사 조사 등이 진행 중인 경우에는 해당 수사 조사 종료 시까지, (ii) 멤버십 이용에 따른 채권 채무관계 잔존 시에는 해당 채권 채무관계 정산 시까지
□ 해외 직배송 통관업무 진행: 개인통관 고유부호 수집 시점으로부터 5년
□ 상품 수선접수 : 회원(회원 탈퇴 시까지), 비회원(수집시점으로부터 5년)
□ 부정행위 회원: 회원탈퇴 후(비회원의 경우 배송완료 후) 5년까지 보관 후 파기
- 보관 수집 항목: 이름, 휴대폰번호, 이메일(존재 시), 아이디(회원일 경우만), 배송지 주소(주문 이력 보유 시), 본인확인기관에서 제공하는 본인인증결과값(CI)
□ 부정행위 회원: 부정행위 회원 이용 방지 : CI값을 회원탈퇴 후 1년까지 보관 후 파기
다만, 회사는 상법 등 관련 법령의 규정에 의하여 개인정보를 보존할 의무가 있는 경우 요구되는 보관목적으로만 고객의 개인정보를 보관하며 보존기간은 개인정보처리방침을 참고하시기 바랍니다.

4. 개인정보 수집 및 이용 동의를 거부할 권리
이용자께서는 개인정보 수집 및 이용 동의를 거부할 권리가 있습니다. 하지만 회원가입 시 수집하는 필수항목에 대해 수집을 거부하실 경우, Challenge Farm 회원가입이 제한됩니다.
						</textarea>
					</p>
					<p>
						<input type="checkbox" id="term_3" name="term_3" value="Y">
						<label for="term_3">[선택] 마케팅 목적의 개인정보 수집, 이용 동의 및 마케팅정보 수신 동의</label>
						<textarea>
1. 항목 : 이메일, 휴대폰 번호, 서비스 이용기록
2. 이용 목적 : 고객 맞춤 서비스 제공, 이벤트 및 광고성 정보 제공 및 참여기회 제공
3. 보유 기간 : 고객의 동의 철회 시 또는 회원 탈퇴 시 즉시 파기

마케팅 목적 개인정보 수집 이용에 동의하실 경우 해당 정보를 수신 받을 방법을 선택해주세요.

선택사항에 동의하지 않으셔도 CF의 서비스를 이용하실 수 있습니다.
다만, 동의하지 않을 경우 고객 맞춤 서비스 제공, 광고성(이벤트) 정보 제공 및 참여 기회가 제한됩니다.
						</textarea>
					</p>
				</div>
				<input type="button" onclick="goRegister()" value="다음">
			</form>
		</article>
		<aside></aside>
	</section>
	
	<%@ include file="/include/common/footer.jsp" %>
	
	<!-- Search Begin -->
	<div class="search-model">
		<div class="h-100 d-flex align-items-center justify-content-center">
			<div class="search-close-switch">+</div>
			<form class="search-model-form">
				<input type="text" id="search-input" placeholder="Search here.....">
			</form>
		</div>
	</div>
	<!-- Search End -->
</body>
</html>