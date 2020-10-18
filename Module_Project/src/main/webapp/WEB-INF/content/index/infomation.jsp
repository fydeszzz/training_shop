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
body{background:url(https://i.imgur.com/RL6zNty.png) no-repeat;}
</style> 

</head>
<body>
	<!-- Navigator -->	
	<%@include file = "navigator.jsp" %>
	
	<!-- shopping cart -->
    <%@include file = "cartBtn.jsp" %>

<div class="info" style="top:100px;">
	<div class="w3-container w3-theme-d4">
		<p class="w3-large">◎簡單三步驟完成自助火鍋◎</p>
	</div>

<div class="w3-row-padding w3-theme">
	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP1.</h4>
		<p>挑選湯底</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP.2</h4>
		<p>再挑選喜愛的食材</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP.3</h4>
		<p>結帳後外送到府煮鍋(或自煮)</p>
		</div>
		</div>
	</div>
</div>
</div>

<!-- footer -->
<div class="w3-teal">
  <h5>©COPYRIGHT 2020 HOTPOTGO<a href="${pageContext.request.contextPath}/backend"><img src="https://i.imgur.com/vZG2ZTC.png" style="width:50px"></a></h5>
  <p>All copyrights and trademarks are the property of their respective owners.</p>
</div>

</body>
</html>