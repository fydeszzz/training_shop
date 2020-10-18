<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="product" value="/product" />
<c:url var="formUrl" value="${product}/query" />

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
body {
	background: url(https://i.imgur.com/RL6zNty.png) no-repeat;
	background-attachment: fixed;
}
.showlist {
	width: 400px;
	left: 0;
	right: 0;
	margin: auto;
	margin-left: 200px;
	top: 200px;
	position: relative;
	float: left;
	text-align: center
}
</style>
</head>

<body>
	<!-- Navigator -->
	<%@include file="../index/navigator.jsp"%>

	<!-- shopping cart -->
	<%@include file="../index/cartBtn.jsp"%>

	<!-- Sidebar -->
	<%@include file="../index/sidebar.jsp"%>

	<!-- Search bar -->
	<%@include file="productSearch.jsp"%>

	<!-- Top Button -->
	<a href="#"><input type="button" class="topbutton"></a>

	<!--Show Info-->
	<c:if test="${not empty queryResult}">

		<c:forEach var="info" items="${queryResult}">
			<div class="showlist">
				<div class="w3-row">
					<div class="w3-col l3 s6">
						<div class="w3-container"
							style="left: 0; right: 0; margin: auto; width: 400px">
							<a href='<c:url value="${product}/${info.id}/view" />'
								style="text-decoration: none;"> 
								<img src='/Module_Project/resources/img/item${info.id}.png'
								style="width: 200px; height: 200px"> 
							<p>
								<span style="color: white; font-weight: bold">${info.product_name}</span></a><br>
							<b><span style="color: red; font-weight: bold"> 
							<fmt:formatNumber value="${info.price}" type="currency" maxFractionDigits="0" /></span></b>
							</p>
						</div>
					</div>
				</div>
			</div>

		</c:forEach>
	</c:if>

	<!-- footer
<footer class="w3-teal">
  <h5>©COPYRIGHT 2020 HOTPOTGO</h5>
  <p>All copyrights and trademarks are the property of their respective owners.</p>
</footer> -->

<script type="text/javascript">
$(function() {

		// 查詢鈕
		$('#btnQuery').click(function() {
			var form = $('form#modelAttribute');
			form.find('input:text').each(function() {
				$(this).val($.trim($(this).val()));
			});
			form.submit();
		});
	})
		// Top button hide
		$(".topbutton").hide();
		var winHeight = $(window).height();
		$(window).scroll(function() {
			if ($(window).scrollTop() >= winHeight) {
				$(".topbutton").show();
			} else {
				$(".topbutton").hide();
			}
		})
</script>
</body>
</html>
