<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="product" value="/product" />
<c:url var="formUrl" value="${product}/query" /> 
    
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
 
<style>
body{background:url(https://i.imgur.com/RL6zNty.png) no-repeat;}
</style>
<script>
	// 圖片輪播
		var nowTitle = 0;
		var nowAD = 0;
		var maxAD = 3;
		var intervalAD;
		var intervalTitle;
		
		var adStatus = true;
	    var intervalTime = 2800;
		var myCanvas;
		var ctx;
		var preImg;
		var timeouts = [];
		var backFlag = false;
		var tempAD = maxAD;
		
		document.addEventListener("DOMContentLoaded", init);
		
		function init() {
			genereteChangeBtn();
			titleChange();
			
			for (let i = 1; i <= maxAD; i++) {
				document.getElementById("ad" + i).addEventListener("click",
					changebtn);
				document.getElementById("myCanvas").addEventListener(
					"mouseover", pause);
				document.getElementById("myCanvas").addEventListener(
					"mouseout", keepgo);
				document.getElementById("eventimginfo").addEventListener(
						"mouseover", pause);
				document.getElementById("eventimginfo").addEventListener(
						"mouseout", keepgo);
			}
			myCanvas = document.getElementById("myCanvas");
			ctx = myCanvas.getContext("2d");
			preImg = document.getElementById("mainImg1");
			intervalAD = setInterval(cycleAD, intervalTime);
		}
		
		// 輪播商品標題		
		function titleChange(){
			var q = ['', '無骨牛小排', '四片豬肉','新鮮魚片']; 
				
			function quoteChange (target, quotes) { 
		    		if (!quotes || !target) { 
		     		return false; 
		     		
		    	}else {		
		      		nowTitle = tempAD;
		      		text = 'textContent' in document ? 'textContent' : 'innerText' 
			     	target[text] = quotes[nowTitle];
		    }
		  } 
				intervalTitle = setInterval(function(){
					quoteChange(document.getElementById('eventimginfo'), q);
				}, intervalTime); 
		}	

		function genereteChangeBtn() {
			let html = "";
			for (let i = 1; i <= maxAD; i++) {
				html = html + "<img id='ad" + i + "'src='https://i.imgur.com/G6c3Q6u.png'>";
			}
			document.getElementById("chimg").innerHTML = html;
		}
		function cycleAD() {
			while (timeouts.length != 0) {
				let i = timeouts.length - 1;
				clearTimeout(timeouts[i]);
				timeouts.pop();
			}
			preImg = document.getElementById("mainImg" + tempAD);
			nextAD();
			
			if (tempAD == 1 && nowAD == maxAD) {
				backFlag = true;
			} else if (tempAD == maxAD && nowAD == 1) {
				backFlag = false;
			} else if (tempAD > nowAD) {
				backFlag = true;
			}
			
		// 可導向網頁的圖片連結(之後再接網頁內的商品)
			let nowImg = document.getElementById("mainImg" + nowAD);
			for (let x = 0; x <= 390; x++) {
				let x1;
				let x2;
				if (backFlag) {
					x1 = 0 + x;
					x2 = x - 390;
				} else {
					x1 = 0 - x;
					x2 = 390 - x;
				}
				timeouts.push(setTimeout(function () {
					ctx.drawImage(preImg, x1, 0, 390, 300);
					ctx.drawImage(nowImg, x2, 0, 390, 300);
				}, x));
			}
			backFlag = false;
			tempAD = nowAD;
		}
		function nextAD() {
			nowAD += 1;
			if (nowAD > maxAD) {
				nowAD = 1;
			}
			for (let i = 1; i <= maxAD; i++) {
				if (i == nowAD) {
					document.getElementById("ad" + i).style.filter = "none";
				} else {
					document.getElementById("ad" + i).style.filter = "grayscale(100)";
				}
			}
		}
		function pause() {
			clearInterval(intervalAD);
			clearInterval(intervalTitle);	
		}
		function keepgo() {
			titleChange();
			intervalAD = setInterval(cycleAD, intervalTime);
		}
		function changebtn() {
			if (this.id.charAt(2) == 1) {
				nowAD = maxAD;
			} else {
				nowAD = this.id.charAt(2) - 1;
			}
			changeAD();
		}
		function changeAD() {
			cycleAD();
			if (adStatus) {
				clearInterval(intervalAD);
				intervalAD = setInterval(cycleAD, intervalTime);
			}
		}
</script>    
</head>
<body>
	<!-- Navigator -->	
	<%@include file = "navigator.jsp" %>
	
	<!-- shopping cart -->
    <%@include file = "cartBtn.jsp" %>

	<!-- Sidebar -->
	<%@include file = "sidebar.jsp" %>
	
	<!-- Search bar -->
	<%@include file = "../product/productSearch.jsp" %>

	<!-- banner -->
	 	<fieldset class="picArea">
			<figure>
				<a id="mainUrl" href="${pageContext.request.contextPath}/product">
					<canvas id="myCanvas"width="390px" height="300px">
						<img id="mainImg1" src="https://i.imgur.com/s4P683h.jpg" style="display: none" alt="" />
						<img id="mainImg2" src="https://i.imgur.com/FV6UgXB.png" style="display: none" alt="" />
						<img id="mainImg3" src="https://i.imgur.com/vESFtJk.jpg" style="display: none" alt="" />
					</canvas>
				</a>
						<div id="eventimginfo"></div>
						<div id="chimg"></div>
			</figure>
		</fieldset>

<div class="info">
	<div class="w3-container w3-theme-d4">
		<p class="w3-large">◎簡單三步驟完成自助火鍋◎</p>
	</div>

<div class="w3-row-padding w3-theme">
	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP1.</h4>
		<p>挑選湯底</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP.2</h4>
		<p>再挑選喜愛的食材</p>
		</div>
		</div>
	</div>

	<div class="w3-third w3-section">
		<div class="w3-card-4">
		<img src="" style="width:100%">
		<div class="w3-container w3-white">
		<h4>STEP.3</h4>
		<p>結帳後外送到府煮鍋(或自煮)</p>
		</div>
		</div>
	</div>
</div>
</div>

<!-- footer -->
<div class="w3-teal">
  <h5>©COPYRIGHT 2020 HOTPOTGO<a href="${pageContext.request.contextPath}/backend"><img src="https://i.imgur.com/vZG2ZTC.png" style="width:20px"></a></h5>
  <p>All copyrights and trademarks are the property of their respective owners.</p>
</div>

</body>
</html>