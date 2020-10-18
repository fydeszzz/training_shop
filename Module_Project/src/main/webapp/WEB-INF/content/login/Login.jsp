<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="login" value="${account}" scope="session" />
<c:set var="loginPrefix" value="/login" />

<meta charset="UTF-8">
<meta name="description" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<html>
<head>

<!-- Favicon  -->
<link rel="icon" href="img/core-img/favicon.ico">

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
body{background:url(https://i.imgur.com/RL6zNty.png) no-repeat;}
</style>

</head>

<body>

	<!-- Navigator -->
	<%@include file="../index/navigator.jsp"%>

	<!-- Login form -->
	<div class="loginform">
		<div class="w3-container w3-indigo" style="width: 40%;">
			<h3>會員登入</h3>
		</div>

		<form name="form1" id="loginForm" class="w3-container" method="POST">
			<p>
				<label class="w3-text-teal"><b>帳號</b></label> <input type="text"
					name="account" id="account"
					class="w3-input w3-border w3-light-grey"
					style="width: 50%; left: 0; right: 0; margin: auto;" maxlength="16"
					required="required" autofocus="autofocus" />
			</p>
			<p>
				<label class="w3-text-teal"><b>密碼</b></label> <input type="password"
					name="password" id="password"
					class="w3-input w3-border w3-light-grey"
					style="width: 50%; left: 0; right: 0; margin: auto;" maxlength="16"
					required="required" />
			</p>
			<p>
				<button type="submit" id="btnLogin" class="w3-btn w3-blue-grey">登入</button>
				<button type="reset" class="w3-btn w3-blue-grey">清除</button>
			</p>
		</form>
	</div>

	<!-- Register -->
	<div class="registerform">
		<div class="w3-container w3-amber">
			<h3>註冊新會員</h3>
		</div>
		<div id="registerForm">
			<p style="color:white">
				輸入帳號、密碼與電話地址，<br /> 即可開始預訂外送！
			</p>
			<p>
				<button id="toRegister" class="w3-btn w3-blue-grey">前往註冊</button>
			</p>
		</div>
	</div>
	
<script type="text/javascript">
	// 前往註冊頁面
	$('#toRegister').click(function() {
		window.location.href = '<c:url value="/register" />';
	})

	//登入驗證
	/*	$('#btnLogin').click(function() {
	
	 $.ajax({
		 url: '${pageContext.request.contextPath}'+'${loginPrefix}',
		 type: 'POST',
		 data: $('#loginForm').('$account').val(),
		 success: function(data){
	
			 if(data !=''){
			 	alert("登入成功");
				window.location.replace('${successUrl}');
			 } else{
			 	alert("帳號或密碼錯誤");
			 	window.location.href ="";
			 }
		},
			 error: function(exception){
			 	alert("出現錯誤");
			 	window.location.href ="";
			 }
	 	});
	 });
	 */
</script>
</body>
</html>