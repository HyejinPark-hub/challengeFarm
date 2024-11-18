function resetModify() {
	document.getElementById('password').value = ''; // 비밀번호 입력 필드 초기화
	document.getElementById('error-message').style.display = 'none'; // 오류 메시지 숨기기
}

function validatePassword(event) {
	event.preventDefault(); // 기본 폼 제출 방지
	
	const passwordInput = document.getElementById("password");
	const passwordError = document.getElementById("passwordError");
	
	const password = passwordInput.value.trim(); // 공백 제거
	
	// 비밀번호 입력 확인
	if (password === "") {
		passwordError.textContent = "비밀번호를 입력해주세요."; // 오류 메시지 설정
		passwordError.style.display = 'block'; // 오류 메시지 표시
		passwordInput.focus(); // 입력 필드에 포커스
		return;
	} else {
		passwordError.style.display = 'none'; // 입력값이 있으면 오류 메시지 숨김
	}
	
	// 비밀번호를 서버에 확인 요청 (Ajax)
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "/front/member/passwd/modifyProc.web", true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	xhr.onload = function() {
		if (xhr.status === 200) {
			// 비밀번호가 맞으면 수정 폼으로 이동
			window.location.href = "/front/member/modifyForm.web"; // 수정 폼으로 이동
		} else {
			// 비밀번호가 틀린 경우
			passwordError.textContent = "비밀번호가 틀렸습니다. 다시 시도해 주세요."; // 오류 메시지 설정
			passwordError.style.display = 'block'; // 오류 메시지 표시
			passwordInput.value = ""; // 입력 필드 초기화
			passwordInput.focus(); // 입력 필드에 포커스
			}
	};
	
	// 비밀번호를 URL 인코딩하여 전송
	xhr.send("passwd=" + encodeURIComponent(password));
}
