<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="urlPrefix" value="/backend/orderManage" />
<c:url var="OrderUrl" value="${urlPrefix}" />

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
.w3-table-all{
	left:0;
	right:0;
	margin:auto;
	top:100px;
	width:50%;
	position:absolute;
}
</style>

<form:form modelAttribute="modelAttribute" method="POST">
<table class="w3-table-all">
	<tbody>
	<thead>
	      <tr class="w3-cyan">
	        <th colspan="3">
	        	<span style="font-weight:bold">修改訂單資料</span>
	        </th>
	      </tr>
    	</thead>
		<tr>
			<td>訂單編號：</td>
			<td>${modelAttribute.id}</td>
		</tr>
		<tr>
			<td>會員編號：</td>
			<td>${modelAttribute.member_id}</td>
		</tr>
		<tr>
			<td>收件人名稱：</td>
			<td><form:input type="text" path="member_name" required="required" maxlength="10"></form:input></td>
		</tr>
		<tr>
			<td>連絡電話：</td>
			<td><form:input type="text" path="phone" required="required" maxlength="10"></form:input></td>
		</tr>
		<tr>
			<td>配送地址：</td>
			<td>
			<form:input type="text" path="address" required="required" size="50"></form:input>
		</tr>
		<tr>
			<td>付款方式：</td>
			<td>${modelAttribute.method.method}
			</td>
		</tr>
		<tr>
			<td>配送狀態：</td>
			<td>
			<form:select path="status">
				<form:option value="1">尚未配送</form:option>
				<form:option value="2">配送中</form:option>
				<form:option value="3">已送達</form:option>
				<form:option value="4">取消訂單</form:option>
			</form:select>
			</td>
		</tr>
		<tr>
			<td>訂單產生日期：</td>
			<td><fmt:formatDate value="${modelAttribute.order_date}" type="both"/></td>
		</tr>
		
		<tr>
			<td colspan="2"><button type="submit">確認修改</button></td>
		</tr>
	</tbody>
</table>
</form:form>

<p>
	<button id="btnBack" class="w3-btn w3-blue-grey">回訂單後台首頁</button>
</p>

<script type="text/javascript">

	// 返回查詢頁
	$('#btnBack').click(function() {
		window.location.href = '<c:url value="/backend/orderManage" />';
	});
	
	// 修改資料
	$('form#modelAttribute').submit(function(event) {
		event.preventDefault();
	
		$.ajax({
			url: '${formUrl}',
			type: 'POST',
			data: $('form#modelAttribute').serialize(),
			success: function(data, textStatus, xhr) {
				alert("修改成功");
				window.location.replace('${OrderUrl}');
			},
			error: function(xhr, textStatus, exception){
				alert("發生錯誤");
				window.location.href ="";
			}
		});
	});
	
</script>
