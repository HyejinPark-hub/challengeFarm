function resetDelete() {
	document.getElementById('withdrawPassword').value = ''; // 비밀번호 입력 필드 초기화
	document.getElementById('error-message').style.display = 'none'; // 오류 메시지 숨기기
}

function validatePassword_(event) {
	event.preventDefault(); // 기본 폼 제출 방지

	const password = document.getElementById('withdrawPassword').value; // 비밀번호
	const seq_mbr = document.getElementById('seq_mbr').value; // 회원 번호
	const errorMessageDiv = document.getElementById('error-message'); // 오류 메시지 표시할 요소

	console.log("회원 번호:", seq_mbr);
	console.log("비밀번호:", password);
	
	// 오류 메시지 초기화
	errorMessageDiv.style.display = 'none'; // 숨김
	errorMessageDiv.textContent = ''; // 내용 초기화

	// 비밀번호 검증 요청
	fetch('/front/member/passwd/deleteProc.web', {
		method: 'POST',
		headers: {
		'Content-Type': 'application/json'
		},
		body: JSON.stringify({ passwd: password, seq_mbr: seq_mbr }) // 비밀번호와 회원 번호 전송
	})
	.then(response => {
		if (response.ok) {
			// 비밀번호가 맞으면 두 번째 모달에 회원 번호와 비밀번호 설정
			document.getElementById('confirmSeq_mbr').value = seq_mbr; 
						console.log("회원 번호:", seq_mbr);
			document.getElementById('confirmWithdrawPassword').value = password; // 비밀번호도 전달
					
			// 모달 전환
			$('#withdrawModal').modal('hide'); // 첫 번째 모달 닫기
			$('#confirmationModal').modal('show'); // 두 번째 모달 열기
		} else {
			// 비밀번호가 틀린 경우 오류 메시지 표시
			errorMessageDiv.style.display = 'block'; // 표시
			errorMessageDiv.textContent = '비밀번호가 틀렸습니다. 다시 시도해 주세요.'; // 메시지 설정
		}
	})
	.catch(error => {
		console.error('Error:', error);
		alert('문제가 발생했습니다. 다시 시도해 주세요.');
	});
}

function confirmDeletion(event) {
	event.preventDefault(); // 기본 폼 제출 방지
	
	const seq_mbr = document.getElementById('confirmSeq_mbr').value; // 회원 번호
	const password = document.getElementById('confirmWithdrawPassword').value; // 비밀번호
		
	console.log("회원 번호:", seq_mbr);
	console.log("비밀번호:", password);
	
	// 서버에 탈퇴 요청 보내기
	fetch('/front/member/deleteProc.web', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ seq_mbr: seq_mbr, passwd: password }) // 비밀번호와 회원 번호 전송
	})
	.then(response => {
		if (response.ok) {
		alert('회원 탈퇴가 완료되었습니다.');
		   	window.location.href = '/';
		} else {
		alert('탈퇴 처리 중 문제가 발생했습니다. 다시 시도해 주세요.');
		}
	})
	.catch(error => {
		console.error('Error:', error);
		alert('문제가 발생했습니다. 다시 시도해 주세요.');
	});
}
