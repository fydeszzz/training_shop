<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    

<c:set var="product" value="/product" />
<c:url var="formUrl" value="${product}/query" /> 
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>Product Search</title>

<style>
* {font-family: Microsoft JhengHei;}

.searchTable{
	position:absolute;
	top:70px;
	width:50%;
 	text-align:center; 
 	left:0;
 	right:0;
 	margin:auto;
 	font-size:14px;
}

</style>

</head>
<body>

	<!-- search goods -->
	<form:form modelAttribute="modelAttribute" method="POST" action="${formUrl}">
	<div class="searchTable">
		  <img src="https://i.imgur.com/V61D1f4.png"/>
		  <form:input path="product_name" autofocus="autofocus" />
	&nbsp;<button type="submit" id="btnQuery" class="btn btn-primary">查詢商品</button>
	</div>
	</form:form>

</body>
</html>