<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="RegisterPrefix" value="/register" />
<c:set var="LoginPrefix" value="/login" />
<c:url var="RegisterUrl" value="${RegisterPrefix}" />
<c:url var="LoginUrl" value="${LoginPrefix}" />
<c:url var="BackendUrl" value="/backend/members" />

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


</style>

</head>
<body>

	<!-- Navigator -->
	<%@include file="../index/navigator.jsp"%>

	<!-- Register -->
	<div class="registerform2">
		<div class="w3-container w3-amber">
			<h3>會員註冊</h3>
		</div>
		<form:form modelAttribute="modelAttribute" id="registerForm2"
			class="w3-container" method="POST">
			<p>
				<label class="w3-text-pink"><b>新帳號(請輸入6-12碼英文數字)</b></label>
				<form:input path="account" id="account" class="w3-input w3-border w3-light-grey"
					style="width:50%;left:0;right:0;margin:auto;" maxlength="12"
					required="required" autofocus="autofocus" />
					<span id="spanAccount"></span>
			</p>
			<p>
				<label class="w3-text-pink"><b>輸入密碼(請輸入8-12碼英文數字與至少1個特殊符號)</b></label>
				<form:input type="password" path="password" id="password"
					class="w3-input w3-border w3-light-grey"
					style="width:50%;left:0;right:0;margin:auto;" maxlength="12"
					required="required" />
					<span id="spanPwd"></span>
			</p>
			<p>
				<label class="w3-text-pink"><b>再次輸入密碼</b></label>
				<input type="password" id="password2"
					class="w3-input w3-border w3-light-grey"
					style="width:50%;left:0;right:0;margin:auto;" maxlength="12"
					required="required" />
					<span id="spanPwd2"></span>
			</p>
			<p>
				<label class="w3-text-pink"><b>連絡電話</b></label> 
				<form:input type="text" path="phone" id="phone" class="w3-input w3-border w3-light-grey"
					style="width: 50%; left: 0; right: 0; margin: auto;" maxlength="10"
					required="required" />
					<span id="spanPhone"></span>
			</p>
			<p>
				<label class="w3-text-pink"><b>地址</b></label> 
				<form:input type="text" path="address" id="address" class="w3-input w3-border w3-light-grey"
					style="width: 50%; left: 0; right: 0; margin: auto;" maxlength="50"
					required="required" />
			</p>
			<p>
				<button type="submit" id="submit" class="w3-btn w3-blue-grey">送出</button>
				<button type="reset" class="w3-btn w3-blue-grey">清除</button>
			</p>
		</form:form>
	</div>
	
<script type="text/javascript">
	// 帳號名稱檢查(英文數字混合)
	$('#account').blur(function(){
		
       let inputAccount = document.getElementById("account");
       let spanAccount = document.getElementById("spanAccount");
       let account = inputAccount.value;
       let result = true;
       let accountReg = /^(?=.*[0-9])(?=.*[a-zA-Z])[0-9a-zA-Z]{6,12}$/;
	
       if (accountReg.test(account)) {
    	   spanAccount.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/correct.png' height='15' width='15'> 格式正確";
    	   spanAccount.style.color = "green";
    	   spanAccount.style.fontSize = "0.8em";
    	   
    	   $.ajax({
   			url: '${BackendUrl}/check?account=' + account,
   			type: 'GET',
   			success: function(data) {
   				console.log(data);
   				
   				if (data == 'done'){
   					spanAccount.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/correct.png' height='15' width='15'> 格式正確";
   					
   				} else {
   					spanAccount.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 已有相同名稱的帳號";
   					spanAccount.style.color = "red";
   					$("#submit").attr("disabled", true);
   				}
   			},
   			error: function(xhr, textStatus, exception){
   				alert("發生錯誤，請重新嘗試");
   				$("#submit").attr("disabled", true);
   			}
   		});
       
       } else {
    	   spanAccount.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 格式不正確";
    	   spanAccount.style.color = "red";
    	   spanAccount.style.fontSize = "0.8em";
    	   $("#submit").attr("disabled", true);
       }

	});
	
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
   	 	
	} else {
		spanPwd2.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 與上述密碼不符";
		spanPwd2.style.color = "red";
		spanPwd2.style.fontSize = "0.8em";
		$("#submit").attr("disabled", true);
	}
})

//註冊驗證(待接)
$('form#modelAttribute').submit(function(event) {
	event.preventDefault();

	$.ajax({
		url: '/Module_Project/register',
		type: 'POST',
		data: $('form#modelAttribute').serialize(),
		success: function(data) {
			
			if (data == "success"){
				alert("新增會員成功!請重新登入");
				window.location.href ="${LoginUrl}";
				
			} else {
				alert("已有相同名稱的帳號");
				window.location.href ="";
			}

		},
		error: function(exception){
			alert("發生錯誤!");
			window.location.href ="";
		}
	});
	 
});	
</script>
</body>
</html>