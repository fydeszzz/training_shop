<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
	<meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<title>HOTPOTGO - 火鍋宅急便</title>
	
    <!-- Favicon  -->
    <link rel="icon" href="img/core-img/favicon.ico">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

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
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP.2</h4>
		<p>選擇付款方式與填寫配送地址</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4  w3-pink">
		<img src="" style="width:100%">
		<div class="w3-container">
		<h4>STEP.3</h4>
		<p>訂單成立</p>
		</div>
		</div>
	</div>
</div>

	<div class="w3-panel w3-green" style="width:50%; left:0; right:0; margin:auto">
  		<h3>訂單已成立！</h3>
  		<p>我們將盡快將食材送達您指定的地址！</p>
	</div>
		
		<!-- back to index page -->
		<table class="keepTable">
			<tr>
				<td colspan="5" style="text-align:center">
					<button class="keepBtn" id="btnBackIndex">回首頁</button>
				</td>
			</tr>
		</table>
		
<!-- footer -->
<div class="w3-teal">
  <h5>©COPYRIGHT 2020 HOTPOTGO</h5>
  <p>All copyrights and trademarks are the property of their respective owners.</p>
</div>

<script type="text/javascript">
//返回首頁
$('#btnBackIndex').click(function() {
	window.location.href = '<c:url value="/index"/>';
});
</script>

</body>
</html>
