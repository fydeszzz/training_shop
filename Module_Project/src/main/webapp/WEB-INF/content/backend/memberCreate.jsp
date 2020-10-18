<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="urlPrefix2" value="/backend/members" />
<c:url var="queryPageUrl" value="${urlPrefix2}/query" />
<c:url var="BackendUrl" value="${urlPrefix2}" />

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
	      <tr class="w3-lime">
	        <th colspan="2">
	        	<span style="font-weight:bold">新增會員</span>
	        </th>
	      </tr>
    </thead>
		<tbody>
			<tr>
				<td>帳號：</td>
				<td>
					<form:input path="account" id="account" size="20" maxlength="12" required="required" autofocus="autofocus" />
					<span id="spanAccount"></span>
				</td>
			</tr>
			<tr>
				<td>密碼：</td>
				<td>
					<form:input type="password" id="password" path="password" size="20" maxlength="12" required="required" />
					<span id="spanPwd"></span>
				</td>
			</tr>
		</tbody>
	<tr>
		<td colspan="2" style="text-align:center">
		<button type="submit" id="sentForm">送出</button>
		<button type="reset">取消</button>
		</td>
	</tr>
	</table>
</form:form>

<button class="w3-btn w3-blue-grey" id="btnBack">回會員後台首頁</button>

<script type="text/javascript">

// 回會員後台首頁
$('#btnBack').click(function() {
	window.location.href = '${queryPageUrl}';
});

//帳號名稱檢查(英文數字混合)
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
					$("#sentForm").attr("disabled", true);
				}
			},
			error: function(xhr, textStatus, exception){
				alert("發生錯誤，請重新嘗試");
				$("#sentForm").attr("disabled", true);
			}
		});
	   
   } else {
	   spanAccount.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 格式不正確";
	   spanAccount.style.color = "red";
	   spanAccount.style.fontSize = "0.8em";
	   $("#sentForm").attr("disabled", true);
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
         $("#sentForm").attr("disabled", false);
     } else {
         spanPwd.innerHTML = "<img src='${pageContext.request.contextPath}/resources/img/incorrect.png' height='15' width='15'> 格式不正確";
         spanPwd.style.color = "red";
         spanPwd.style.fontSize = "0.8em";
         $("#sentForm").attr("disabled", true);
     }
})

// 送出後回到查詢頁並更新
$('form#modelAttribute2').submit(function(event) {
	event.preventDefault();

	$.ajax({
		url: '${formUrl2}',
		type: 'POST',
		data: $('form#modelAttribute2').serialize(), 
		success: function(data, textStatus, xhr) {	
			alert("新增成功");
			window.location.replace('${queryPageUrl}');
		},
		error: function(xhr, textStatus, exception){
			alert("發生錯誤，請重新嘗試");
			window.location.href ="";
		}
	});
});

</script>
