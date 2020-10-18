<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="product" value="/product" />
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

<style>
.price{margin-left:100px;}

</style>
</head>
<body>

	<!-- Navigator -->	
	<%@include file = "../index/navigator.jsp" %>
	
	<!-- paymentinfo -->
	<div class="w3-row-padding w3-theme">
	<div class="w3-third w3-section">
		<div class="w3-card-4 w3-pink">
		<div class="w3-container">
		<h4>STEP1.</h4>
		<p>確認商品後結帳</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<div class="w3-container w3-white">
		<h4>STEP.2</h4>
		<p>選擇付款方式與填寫配送地址</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<div class="w3-container w3-white">
		<h4>STEP.3</h4>
		<p>訂單成立</p>
		</div>
		</div>
	</div>
</div>

	<!-- show cartList -->
	<table class="w3-table-all" 
	style="left:0; right:0; margin:auto; width:50%; table-layout:fixed">
			<tr class="w3-light-blue">
				<td colspan="2">
					<H1><span style="color:darkblue">購物車</span></H1>
				</td>
				<td colspan="3" style="text-align:right"><a href="/Module_Project/order/view">
				<input type="button" class="morebutton" value="查詢歷史訂單"></a></td>
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
				<td><img src='/Module_Project/resources/img/item${cartlist.id}.png' style="width:80px;height:80px"></td>
				<td>${cartlist.product_name}</td>
				
				<td colspan="2">
					<input class="min" type="button" value="-" /> 
					<input id="text_box${cartlist.id}" type="button" value="${cartlist.quantity}"/> 
					<input class="max" type="button" value="+" />
				
					<input type="hidden" class="hideid" value="${cartlist.id}">
					<input type="hidden" class="hideprice" value="${cartlist.price}">
					<input type="hidden" class="hidetag" value="${cartlist.tag}">
					<input type="hidden" class="hidequantity" value="${cartlist.quantity}">
					<button type="button" class="update" style="display:none" id="${cartlist.id}">測試修改用</button>		
					<span id="total${cartlist.id}" class="price">
					<fmt:formatNumber value="${cartlist.price * cartlist.quantity}" type="currency" maxFractionDigits="0"/></span>
				</td>

				<td class="tagcheck" style="display:none">${cartlist.tag}</td>
				<!--商品資訊按鈕-->
				<td>
					<a href='<c:url value="${product}/${cartlist.id}/view" />'>
					<button class="infobutton">商品資訊</button></a>
					<button class="deletecart" id="${cartlist.id}">刪除</button>
				</td>
			</tr>
	</c:forEach>			
			<tr>
				<td colspan="3" class="totalTitle">總計</td>
				<td><span id="totalprice"><fmt:formatNumber value="${sum}" type="currency" maxFractionDigits="0"/></span></td>
				<td><button class="keepBtn" id="btnBackIndex">繼續選購</button></td>
			</tr>
			<tr>
				<td colspan="5" style="text-align:center"><button class="pay" id="pay">結帳</button></td>
			</tr>
	</table>
	
<script type="text/javascript">

$(function(){
//返回商店頁
$('#btnBackIndex').click(function() {
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

// 載入網頁時判斷湯底無法改變數量
$( document ).ready(function() {
	$(".tagcheck").each(function(){
		if (this.innerHTML == "1"){
			$(this).parent().find(".max").attr("disabled","disabled");
			$(this).parent().find(".min").attr("disabled","disabled");
		} 
	});
});

$(function(){
	
	// 數量選擇
	var total = 0;
	
		$(".max").click(function(){
			var id = $(this).parent().find('.hideid').val();
			var tag = $(this).parent().find('.hidetag').val();
			var singleprice = parseInt($(this).parent().find('.hideprice').val());
			var t = $(this).parent().find('input[id*=text_box'+ id + ']');

				if (t.val()>=10){
					t.val(10);
					$(this).attr("disabled","disabled");
					
				} else {

					$.ajax({
						url: "/Module_Project/shopcart/storage?id=" + id + "&quantity=" + t.val(),
						type:"GET",
						success: function(data){

							if(data == "done"){
								t.val(parseInt(t.val())+1);
								var quantity = (parseInt(t.val()));
								total = (quantity*singleprice);
								$(this).parent().find('span[id*=total'+ id + ']').html(total);
				
								$(".update").trigger("click");
								location.reload();
								
							} else {
								$(this).attr("disabled","disabled");
							}
						}
					});
			}
		})
		
		$(".min").click(function(){
			var id = $(this).parent().find('.hideid').val();
			var singleprice = parseInt($(this).parent().find('.hideprice').val());
			var t = $(this).parent().find('input[id*=text_box'+ id + ']');
			t.val(parseInt(t.val())-1)
			
			if (parseInt(t.val())<1){
				t.val(1);
				$(this).attr("disabled","disabled");
				$(this).parent().find(".max").attr("disabled","disabled");
				
				total = singleprice;
				$(this).parent().find('span[id*=total'+ id + ']').html(total);
				
				$(".update").trigger("click");
				location.reload();
				
			} else{
				var quantity = (parseInt(t.val()));
				total = (quantity*singleprice);
				$(this).parent().find('span[id*=total'+ id + ']').html(total);
			
				var originSum = document.getElementById('totalprice').innerHTML;
				var finalTotal = parseInt(originSum) - singleprice;
				$(".update").trigger("click");
				location.reload();
			}
		})

		$('.update').click(function(){	
		var productid = $(this).attr("id");
		var num = parseInt($('input[id*=text_box'+ productid + ']').val());
				
		$.ajax({
			url: "/Module_Project/shopcart/update?id=" + productid + "&quantity=" + num,
			type:"GET",
			success: function(data){
				if(data == "done"){
					
				} else {
					window.alert("發生錯誤")
				}
			}
		});
	})
})

// 導入結帳頁面
$("#pay").click(function(){
	var totalprice = document.getElementById("totalprice").innerHTML;	
	var count = 0;
	var otherProduct = 0;
	
	$(".tagcheck").each(function(){
		if (this.innerHTML == "1"){
			count++;
		} else{
			otherProduct++;
		}
	});
		if (count == 0){
			window.alert("請至少選擇一種湯底!");
			window.location.href="";
		} else{	
			if (totalprice == "0" || otherProduct == 0){
				window.alert("請挑選一樣食材或甜點飲料");
				window.location.href="";
			} else{
				window.location.href="${pageContext.request.contextPath}/order";
			}
		}
	})
})

</script>
</body>
</html>
