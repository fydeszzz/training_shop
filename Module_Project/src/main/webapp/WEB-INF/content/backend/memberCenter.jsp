<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="urlPrefix2" value="/backend/members" />
<c:url var="formUrl2" value="${urlPrefix2}/query" /> 

<html>
<head>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
*{text-align:center;}
.memberTable{
	left:0;
	right:0;
	margin:auto;
	top:150px;
	width:50%;
}
.w3-orange{margin:0;}
.w3-opacity{font-weight:bold;font-family: Microsoft JhengHei;}
</style>
</head>

  <div class="w3-panel w3-orange">
    <h2 class="w3-opacity">會員後台管理系統</h2>
  </div>
<!-- Logout -->
<p>
	<button class="btnOut" onclick="location.href='${pageContext.request.contextPath}/logout'">登出</button>
</p>

<!--Back to Backend index -->
<p>
<button id="btnBack" class="w3-btn w3-blue-grey">回到後台首頁</button>
</p>

<!-- Search Info -->
<form:form modelAttribute="modelAttribute2" method="POST" action="${formUrl2}">
	帳號：<form:input path="account" autofocus="autofocus"/>
	&nbsp;<button id="btnQuery" class="btn btn-primary">查詢</button>
</form:form>
		<button id="btnAdd" class="btn btn-primary" style="right:250px;top:80px;position:absolute;">新增會員</button>
<hr>

<!-- side bar -->
<div class="w3-sidebar w3-bar-block w3-border-right" style="width:5%; top:65px; font-weight:bold">
  <a href="/Module_Project/backend/productManage" class="w3-bar-item w3-button">商品管理</a>
  <a href="/Module_Project/backend/orderManage" class="w3-bar-item w3-button">訂單管理</a>
  <a href="/Module_Project/backend/members" class="w3-bar-item w3-button">會員管理</a>
</div>

<!--Show Info-->
<c:if test="${not empty queryResult}">
	<table border="1" class="memberTable">
		<thead>
			<tr role="row">
				<th width="20%">會員編號</th>
				<th width="30%">會員帳號</th>
				<th width="30%">動作</th>
			</tr>
		</thead>
		<tbody role="alert" aria-live="polite" aria-relevant="all">
		
		<c:forEach var="info" items="${queryResult}">
			<tr>
				<td>${info.id}</td>
				<td>${info.account}</td>
				<td>
					<button id="btnUpdate" rel="${info.id}" href="#">修改密碼</button>
			   <!-- <button id="btnDelete" rel="${info.id}" href="#">刪除帳號</button> -->	
				</td>
			</tr>
		</c:forEach>
		
		</tbody>
	</table>
</c:if>

<script type="text/javascript">

$(function() {
	
	// 回到後台管理頁面
	$('#btnBack').click(function() {
		window.location.href = '${pageContext.request.contextPath}/backend/admin';
	});
	
	// 登出鈕
	$('#btnOut').click(function(){
		
		$.ajax({
			url:'/logout',
			type:'GET',
			
			success: function(data){
				window.location.href = '${pageContext.request.contextPath}/backend/admin';
			},
			error: function(Exception){
				alert('發生錯誤!');
				window.location.href ="";
			}
		});
	});

	// 查詢鈕
	$('#btnQuery').click(function() {
		var form = $('form#modelAttribute2');
		form.find('input:text').each(function(){
		    $(this).val($.trim($(this).val()));
		});
		form.submit();
	});	
	
	// 新增鈕
	$('#btnAdd').click(function() {
		window.location.href = '${pageContext.request.contextPath}/backend/members/add';
	});
	
	// 修改鈕
	$('button[id=btnUpdate]').click(function() {
		var memberId = $(this).attr('rel');
		console.log(memberId);
		
		window.location.href = '/Module_Project'+'${urlPrefix2}/'+memberId+'/update';
	});

	// 刪除鈕
	$('button[id=btnDelete]').click(function(){
		var memberId = $(this).attr('rel');
		console.log(memberId);
		
		if(confirm('確定刪除該帳號?')){
			
			$.ajax({
				url: "${pageContext.request.contextPath}/backend/members/"
				+ memberId+ '/delete',
				type: 'POST',
				success: function(data){
						alert('帳號已刪除!');
						$('#btnQuery').click();
					},
				error: function(exception){
					alert('發生錯誤!');
				}
			});
		}
		return false;
	});
		
})

</script>
</html>