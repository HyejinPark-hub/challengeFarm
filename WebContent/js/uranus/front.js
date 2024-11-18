/**
 * @author hyebongssss@himedia.co.kr
 * @since 2024-08-02
 *
 * <p>DESCRIPTION: 개인정보 수정
 * <p>IMPORTANT:</p>
 */

function checkModify() {
				
	var confirmPasswd	= $("#confirmPasswd").val();
	var confirmPasswd_	= $("#confirmPasswd_").val();
	
	// 신규 비밀번호와 비밀번호 확인이 공백인지 확인
		if (confirmPasswd.trim() === "" && confirmPasswd_.trim() === "") {
	// 비밀번호를 변경하지 않기 위해 빈 값을 서버에 전송
	$("#frmMain").attr("action", "/front/member/modifyProc.web");
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
			if (!regExpPasswd.test(document.getElementById("confirmPasswd").value)) {
			alert("비밀번호는 영문/숫자/특수기호를 조합하여 8자 이상을 입력하세요!");
			return;
			}		
		
	// 휴대폰번호 확인(11자리)
	var regExpPhone = /^\d{11}$/;
	var phone = $("#phone").val();// jQuery를 사용해 값 가져오기
	
	if (!regExpPhone.test(phone)) {
	 alert("연락처를 확인해 주세요!");
	 return;
	}
	
	// 필수 항목 확인
	if ($("#post").val() === "" || $("#addr1").val() === "" || $("#addr2").val() === "") {
	 alert("필수 항목을 입력하세요!");
	 return;
	}
	
	// 모든 유효성 검사 통과 후 폼 제출
	$("#frmMain").attr("action", "/front/member/modifyProc.web"); // 서버로 폼 제출
	$("#frmMain").submit();
	}

/**
 * @author pluto@himedia.co.kr
 * @since 2023-11-02
 *
 * <p>DESCRIPTION: 다음 우편번호 찾기(https://postcode.map.daum.net/guide)</p>
 * <p>IMPORTANT:</p>
 */

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

/**
 * @author pluto@himedia.co.kr
 * @since 2024-05-28
 *
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
function checkEmail(email) {
	
	var isEmail = true;
	
	// 0. 정규식
	//alert(email);
	var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	if (!regExpEmail.test(email)) return false;
	
	// 1. 자리수
	//alert("자리수=" + email.length);
	if (email.length <= 7) return false;
	
	// 2. @
	//alert("@의 인덱스=" + email.indexOf("@"));
	if (email.indexOf("@") <= 0) return false;
	
	// 3. 도메인
	var isExist = false;
	var arrDomain	= [".co.kr", ".com", ".net", ".or.kr", ".go.kr"];
	for (var i = 0; i < arrDomain.length; i++) {
		if (email.indexOf(arrDomain[i]) > 0 ) {
			//alert("도메인=" + arrDomain[i]);
			isExist = true;
			break;
		}
	}
	if (!isExist) return false;
	
	var arrValue = email.split("@");
	//alert("ID=" + arrValue[0].toLowerCase());
	
	// 4. 아이디에 처음시작 1자리는 영문, 5자이상 16자 이하, 영문, 영문+숫자, 특수문자는 '_'만 가능
	var regularExpression = /^[a-zA-Z]{1}[a-zA-Z0-9_]{4,16}$/;
	var isExist = regularExpression.test(arrValue[0]) ? false : true;
	//alert("특수문자 여부=" + isExist);
	if (isExist) return false;
	
	// 5. 제외할 아이디(소문자 기준)
	isExist = false;
	var IRREGULAR_KEYWORD = "super|root|administrator|admin|console"
	+ "|sys|system|sa|owner"
	+ "|document|html|iframe|div|span|img|src|type"
	+ "|javascript|vbscript|script|alert"
	+ "|id|member|customer|www";
	if (IRREGULAR_KEYWORD.indexOf(arrValue[0].toLowerCase()) >= 0 ) {
		//alert("제외할 아이디=" + arrValue[0].toLowerCase());
		isExist = true;
	}
	if (isExist) return false;
	
	return isEmail;
}

/**
 * @author pluto@himedia.co.kr
 * @since 2024-05-28
 *
 * <p>DESCRIPTION:</p>
 * <p>IMPORTANT:</p>
 */
function checkRegister() {
	
	var isSubmit	= true;
	var frmMain		= document.getElementById("frmMain");
	
	var email = document.getElementById("email").value;
	//alert("이메일=" + email);
	
	// 정상적인 이메일이 아니면(checkEmail = false)
	if (!checkEmail(email)) {
		alert("이메일을 확인하세요!");
		document.getElementById("email").focus();
		return;
	}
	
	// 이메일 중복 여부 확인
	if (isDuplicate) {
		alert("이메일 중복을 확인하세요!");
		document.getElementById("btnId").focus();
		return;
	}
	
	// 비밀번호 확인
	if (document.getElementById("passwd").value != document.getElementById("passwd_").value) {
		alert("비밀번호를 확인하세요!");
		isSubmit = false;
		document.getElementById("passwd").focus();
	}
	var regExpPasswd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	if (!regExpPasswd.test(document.getElementById("passwd").value)) {
		alert("비밀번호는 영문/숫자/특수기호를 조합하여 8자 이상을 입력하세요!");
		isSubmit = false;
	}
	
	// 성명 확인(한글만 입력 가능)
	var regExpName = /^[가-힣]*$/;
	if (!regExpName.test(document.getElementById("mbr_nm").value)) {
		alert("성명은 한글만 입력하세요!");
		isSubmit = false;
	}
	
	// 휴대폰번호 확인(3자리-4자리-4자리)
	var regExpPhone = /^\d{11}$/;
	var phone = document.getElementById("phone").value;
	if (!regExpPhone.test(phone)) {
		alert("연락처를 확인해 주세요!");
		isSubmit = false;
	}
	
	if (document.getElementById("mbr_nm").value == ""
			|| document.getElementById("phone").value == ""
			|| document.getElementById("post").value == ""
			|| document.getElementById("addr1").value == ""
			|| document.getElementById("addr2").value == "") {
		alert("필수 항목을 입력하세요!");
		isSubmit = false;
	}
	
	if (isSubmit) {
		alert("정상적으로 "
				+ email
				+ "로 인증 URL이 전송되었습니다.\n반드시 가입 후 10분 이내에 인증 URL을 클릭하셔야 정상적으로 서비스를 이용할 수 있습니다.");
			
		frmMain.action = "/front/member/registerProc.web";
		frmMain.submit();
	}
}