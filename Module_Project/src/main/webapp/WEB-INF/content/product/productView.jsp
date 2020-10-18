<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="product" value="/product" />

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

<style>
body{background:url(https://i.imgur.com/RL6zNty.png) no-repeat;}

#total, #quantity{color:red;font-weight:bold;font-size:19px;}
#text_box{width:30px;text-align: center;background:white;}

</style>
</head>
<body>
	<!-- Navigator -->	
	<%@include file = "../index/navigator.jsp" %>

	<!-- shopping cart -->
    <%@include file = "../index/cartBtn.jsp" %>

	<!-- Sidebar -->
	<%@include file = "../index/sidebar.jsp" %>

	<!-- search goods -->
	<%@include file = "productSearch.jsp" %>
	
	<div>
		<div class="viewTable">
			<img src='/Module_Project/resources/img/item${fn:escapeXml(modelAttribute.id)}.png' style="width:300px;height:300px">
		</div>
		<div class="viewTable2">
			<label>【商品名稱】</label>
			<p>${fn:escapeXml(modelAttribute.product_name)}</p>
			
			<label>【商品描述】</label>
			<p>${fn:escapeXml(modelAttribute.detail)}</p>
			<span id="tag" style="display:none">${fn:escapeXml(modelAttribute.tag)}</span>
		
			<label>【售價】</label>
			<p style="color:red; font-weight:bold; font-size:19px">
				<fmt:formatNumber value="${fn:escapeXml(modelAttribute.price)}" type="currency" maxFractionDigits="0"/>
			</p>
			
			<label>【庫存數量】</label>
			<p style="color:purple; font-weight:bold; font-size:15px;left:10px">
				${fn:escapeXml(modelAttribute.storage)}
			</p>
			
		</div>
</div>

		<div class="viewTable3">
			<div id="hideNum">
			<label style="color:white; font-size:16px">選擇數量:  </label>
				<select id="nums" style="width:50px;">
					<c:forEach var="i" begin="1" end="10" varStatus="loop">
						<option value="${i}">${i}</option>
					</c:forEach>
				</select>
			<p style="color:white; font-size:16px">
				共 <span id="quantity">1</span> 份<span id="total" style="display:none"></span>
			</p>
			</div>
			<p style="float:right; position:relative">
				<button type="button" class="add w3-button w3-red" id="${productid}">加入購物車</button>
			</p>
		</div>

<script type="text/javascript">

$(function(){

	// 湯底只能選1
	var tag = $('#tag').val();
	if (tag == 1){
		$('#hideNum').hide();
	}
	
	// 數量選擇
	$('#nums').click(function(){

	function setTotal(){
		var quantity = 0;
		var total = 0;
		var single = parseInt(${fn:escapeXml(modelAttribute.price)});
		
		quantity = parseInt($('#nums').val());
		
		$("#quantity").html(quantity);
		
		total = (quantity*single);
		$("#total").html(total);
	}
		setTotal();
	})		
})
	
// 加入購物車
	$('.add').click(function(){
		var productid = $(this).attr("id");
		var num = parseInt($('#nums').val());
				
		$.ajax({
			url: "/Module_Project/shopcart/add?id=" + productid + "&quantity=" + num,
			type:"GET",
			success: function(data){	
				if(data == "soldout"){
					window.alert("商品庫存不足，請重新選擇數量");
				} else {
					window.alert("已加入購物車!");
				}
/*				else {
					window.alert("請先登入!")
					window.location.href = '${pageContext.request.contextPath}/login';
				}
*/				
			}
		});
	})

</script>
</body>
</html>
