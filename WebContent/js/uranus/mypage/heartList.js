function heartProc(mbr, sle, t) {
	if (mbr == '') {
		alert('로그인이 필요한 기능입니다!');
		return;
	}
	
	var type = 'delete';
	
	var data = { seq_mbr: mbr, seq_sle: sle, process: type };
	
	$.ajax({
		url: '/front/sale/heart.json',
		type: 'post',
		contentType: 'application/json',
		data: JSON.stringify(data),
		success: function (res) {
			if (res) {
				alert("해당 상품을 찜 해제하였습니다");
				$(t).addClass("emptyHeart").removeClass("fullHeart");
				$(t).find("img").attr("src", "/img/icon/heart_empty.png");
				location.reload();
			} else {
				alert("찜 해제 실패!!\n관리자에게 문의하세요");
				}
		},
		error: function () {
			alert("서버 오류로 찜 해제에 실패하였습니다.");
		}
	});
}
	
function goPage(value) {
	var frmMain = document.getElementById("frmMain");
	document.getElementById("currentPage").value = value;
	frmMain.action = "/front/mypage/heartList.web";
	frmMain.submit();
}