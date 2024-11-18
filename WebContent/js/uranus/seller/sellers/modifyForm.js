var isCertification = false; // 초기 인증 상태
var sentCode = "";

window.onload = function () {
	
	// 원래 전화번호 저장
	$("#phone").data("original", $("#phone").val());
	
	$("#btnPhone").on("click", function() {
		// 전화번호 11자리 입력 확인
		if ($("#phone").val().length !== 11) {
			alert("전화번호 11자리를 입력해주세요!");
			return false;
		}
		
		var myData = { phone: $("#phone").val() };
		
		$.ajax({
			type: "POST",
			url: "/seller/sellers/checkNumber.json",
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			data: JSON.stringify(myData),
			success: function(res) {
				if (res != 0) {
					alert("해당 번호로 인증번호를 전송하였습니다.\n인증번호를 입력해주세요");
					sentCode = res.toString(); // 서버에서 받은 인증번호
					$("#checkNumber").show(); // 인증번호 입력 필드 표시
					isCertification = true; // 인증 상태를 true로 설정
				} else {
					alert($("#phone").val() + "는 중복됩니다! 다른 번호를 입력하세요!");
					$("#phone").val("").focus();
					isCertification = false;
				}
			}	
		});
	});
	
		$("#checkNumber").on("change", function() {
			var inputCode = $(this).val().trim(); // 공백 제거
		
			if (inputCode === "") {
				alert("인증번호를 입력해주세요.");
				$(this).val("").focus();
				return;
			}
		
			if (inputCode === sentCode) {
				alert("인증이 완료되었습니다!"); 
				isCertification = true; // 인증 완료 상태로 설정
			} else {
				alert("인증번호가 다릅니다. 다시 입력해주세요.");
				$(this).val("").focus();
			}
		});
	
	$("#btnModify").on("click", function(e) {
		e.preventDefault();
			
		const phoneNumber = $("#phone").val().trim();
		const originalPhone = $("#phone").data("original"); // 원래 전화번호
		const inputCode = $("#checkNumber").val().trim(); // 인증번호 입력 필드의 값을 가져옵니다.
	
		// 전화번호가 변경되었는지 확인
		if (phoneNumber !== originalPhone) {
			// 전화번호 유효성 검사
			if (phoneNumber.length !== 11) {
				alert("전화번호 11자리를 입력해주세요!");
				return;
		}
			
		if (inputCode.length === 0) {
			alert("인증번호를 입력해주세요.");
			return;
		}
				
		// 추가적인 인증번호 확인 로직 (예: sentCode와 비교)
		if (inputCode !== sentCode) {
			alert("인증번호가 일치하지 않습니다. 다시 입력해주세요.");
			$("#checkNumber").val("").focus();
			return;
		}
	
		// 인증 상태 확인
		if (!isCertification) {
			alert("먼저 전화번호 인증을 해주세요.");
			return;
		}
	}
	
	// 비밀번호 관련 로직
	var confirmPasswd = $("#confirmPasswd").val().trim();
	var confirmPasswd_ = $("#confirmPasswd_").val().trim();
	
	// 신규 비밀번호와 비밀번호 확인이 공백인지 확인
	if (confirmPasswd === "" && confirmPasswd_ === "") {
			// 비밀번호를 변경하지 않기 위해 빈 값을 서버에 전송
			$("#frmMain").attr("action", "/seller/sellers/modifyProc.web");
			$("#frmMain").submit();
			return; // 더 이상 진행하지 않음
	}
	
	// 신규 비밀번호가 비어 있는지 확인
	if (!confirmPasswd) {
		alert("신규 비밀번호를 입력해주세요!");
		return;
	}
	
	// 비밀번호 확인이 비어 있는지 확인
	if (!confirmPasswd_) {
		alert("신규 비밀번호 확인을 입력해주세요!");
		return;
	}
	
	// 신규 비밀번호와 비밀번호 확인이 일치하는지 확인
	if (confirmPasswd !== confirmPasswd_) {
		alert("신규 비밀번호와 비밀번호 확인이 일치하지 않습니다!");
		return;
	}
	
	// 비밀번호가 규칙에 맞는지 확인 (예: 최소 8자, 대문자 포함)
	if (confirmPasswd.length < 8) {
		alert("신규 비밀번호는 최소 8자 이상이어야 합니다!");
		return;
	}
	
	var regExpPasswd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	if (!regExpPasswd.test(confirmPasswd)) {
		alert("비밀번호는 영문/숫자/특수기호를 조합하여 8자 이상을 입력하세요!");
		return;
	}
	
	// 휴대폰번호 확인(3자리-4자리-4자리)
	var regExpPhone = /^\d{11}$/;
	if (!regExpPhone.test(phoneNumber)) {
		alert("연락처를 확인해 주세요!");
		return;
	}
	
	// 필수 항목 확인
	if ($("#post").val() === "" || $("#addr1").val() === "" || $("#addr2").val() === "") {
		alert("필수 항목을 입력하세요!");
		return;
	}
	
	// 모든 유효성 검사 통과 후 폼 제출
	$("#frmMain").attr("action", "/seller/sellers/modifyProc.web"); // 서버로 폼 제출
	$("#frmMain").submit();
	});
};

function execDaumPostcode() {
	
	var width	= 500; //팝업의 너비
	var height	= 600; //팝업의 높이
	
	new daum.Postcode({
		width: width,
		height: height,
		oncomplete: function(data) {
			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var roadAddr = data.roadAddress;		// 도로명 주소 변수
			var extraRoadAddr = '';					// 참고 항목 변수
			
			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname;
			}
			
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if(data.buildingName !== '' && data.apartment === 'Y'){
				extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			
			// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if(extraRoadAddr !== ''){
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById("post").value		= data.zonecode;
			document.getElementById("addr1").value		= roadAddr;
			document.getElementById("jibunAdd").value	= data.jibunAddress;
			
			// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
			if(roadAddr !== ''){
				document.getElementById("extraAddress").value = extraRoadAddr;
			}
			else {
				document.getElementById("extraAddress").value = '';
			}
			
			var guideTextBox = document.getElementById("guide");
			// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
			if(data.autoRoadAddress) {
				var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
				guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
				guideTextBox.style.display = 'block';
			
			}
			else if(data.autoJibunAddress) {
				var expJibunAddr = data.autoJibunAddress;
				guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
				guideTextBox.style.display = 'block';
			}
			else {
				guideTextBox.innerHTML = '';
				guideTextBox.style.display = 'none';
			}
			}
		}).open({
			left: (window.screen.width / 2) - (width / 2),
			top: (window.screen.height / 2) - (height / 2)
	});
}