<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="urlPrefix" value="/backend/productManage" />
<c:url var="formUrl" value="${urlPrefix}/query" />

<html>
<head>

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
* {text-align: center;}
.w3-pale-red {margin: 0;}
.w3-opacity {font-weight: bold;font-family: Microsoft JhengHei;}
</style>
</head>

<div class="w3-panel w3-pale-red">
	<h2 class="w3-opacity">商品後台管理系統</h2>
</div>
<!-- Logout -->
<p>
	<button class="btnOut"
		onclick="location.href='${pageContext.request.contextPath}/logout'">登出</button>
</p>

<!--Back to Backend index -->
<p>
	<button id="btnBack" class="w3-btn w3-blue-grey">回到後台首頁</button>
</p>

<!-- Top Button -->
	<a href="#"><input type="button" class="topbutton"></a>

<!-- Search Info -->
<form:form modelAttribute="modelAttribute" method="POST"
	action="${formUrl}">
	<div class="searchTable">
		<img src="${pageContext.request.contextPath}/resources/img/searchicon2.png" />
		<form:input path="product_name" autofocus="autofocus" />
		&nbsp;<button type="submit" id="btnQuery" class="btn btn-primary">查詢商品</button>
	</div>
</form:form>

<!-- side bar -->
<div class="w3-sidebar w3-bar-block w3-border-right" style="width:5%; top:65px; font-weight:bold">
  <a href="/Module_Project/backend/productManage" class="w3-bar-item w3-button">商品管理</a>
  <a href="/Module_Project/backend/orderManage" class="w3-bar-item w3-button">訂單管理</a>
  <a href="/Module_Project/backend/members" class="w3-bar-item w3-button">會員管理</a>
</div>

<!-- Add new Product -->
<button id="btnAdd" class="w3-button w3-red" 
style="right:100px;position:absolute;">新增商品</button>

<!--Show Info-->
<c:if test="${not empty queryResult}">
	<table border="1" class="orderTable" style="top:120px; position:absolute">
		<thead>
			<tr role="row" style="background: black; color: white">
				<th width="20%">商品圖片</th>
				<th width="20%">商品名稱</th>
				<th>分類</th>
				<th width="10%">價格</th>
				<th width="10%">庫存</th>
				<th>動作</th>
			</tr>
		</thead>
		<tbody role="alert" aria-live="polite" aria-relevant="all">

			<c:forEach var="info" items="${queryResult}">
				<tr>
					<td><img
						src='/Module_Project/resources/img/item${info.id}.png'
						style="width: 100px; height: 100px"></td>
					<td>${info.product_name}</td>
					<td>${info.product_tag.tag_name}</td>
					<td><span id="totalprice"><fmt:formatNumber value="${info.price}" type="currency" maxFractionDigits="0"/></span></td>
					<td>${info.storage}</td>
					<td>
						<button id="btnUpdate" rel="${info.id}" href="#">修改商品</button>
						<button id="btnShelf" class="status" rel="${info.id}" href="#">${info.shelf}</button>
					</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
</c:if>

<script type="text/javascript">
	$(function() {
		
		// 判斷上下架狀態顯示
		$( document ).ready(function() {
			$(".status").each(function(){
				if (this.innerHTML == 'true'){
					console.log(this.innerHTML);	
					$(this).html("下架").css("color", "red");
				} else{
					$(this).html("上架").css("color", "blue");
				}
			});
		})

		// 回到後台管理頁面
		$('#btnBack').click(function() {
			window.location.href = '${pageContext.request.contextPath}/backend/admin';
		});

		// 登出鈕
		$('#btnOut').click(function() {

			$.ajax({
				url : '/logout',
				type : 'GET',
				success : function(data) {
					window.location.href = '${pageContext.request.contextPath}/backend/admin';
				},
				error : function(Exception) {
					alert('發生錯誤!');
					window.location.href = "";
				}
			});
		});
		
		// 新增鈕
		$('#btnAdd').click(function() {
			window.location.href = '/Module_Project'+'${urlPrefix}/add';
		});

		// 查詢鈕
		$('#btnQuery').click(function() {
			var form = $('form#modelAttribute');
			form.find('input:text').each(function() {
				$(this).val($.trim($(this).val()));
			});
			form.submit();
		});

		// 修改鈕
		$('button[id=btnUpdate]').click(function() {
			var productId = $(this).attr('rel');
			console.log(productId);

			window.location.href = '/Module_Project' + '${urlPrefix}/'+ productId + '/update';
		});
		
		// 上下架按鈕
		$('button[id=btnShelf]').click(function() {
			var productId = $(this).attr('rel');
			console.log(productId);
			
			var yes = confirm("確認更改商品狀態?");
			
			if (!yes){
				location.href="";	
				
			} else {
				$.ajax({
					url : '${pageContext.request.contextPath}/backend/productManage/' + productId + '/shelf',
					type : 'GET',
					success : function(data) {
						if (data == 'done'){
							alert("已成功更新");
							window.location.href = "";
						}
					},
					error : function(Exception) {
						alert('發生錯誤!');
						window.location.href = "";
					}
				})
			}
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

})
</script>
</html>