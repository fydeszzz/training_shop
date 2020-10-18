<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="urlPrefix2" value="/backend/members" />
<c:url var="queryPageUrl" value="${urlPrefix2}/query" />

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
.w3-table-all{
	left:0;
	right:0;
	margin:auto;
	top:100px;
	width:50%;
	position:absolute;
}
</style>

<form:form modelAttribute="modelAttribute2" method="POST">
<table class="w3-table-all">
	<thead>
	      <tr class="w3-pale-green">
	        <th colspan="2">
	        	<span style="font-weight:bold">修改會員資料</span>
	        </th>
	      </tr>
    </thead>
	<tbody>
		<tr>
			<td>會員編號：</td>
			<td>${modelAttribute2.id}</td>
		</tr>
		<tr>
			<td>會員帳號：</td>
			<td>${modelAttribute2.account}</td>
		</tr>	
		<tr>
			<td>修改密碼：</td>
			<td><form:input type="password" id="password" path="password" size="20" maxlength="12" required="required"/>
				<span id="spanPwd"></span></td>
		</tr>
		<tr>
			<td>修改電話：</td>
			<td><form:input type="text" id="phone" path="phone" size="20" maxlength="10" required="required" />
			<span id="spanPhone"></span></td>
		</tr>
		<tr>
			<td>修改地址：</td>
			<td><form:input type="text" path="address" size="50" maxlength="50" required="required"/></td>
		</tr>
		
	</tbody>
		<tr>
			<td colspan="2" style="text-align:center">
			<button type="submit" id="submit">確認修改</button></td>
		</tr>
</table>
</form:form>

<button class="w3-btn w3-blue-grey" id="btnBack">回會員後台首頁</button>

<script type="text/javascript">

$( document ).ready(function() {
	$("#submit").attr("disabled", true);
	count = 0;
})	
	let count = 0;
	
	// 返回會員後台首頁
	$('#btnBack').click(function() {
		window.location.href = '<c:url value="/backend/members/query" />';
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
	         count++;
	     	// 判斷密碼和電話是否格式正確後才給送出
	 		console.log(count);
	 		if (count>=2){
	 			$("#submit").attr("disabled", false);
	 		}
//	         $("#submit").attr("disabled", false);
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
        	 count++;
        	// 判斷密碼和電話是否格式正確後才給送出
     		console.log(count);
     		if (count>=2){
     			$("#submit").attr("disabled", false);
     		}
//        	 $("#submit").attr("disabled", false);
         
         } else {
        	 spanPhone.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 格式不正確";
        	 spanPhone.style.color = "red";
        	 spanPhone.style.fontSize = "0.8em";
        	 $("#submit").attr("disabled", true);
         }
	})

	// 修改資料
	$('form#modelAttribute2').submit(function(event) {
		event.preventDefault();
	
		$.ajax({
			url: '${formUrl2}',
			type: 'POST',
			data: $('form#modelAttribute2').serialize(),
			success: function(data, textStatus, xhr) {
				alert("修改成功");
				window.location.replace('${queryPageUrl}');
			},
			error: function(xhr, textStatus, exception){
				alert("發生錯誤");
				window.location.href ="";
			}
		});
	});
	
</script>
