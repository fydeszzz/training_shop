<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="login" value="${adminAccount}" scope="session" />

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

<body>
	<!-- Login form -->
	<div class="loginform2">
		<div class="w3-container w3-indigo">
			<h3>管理者登入</h3>
		</div>

		<form name="form" id="adminForm" class="w3-container" method="POST">
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
			<p>
				<button id="toIndex" class="w3-btn w3-blue-grey">返回網站主頁</button>
			</p>
		</form>
	</div>

	<script type="text/javascript">
		// 返回主頁面
		$('#toIndex').click(function() {
			window.location.href = '<c:url value="/index" />';
		})
	</script>
</body>
