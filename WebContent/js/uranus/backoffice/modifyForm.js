function checkModify() {

	var passwd = $("#passwd").val(); // 현재 비밀번호
	var newPassword = $("#newPassword").val();
	var confirmPassword = $("#confirmPassword").val();
	
	// 현재 비밀번호가 비어 있는지 확인
	if (!passwd) {
		alert("변경되지 않았습니다.");
		return /console/manager/modifyForm.web;
	}
	
	// 신규 비밀번호가 비어 있는지 확인
	if (!newPassword) {
		alert("신규 비밀번호를 입력해주세요!");
		return;
	}
	
	// 비밀번호 확인이 비어 있는지 확인
	if (!confirmPassword) {
		alert("신규 비밀번호 확인을 입력해주세요!");
		return;
	}
	
	// 신규 비밀번호와 비밀번호 확인이 일치하는지 확인
	if (newPassword !== confirmPassword) {
		alert("신규 비밀번호와 비밀번호 확인이 일치하지 않습니다!");
		return;
	}
	
	// 비밀번호가 규칙에 맞는지 확인 (예: 최소 8자, 대문자 포함)
	if (newPassword.length < 8) {
		alert("신규 비밀번호는 최소 8자 이상이어야 합니다!");
		return;
	}
		
	var regExpPasswd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		if (!regExpPasswd.test(newPassword)) {
			alert("비밀번호는 영문/숫자/특수기호를 조합하여 8자 이상을 입력하세요!");
			return;
		}
	
	// 폼을 제출
	$("#custom-form").submit();
	
}