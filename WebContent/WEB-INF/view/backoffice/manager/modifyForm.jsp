<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page info="/WEB-INF/view/backoffice/modifyForm.jsp"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<%@ include file="/include/console/header.jsp"%>
	<script type="text/javascript" src="/js/uranus/backoffice/modifyForm.js"></script>
</head>

<body>
	<div id="wrapper">
			<%@ include file="/include/console/top.jsp"%>
			<%@ include file="/include/console/gnb.jsp"%>
		
		<div id="page-wrapper">
				<div class="header">
					<h1 class="page-header">My Profile</h1>
					<ol class="breadcrumb">
						<li><a href="#">Home</a></li>
						<li><a href="#">관리자</a></li>
						<li class="active">프로필</li>
					</ol>
				</div>
		
			<div id="page-inner" style="display: flex; justify-content: center; align-items: center; min-height: 50vh;">
				<div style="display: flex; flex-direction: column; width: 600px; border-radius: 10px;">
			
				 	<form class="custom-form" id="custom-form" name="custom-form" action="/console/manager/modifyProc.web" method="POST" style="display: flex; flex-direction: column;">
						<div class="col-xs-12" style="margin-bottom: 20px;">
							<label for="id" class="form-label">아이디</label><br>
							<span style="display: inline-block; width: 100%; border-bottom: 1px solid #ccc; padding: 5px 0; margin-top: 0px;">${managerDto.id}</span>
						</div>
						
						<div class="col-xs-12" style="margin-bottom: 20px;">
							<label for="mng_nm" class="form-label">이름</label><br>
							<span style="display: inline-block; width: 100%; border-bottom: 1px solid #ccc; padding: 5px; 0 margin-top: 0px;">${managerDto.mng_nm}</span>
						</div>
							
						<div class="col-xs-12" style="margin-bottom: 20px;">
							<label for="email" class="form-label">Email</label><br>
							<span style="display: inline-block; width: 100%; border-bottom: 1px solid #ccc; padding: 5px; 0 margin-top: 0px;">${managerDto.email}</span>
						</div>
						
						<div class="col-xs-12" style="margin-bottom: 20px;">
							<label for="passwd" class="form-label">현재 비밀번호</label><br>
							<input type="password" id="passwd" name="passwd" placeholder="********" class="form-control" 
							style="border: none; width: 100%; border-bottom: 1px solid #ccc; padding: 5px 0; padding-left: 10px; margin-top: 0px;">
						</div>
							
						<div class="col-xs-12" style="margin-bottom: 20px;">
							<label for="newPassword" class="form-label">새 비밀번호</label><br>
							<input type="password" id="newPassword" name="newPassword" placeholder="" class="form-control" 
							style="border: none; width: 100%; border-bottom: 1px solid #ccc; padding: 5px 0; padding-left: 10px; margin-top: 0px;">
						</div>
							
						<div class="col-xs-12" style="margin-bottom: 20px;">
							<label for="confirmPassword" class="form-label">새 비밀번호 확인</label><br>
							<input type="password" id="confirmPassword" name="confirmPassword" placeholder="" class="form-control" 
							style="border: none; width: 100%; border-bottom: 1px solid #ccc; padding: 5px 0; padding-left: 10px; margin-top: 0px;">
						</div>
						
						<button type="submit" class="btn btn-success" onClick="checkModify();">프로필 업데이트</button>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
