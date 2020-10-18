<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="sum" value="${0}" />

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
	
	<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

</head>
<body>
	<!-- Navigator -->	
	<%@include file = "../index/navigator.jsp" %>
	
	<!-- paymentinfo -->
	<div class="w3-row-padding w3-theme">
	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP1.</h4>
		<p>確認商品後結帳</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4 w3-pink">
		<img src="" style="width:100%">
		<div class="w3-container">
		<h4>STEP.2</h4>
		<p>選擇付款方式與填寫配送地址</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP.3</h4>
		<p>訂單成立</p>
		</div>
		</div>
	</div>
</div>

	<!-- show order -->
	<form:form modelAttribute="modelAttribute" method="POST">	
	<table class="w3-table-all w3-hoverable" style="left:0; right:0; margin:auto; width:50%;">
			<tr class="w3-pale-yellow">
				<td colspan="3">
					<H1><span style="color:darkblue">訂單資料</span></H1>
				</td>
			</tr>
			<tr class="w3-dark-grey" style="font-weight:bold">
				<td colspan="3" style="font-size:18px">訂單明細</td>
			</tr>			
			<c:forEach var="cartlist" items="${cart}">
			<c:set var="sum" value="${sum + (cartlist.price * cartlist.quantity)}"></c:set>
			</c:forEach>
			<tr>
				<td colspan="2" class="totalTitle">本次消費金額</td>
				<td><span id="totalprice"><fmt:formatNumber value="${sum}" type="currency" maxFractionDigits="0"/></span></td>
				<form:input type="hidden" path="total" value="${sum}"></form:input>
			</tr>
			<tr>
				<td colspan="2" class="totalTitle">顧客名稱<span id="totalprice">(*必填)</span></td>
				<td class="address">
				<form:input type="text" path="member_name" value="${account}" required="required"></form:input></td>
				<form:input type="hidden" path="member_id" value="${userid}"></form:input>
			</tr>
			<tr>
				<td colspan="2" class="totalTitle">連絡電話<span id="totalprice">(*必填)</span></td>
				<td class="address">
				<form:input type="text" path="phone" value="${phone}" maxlength="10" required="required"></form:input></td>
			</tr>
			<tr>
				<td class="totalTitle">配送地址<span id="totalprice">(*必填)</span></td>
				<td colspan="2">
				<div id="twzipcode">
					<div class="capital" data-role="county"></div>
					<div class="district" data-role="district"></div>
				</div>
					<form:input type="text" path="address" class="address form-control" required="required"></form:input>
				</td>
			</tr>
			<tr>
				<td class="totalTitle">付款方式</td>
				<td colspan="2">
					<input class="w3-radio" type="radio" name="pay_way" value="1" checked>
					<label>貨到付款(現金)</label>
					<input class="w3-radio" type="radio" name="pay_way" value="2">
					<label>信用卡</label>
					<input class="w3-radio" type="radio" name="pay_way" value="3">
					<label>LINEPAY</label>
				</td>
			</tr>
			<tr>
				<form:input type="hidden" path="addressPrefix" id="addressall"></form:input>
				<form:input type="hidden" path="status" value="1"></form:input>
				<td colspan="3" style="text-align:center">
				<button type="submit" id="pay">確認送出</button></td>
			</tr>
		</table>
</form:form>
		
		<!-- back to previous page -->
		<table class="keepTable" style="position:relative">
			<tr>
				<td colspan="5">
					<button class="keepBtn" id="btnBack">回前頁</button>
				</td>
			</tr>
		</table>
		
<!-- footer -->
<div class="w3-teal">
  <h5>©COPYRIGHT 2020 HOTPOTGO</h5>
  <p>All copyrights and trademarks are the property of their respective owners.</p>
</div>

<script type="text/javascript">
// 返回前頁
$('#btnBack').click(function() {
	window.history.back();
});

//地址預設值
$('#twzipcode').twzipcode({
    countySel   : '臺北市',
    districtSel : '大安區',
    zipcodeIntoDistrict: true,
    css: ["city form-control", "town form-control"],
    countyName: 'county[]', // 指定城市 select name
    districtName: 'district[]' // 指定地區 select name
});

//送出後回到查詢頁並更新
$('form#modelAttribute').submit(function(event) {
	event.preventDefault();
	
	var addressPrefix = $('#twzipcode').twzipcode('get', 'county,district,zipcode');
	var addressall = addressPrefix[2] + addressPrefix[0] + addressPrefix[1];
	console.log(addressall);
	$('#addressall').val(addressall);
	
	var check = confirm("確認購買？");
	if(check){
	
	$.ajax({
		url: '/Module_Project/order/add',
		type: 'POST',
		data: $('form#modelAttribute').serialize(),
		success: function(data, textStatus, xhr) {
			window.location.replace("${pageContext.request.contextPath}/order/success");
		},
		error: function(xhr, textStatus, exception){
			alert("訂單送出失敗");
			window.location.href ="";
		}
	});
	} else {
			window.location.href ="";
		}	
});

</script>

</body>
</html>
