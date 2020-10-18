<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="urlPrefix" value="/backend/orderManage" />
<c:url var="formUrl" value="${urlPrefix}/query" /> 

<html>
<head>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
*{text-align:center;}
.w3-blue{margin:0;}
.w3-opacity{font-weight:bold;font-family: Microsoft JhengHei;}
</style>
</head>

  <div class="w3-panel w3-blue">
    <h2 class="w3-opacity">訂單後台管理系統</h2>
  </div>
<!-- Logout -->
<p>
	<button class="btnOut" onclick="location.href='${pageContext.request.contextPath}/logout'">登出</button>
</p>

<!--Back to Backend index -->
<p>
<button id="btnBack" class="w3-btn w3-blue-grey">回到後台首頁</button>
</p>

<!-- side bar -->
<div class="w3-sidebar w3-bar-block w3-border-right" style="width:5%; top:65px; font-weight:bold">
  <a href="/Module_Project/backend/productManage" class="w3-bar-item w3-button">商品管理</a>
  <a href="/Module_Project/backend/orderManage" class="w3-bar-item w3-button">訂單管理</a>
  <a href="/Module_Project/backend/members" class="w3-bar-item w3-button">會員管理</a>
</div>

<hr>

<!--Show Info-->
<c:if test="${not empty queryResult}">
	<table border="1" class="orderTable">
		<thead>
			<tr role="row" style="background:black;color:white">
				<th width="5%">訂單編號</th>
				<th width="5%">會員編號</th>
				<th>連絡電話</th>
				<th width="20%">配送地址</th>
				<th>消費總額</th>
				<th>付款方式</th>
				<th>下訂日期</th>
				<th>配送狀態</th>
				<th>動作</th>
			</tr>
		</thead>
		<tbody role="alert" aria-live="polite" aria-relevant="all">

		<c:forEach var="info" items="${queryResult}">
			<tr>
				<td>${info.id}</td>
				<td>${info.member_id}</td>
				<td>${info.phone}</td>
				<td>${info.address}</td>
				<td><span id="totalprice"><fmt:formatNumber value="${info.total}" type="currency" maxFractionDigits="0"/></span></td>
				<td>${info.method.method}</td>
				<td><fmt:formatDate value="${info.order_date}" type="both"/></td>
				<td style="font-weight:bold">${info.delivery.status_name}</td>
				<td>
					<button id="btnUpdate" rel="${info.id}" href="#">修改訂單</button>
		  		<!--<button id="btnDelete" rel="${info.id}" href="#">刪除訂單</button>  -->	
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
				window.location.href = '/Module_Project'+'login';
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
	
	// 修改鈕
	$('button[id=btnUpdate]').click(function() {
		var orderId = $(this).attr('rel');
		console.log(orderId);
		
		window.location.href = '/Module_Project'+'${urlPrefix}/'+orderId+'/update';
	});
	
	// 刪除鈕
	$('button[id=btnDelete]').click(function(){
		var memberId = $(this).attr('rel');
		console.log(memberId);
		
		if(confirm('確定刪除該訂單嗎?(刪除後無法復原)')){
			
			$.ajax({
				url: "${pageContext.request.contextPath}/backend/orderManage/"
				+ memberId+ '/delete',
				type: 'POST',
				success: function(data){
						alert('訂單已刪除!');
						window.location.href="";
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