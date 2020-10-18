<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Favicon  -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
.w3-ul{
	border-radius: 5px 5px 5px 5px;
	border:1px solid black;
	font-weight:bold;
	top:100px;
	width:50%;
	position:relative;
}

</style>
    
</head>
<body>
	<!-- Navigator -->	
	<%@include file = "../index/navigator.jsp" %>
	
	<!-- action form -->
	<div class="actionBar">${account} 您好，請選擇要查詢的項目：</div>
	<ul class="w3-ul w3-hoverable" style="left:0;right:0;margin:auto">
		<li><a href="/Module_Project/profile/update">會員資料修改</a></li>
		<li><a href="/Module_Project/order/view">訂單查詢</a></li>
		<li>常見問答</li>
	</ul>
	
<!-- footer -->
<div class="w3-teal">
  <h5>©COPYRIGHT 2020 HOTPOTGO</h5>
  <p>All copyrights and trademarks are the property of their respective owners.</p>
</div>

<script>
</script>

</body>
</html>