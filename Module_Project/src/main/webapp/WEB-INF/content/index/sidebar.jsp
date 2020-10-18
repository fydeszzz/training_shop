<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="product" value="/product" />
<c:url var="formUrl" value="${product}/query" />

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

<script>
	$(function() {

		// 改變按鈕屬性值以篩選標籤
		$('.btnTag').click(function() {
			var value = $(this).attr('id');

			$('#tag').val(value);

			var form = $('form#modelAttribute');
			form.submit();
		});
	})
</script>

</head>
<body>

	<form:form modelAttribute="modelAttribute" method="POST"
		action="${formUrl}">
		<div class="w3-sidebar w3-light-grey w3-bar-block"
			style="width: 150px; top: 38px;">

			<!-- Hidden Query By Tag_id -->
			<form:input type="hidden" id="tag" path="tag" />

			<h3 class="w3-bar-item tagTitle">食材分類</h3>
			<a href="/Module_Project/product" class="w3-bar-item w3-button">全部商品</a>

			<!-- Show Tag_name in DB -->
			<c:forEach var="taglist" items="${tagList}">
				<button class="btnTag w3-bar-item w3-button" id="${taglist.id}">${taglist.tag_name}</button>
			</c:forEach>
		</div>
	</form:form>

</body>
</html>