<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="urlPrefix" value="/backend/productManage" />
<c:url var="formUrl" value="${urlPrefix}/query" />

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

</head>
<body>
	<!-- Navigator -->	
	<%@include file = "../index/navigator.jsp" %>
	
	<!-- show orderRecord -->
	<table class="w3-table-all w3-hoverable" 
	style="left:0; right:0; margin:auto; width:70%;">
			<tr class="w3-amber">
				<td colspan="2">
					<H1><span>訂單紀錄</span></H1>
				</td>
				<td colspan="5"></td>
			</tr>
			<tr class="w3-dark-grey" style="font-weight:bold">
				<td>顧客名稱</td>
				<td>配送地址</td>
				<td>消費總金額</td>
				<td>付款方式</td>
				<td>消費日期</td>
				<td>配送狀態</td>
				<td></td>
			</tr>
<c:forEach var="record" items="${record}">
			<tr style="text-align:center;font-weight:bold">
				<td>${record.member_name}</td>
				<td>${record.address}</td>
				<td><span id="totalprice"><fmt:formatNumber value="${record.total}" type="currency" maxFractionDigits="0"/></span></td>
				<td>${record.method.method}</td>
				<td><fmt:formatDate value="${record.order_date}" type="both"/></td>
				<td>${record.delivery.status_name}</td>
				
				<!--訂單詳細資訊按鈕-->
				<td>
					<button class="detailBtn" id="${record.id}">詳細購買清單</button>	
				</td>
			</tr>
</c:forEach>			
			<tr>
				<td colspan="7" style="text-align:center"><button type="button" id="btnBackIndex">回會員中心首頁</button></td>
			</tr>
</table>
		<table class="detailTable w3-table-all w3-hoverable"
				style="left:0; right:0; margin:auto; width:70%;table-layout: fixed;">
			<tr class="detailTable w3-dark-grey">
				<td>商品圖片</td>
				<td colspan="2">產品名稱</td>
				<td colspan="2">數量</td>
				<td colspan="2">消費金額</td>
			</tr>
		</table>

		<table id="content" class="detailTable w3-table-all w3-hoverable" 
				style="left:0; right:0; margin:auto; width:70%;table-layout: fixed;">
		</table>
<script type="text/javascript">
	// 返回會員中心頁
	$('#btnBackIndex').click(function() {
		window.location.href = '<c:url value="/profile" />';
	});

	// 顯示詳細購買清單
	$('.detailBtn').click(function() {
		
		var orderid = $(this).attr("id");
		console.log(orderid);
	
		$.ajax({
			url: '/Module_Project/order/query?id=' + orderid,
			contentType: 'application/json; charset=utf-8',
			type: 'GET',
			dataType: 'JSON',
			success: function(data) {			
				var txt = '';
					
				for (let i = 0; i < data.length; i++) {
					txt += "<tr style='text-align:center;font-weight:bold'><td>" 
					+ "<img src='${pageContext.request.contextPath}/resources/img/item" + data[i].product_id + ".png' style='width:100px;height:100px'>" 
					+ "<td colspan='2'>" + data[i].product.product_name 
					+ "</td><td colspan='2'>" + data[i].quantity + "</td><td colspan='2'> $" 
					+ data[i].sum + '</td></tr>';
				}
					txt + '';
					$("#content").html(txt);
				}
			})
	})
</script>
</body>
</html>