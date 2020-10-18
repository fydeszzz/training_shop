<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Favicon  -->
<link rel="icon" href="img/core-img/favicon.ico">

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
.w3-ul {
	border-radius: 5px 5px 5px 5px;
	border: 1px solid black;
	font-weight: bold;
	top: 100px;
	width: 50%;
	position: relative;
}

.w3-opacity {
	font-weight: bold;
	font-family: Microsoft JhengHei;
	text-align: center;
}
</style>

</head>
<body>

	<!-- side bar -->
	<div class="w3-sidebar w3-bar-block w3-border-right"
		style="width: 5%; top: 65px; font-weight: bold">
		<a href="/Module_Project/backend/productManage"
			class="w3-bar-item w3-button">商品管理</a> <a
			href="/Module_Project/backend/orderManage"
			class="w3-bar-item w3-button">訂單管理</a> <a
			href="/Module_Project/backend/members" class="w3-bar-item w3-button">會員管理</a>
	</div>
	
	<div class="w3-panel w3-pale-yellow" style="top: 0; margin: 0">
		<h2 class="w3-opacity">後台管理系統</h2>
	</div>

	<!-- Logout -->
	<button class="btnOut"
		onclick="location.href='${pageContext.request.contextPath}/logout'">登出</button>

	<!-- action form -->
		<div class="actionBar">目前登入身分: ${adminAccount}</div>
	<ul class="w3-ul w3-hoverable" style="left: 0; right: 0; margin: auto">
		<li><a href="/Module_Project/backend/productManage">【商品管理】新增、修改與查詢所有商品</a></li>
		<li><a href="/Module_Project/backend/orderManage">【訂單管理】修改與查詢所有/單一用戶訂單</a></li>
		<li><a href="/Module_Project/backend/members">【用戶管理】新增、修改、刪除與查詢所有/單一用戶</a></li>
	</ul>

	<div style="text-align: center; position: relative; top: 250px">
		<button id="toIndex" class="w3-btn w3-blue-grey">返回網站主頁</button>
	</div>

	<script type="text/javascript">
		// 返回主頁面
		$('#toIndex').click(function() {
			window.location.href = '<c:url value="/index" />';
		})
		// 登出鈕
		$('#btnOut').click(function() {

			$.ajax({
				url : '/logout',
				type : 'GET',
				success : function(data) {
					window.location.href = '${pageContext.request.contextPath}/backend/admin';
				},
				error : function(Exception) {
					alert('發生錯誤!');
					window.location.href = "";
				}
			});
		});
	</script>

</body>
</html>