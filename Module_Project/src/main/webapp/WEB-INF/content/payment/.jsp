<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="product" value="/product" />
<c:set var="sum" value="${0}" />

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

<style>
#totalprice{ color:red; font-size:18px; font-weight:bold; }
.totalTitle{
	font-size:18px;
	font-weight:bold;
	left:0;
	rigth:0;
	margin:auto;
}
.keepBtn{
	font-weight:bold;
	font-size: 14px;
    width: 100px;
    height: 30px;
    background:  -webkit-linear-gradient( rgb(238, 215, 113), rgb(231, 169, 35));
    box-shadow: 2px 2px 2px rgb(92, 79, 23);
    border-radius: 10px;
    padding: 5px;
}
.pay{
    font-weight:bold;
	font-size: 20px;
    width:120px;
  	background: -webkit-linear-gradient( rgb(248, 205, 141), rgb(223, 131, 70));
  	box-shadow: 1px 1px 1px #293136;
  	border-radius: 10px;
  	padding: 10px 15px;
 	border: 2px inset #A33B37;    
}
.keepTable{
	left:0;
	right:0;
	margin:auto;
	margin-top:100px;
	width:50%;
}
</style>

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
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP.3</h4>
		<p>訂單成立</p>
		</div>
		</div>
	</div>
</div>
	
	
	<!-- show cartList -->
	<table class="w3-table-all w3-hoverable" 
	style="left:0; right:0; margin:auto; width:50%; table-layout:fixed">
			<tr class="w3-light-blue">
				<td colspan="2">
					<H1><span style="color:darkblue">購物車</span>
						<img src="img/Info_icon.png" title=""></H1>
				</td>
				<td colspan="3" style="text-align:right"><a href="#"><input type="button" class="morebutton"
							value="查詢歷史訂單"></a></td>
			</tr>
			<tr class="w3-dark-grey" style="font-weight:bold">
				<td>商品圖片</td>
				<td>商品名稱</td>
				<td>數量</td>
				<td>價錢</td>
				<td></td>
			</tr>			
	<c:forEach var="cartlist" items="${cart}">
	<c:set var="sum" value="${sum + (cartlist.price * cartlist.quantity)}"></c:set>
			<tr style="text-align:center;font-weight:bold">
				<td><img src="#" width="230px"></td>
				<td>${cartlist.productname}</td>
				<td>${cartlist.quantity}</td>
				<td>$ ${cartlist.price * cartlist.quantity}</td>
				
				<!--商品資訊按鈕-->
				<td>
					<a href='<c:url value="${product}/${cartlist.id}/view" />'>
					<button class="infobutton">商品資訊</button></a>
					<button class="deletecart" id="${cartlist.id}" >刪除</button>
				</td>
			</tr>
	</c:forEach>
			<tr>
				<td colspan="3" class="totalTitle">總計</td>
				<td><span id="totalprice">$ ${sum}</span></td>
				<td></td>
			</tr>
			<tr>
				<td colspan="5" style="text-align:center"><button class="pay" id="pay">結帳</button></td>
			</tr>
		</table>
		
		<table class="keepTable">
			<tr>
				<td colspan="5" style="text-align:center">
					<button class="keepBtn" id="btnBack">繼續選購</button>
				</td>
			</tr>
		</table>
		

<!-- footer -->
<div class="w3-teal">
  <h5>©COPYRIGHT 2020 HOTPOTGO</h5>
  <p>All copyrights and trademarks are the property of their respective owners.</p>
</div>

<script type="text/javascript">

// 返回商店頁
$('#btnBack').click(function() {
	window.location.href = '<c:url value="/product" />';
});

//移除購物車
$('.deletecart').click(function(){
	var productid = $(this).attr("id");
			
	$.ajax({
		url: "/Module_Project/shopcart/delete?id=" + productid,
		type:"GET",
		success: function(data){
			if(data == "done"){
				window.location.href="";
			} else {
				window.alert("發生錯誤")
			}
		}
	});
})



</script>


</body>
</html>
