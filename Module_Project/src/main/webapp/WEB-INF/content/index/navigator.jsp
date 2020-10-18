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
.w3-bar-item{
	float: right !important;
    padding-left:20px;
    padding-right:20px;
    font-weight: bold;
}

</style>
<script type="text/javascript">

$(function() {
	var user = $('#user').html();
	console.log(user);
	
	if (user == ''){
		$('#login').val("登入/註冊");
	} else {
		$('#login').val("登出");
	}
	
	console.log($('#login').val());
	
	if($('#login').val() == "登出"){
		$('#login').parent().attr("href", "${pageContext.request.contextPath}/logout");
		$('.welcome').show();
	}
});

</script>	
</head>
<body>
	<!-- Navigator -->
	<div class="w3-bar w3-black">
		<a href="/Module_Project/index" 
		class="w3-bar-item w3-button w3-mobile w3-green" 
		style="float: left !important; width: 150px;">首頁</a> 
		<a href="/Module_Project/infomation" class="w3-bar-item w3-button w3-mobile">購物流程</a> 
		<a href="/Module_Project/shopcart" class="w3-bar-item w3-button w3-mobile">購物車</a>

		<div class="w3-dropdown-hover w3-mobile navi">
			<button class="w3-button" onclick="location.href='${pageContext.request.contextPath}/profile'">
			會員中心 <i class="fa fa-caret-down"></i></button>
			<div class="w3-dropdown-content w3-bar-block w3-dark-grey">
				<a href="/Module_Project/profile" class="w3-bar-item w3-button w3-mobile">會員資料</a> 
				<a href="/Module_Project/order/view" class="w3-bar-item w3-button w3-mobile">訂單查詢</a>
			</div>
		</div>
  			<a href="/Module_Project/login">
  			<input type="button" class="w3-bar-item w3-button w3-mobile" id="login" value="" /></a>
  			<div class="welcome">歡迎您，<span id="user">${account}</span></div>
	</div>

</body>
</html>