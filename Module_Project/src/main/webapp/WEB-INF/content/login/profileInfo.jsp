<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="profile" value="/profile" />
<c:url var="formUrl" value="${profile}/update" /> 
    
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
    <script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>

<style>
.w3-ul{
	border-radius: 5px 5px 5px 5px;
	border:1px solid black;
	font-weight:bold;
	top:100px;
	width:50%;
	position:relative;
}
.w3-container{
	left:0;
	right:0;
	margin:auto;
	width:50%;
	border-radius:5px;
	border:1px solid darkblue;
}
.w3-blue{
	font-size:16px;
	font-weight:bold;
	padding-botton:10px;
}

</style>
</head>
<body>
	<!-- Navigator -->	
	<%@include file = "../index/navigator.jsp" %>
	
	<!-- action form -->
	
	<div class="w3-container w3-blue" style="margin-top:80px;">
  		<p>會員資料修改</p>
	</div>
	
	<form:form modelAttribute="modelAttribute" method="POST" class="w3-container" style="padding-top:20px">
		<label class="w3-text-teal"><b>會員帳號</b></label>
		<p class="w3-input w3-border w3-light-grey">${modelAttribute.account}</p>
		
		<label class="w3-text-teal"><b>輸入舊密碼</b></label>  <span id="spanOldPwd"></span>
		<input type="password" id="oldPassword" maxlength="12" autofocus="autofocus"
		class="w3-input w3-border" style="margin-top:15px; margin-bottom:15px;"
		required="required" />
		
		<label class="w3-text-teal"><b>新密碼</b></label>  <span id="spanPwd"></span>
		<input type="password" id="password" maxlength="12" size="20"
		class="w3-input w3-border" style="margin-top:15px; margin-bottom:15px"
		required="required" />

		<label class="w3-text-teal"><b>再次輸入密碼</b></label>  <span id="spanPwd2"></span>
		<input type="password" id="password2" maxlength="12" size="20" 
		class="w3-input w3-border" style="margin-top:15px; margin-bottom:15px;"
		required="required" />
		
		<!-- hidden pwd -->
		<input type="text" id="idCheck" style="display:none" value="${modelAttribute.id}">
		<input type="text" id="oldPwdCheck" style="display:none" value="${modelAttribute.password}">
		<form:input type="hidden" id="hiddenPassword" path="password"/>
		
		<label class="w3-text-teal"><b>連絡電話</b></label>  <span id="spanPhone"></span>
		<form:input type="text" id="phone" path="phone"
		size="20" maxlength="10" class="w3-input w3-border" style="margin-top:15px; margin-bottom:15px"/>

		<label class="w3-text-teal"><b>地址</b></label>
		<form:input type="text" path="address"
		size="50" maxlength="50" class="w3-input w3-border" style="margin-top:15px; margin-bottom:15px"/>
		
		<p>
		<button type="submit" id="submit" class="w3-btn w3-blue-grey">確認修改</button>
		<button type="button" class="w3-btn w3-blue-grey" id="btnBacks">返回會員中心</button>
		</p>
</form:form>
	
<!-- footer -->
<div class="w3-teal">
  <h5>©COPYRIGHT 2020 HOTPOTGO</h5>
  <p>All copyrights and trademarks are the property of their respective owners.</p>
</div>

<script>
// 返回會員中心頁
$('#btnBacks').click(function() {
	window.location.href = '<c:url value="/profile" />';
});

// 舊密碼檢查(是否與資料庫中密碼相同)
$('#oldPassword').blur(function(){
	var id = $("#idCheck").val();
	
	let inputPwd = document.getElementById("oldPassword");
	let originPwd = document.getElementById("oldPwdCheck");
	let spanPwd = document.getElementById("spanOldPwd");
    let pwd = inputPwd.value;

    $.ajax({
		url: '/Module_Project/backend/members/checkPassword?id=' + id + "&password=" + pwd,
		type: 'GET',
		success: function(data) {
			
			if (data == 'done'){
				spanPwd.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/correct.png' height='15' width='15'> 舊密碼符合";
		        spanPwd.style.color = "green";
		        spanPwd.style.fontSize = "0.8em";
		        $("#submit").attr("disabled", false);
		        
			} else {
		        spanPwd.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 舊密碼不符";
		        spanPwd.style.color = "red";
		        spanPwd.style.fontSize = "0.8em";
		        $("#submit").attr("disabled", true);
			}
		},
		error: function(xhr, textStatus, exception){
			spanPwd.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 舊密碼不符";
	        spanPwd.style.color = "red";
	        spanPwd.style.fontSize = "0.8em";
	        $("#submit").attr("disabled", true);
			
		}
	});
   
})

// 密碼檢查(英文數字與特殊符號)
$('#password').blur(function(){
	
	 let inputPwd = document.getElementById("password");
     let spanPwd = document.getElementById("spanPwd");
     let pwd = inputPwd.value;
     let pwdReg = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[\!\@\#\$\%\^\&\*\(\)])[0-9a-zA-Z\!\@\#\$\%\^\&\*\(\)]{8,12}$/;
	
     if (pwdReg.test(pwd)) {
         spanPwd.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/correct.png' height='15' width='15'> 格式正確";
         spanPwd.style.color = "green";
         spanPwd.style.fontSize = "0.8em";
         $("#submit").attr("disabled", false);
     } else {
         spanPwd.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 格式不正確";
         spanPwd.style.color = "red";
         spanPwd.style.fontSize = "0.8em";
         $("#submit").attr("disabled", true);
     }
})

// 電話檢查(數字)
$('#phone').blur(function(){
	 let inputPhone = document.getElementById("phone");
     let spanPhone = document.getElementById("spanPhone");
     let phone = inputPhone.value;
     let phoneReg = /^[0-9]{10}$/;
	
     if (phoneReg.test(phone)) {
    	 spanPhone.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/correct.png' height='15' width='15'> 格式正確";
    	 spanPhone.style.color = "green";
    	 spanPhone.style.fontSize = "0.8em";
    	 $("#submit").attr("disabled", false);
     } else {
    	 spanPhone.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 格式不正確";
    	 spanPhone.style.color = "red";
    	 spanPhone.style.fontSize = "0.8em";
    	 $("#submit").attr("disabled", true);
     }
})

// 二次驗證密碼檢查
	$('#password2').blur(function(){
	var password = $('#password').val();
	var password2 = $('#password2').val();
	var spanPwd2 = document.getElementById("spanPwd2");
	
	if (password == password2 && password2!= "") {
		spanPwd2.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/correct.png' height='15' width='15'> 二次密碼符合";
		spanPwd2.style.color = "green";
   	 	spanPwd2.style.fontSize = "0.8em";
   	 	$("#submit").attr("disabled", false);
   	 	
   	// 密碼放進hidden input裡面
		$('#hiddenPassword').val(password);

	} else {
		spanPwd2.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 與上述密碼不符";
		spanPwd2.style.color = "red";
		spanPwd2.style.fontSize = "0.8em";
		$("#submit").attr("disabled", true);
	}
})

// 修改資料
$('form#modelAttribute').submit(function(event) {
	event.preventDefault();
	
	$.ajax({
		url: '${formUrl}',
		type: 'POST',
		data: $('form#modelAttribute').serialize(),
		success: function(data, textStatus, xhr) {
			alert("修改成功");
			window.location.href = '<c:url value="/profile" />';
		},
		error: function(xhr, textStatus, exception){
			alert("發生錯誤");
			window.location.href ="";
		}
	});
});

</script>
</body>
</html>