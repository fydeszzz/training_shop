<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="urlPrefix" value="/systemProperty" />
<c:url var="formUrl" value="${urlPrefix}/query" />

<style>
*{
	text-align:center;
}
.sysTable{
	left:0;
	right:0;
	margin:auto;
	width:50%;
}
.btnOut{
	position:absolute;
	right:20px;
	top:20px;
	width:50px;
	background:darkred;
	font-size:16px;
	font-weight:bold;
	color:white;
}
#btnMem{
	position:absolute;
	right:100px;
	top:20px;
	width:120px;
	background:wheat;
	font-size:16px;
	font-weight:bold;
}

</style>

<script type="text/javascript">
$(function() {
	
	// 回到會員管理頁面
	$('#btnMem').click(function() {
		window.location.href = '/Module_Project/members';
	});
	
	// 查詢鈕
	$('#btnQuery').click(function() {
		var form = $('form#modelAttribute');
		form.find('input:text').each(function(){
		    $(this).val($.trim($(this).val()));
		});
		form.submit();
	});

	// 新增鈕
	$('#btnAdd').click(function() {
		window.location.href = '<c:url value="${urlPrefix}/add" />';
	});
	
	// 修改鈕
	$('button[id=btnUpdate]').click(function() {
		window.location.href = '<c:url value="${urlPrefix}/{0}/update" />'.replace(/\{0\}/, $(this).attr('rel'));
	});
	
	// 刪除鈕
	$('button[id=btnDelete]').click(function() {
		var id = $(this).attr('rel');
		if (confirm('確定刪除該筆資料?')) {
			var button = $('button:not(:disabled)');

			$.ajax({
				url: '<c:url value="${urlPrefix}/{0}/delete" />'.replace(/\{0\}/, id),
				type: 'POST',
				timeout: 30000,
				beforeSend: function(xhr) {
					button.prop('disabled', true);
				},
				success: function(data, textStatus, xhr) {
					console.log(data);
					if (data == '') {
						alert('<spring:message code="text.deletion.success" />');
						$('#btnQuery').click();
					} else {
						alert(data);
						button.prop('disabled', false);
					}
				},
				error: function(xhr, textStatus, exception){
					alert('<spring:message code="text.deletion.failure" />');
					button.prop('disabled', true);
				}
			});
		}
		
		return false;
	});
});
</script>

<h2>SDSD3 - 系統管理</h2>

<form:form modelAttribute="modelAttribute" method="POST" action="${formUrl}">
	系統：<form:input path="system" autofocus="autofocus" />
	屬性名稱：<form:input path="name" />
	&nbsp;<button type="button" id="btnQuery" class="btn btn-primary">查詢</button>
	&nbsp;<button type="button" id="btnAdd" class="btn btn-primary">新增</button>
</form:form>
<p/>

<!-- Back to systemProperty -->
<p>
	<button id="btnMem">回到會員管理</button>
</p>

<!-- Logout -->
<p>
	<button class="btnOut" onclick="location.href='${pageContext.request.contextPath}/logout'">登出</button>
</p>

<c:if test="${not empty queryResult}">
	<table border="1" class="sysTable">
		<thead>
			<tr role="row">
				<th width="5%">No.</th>
				<th width="20%">系統</th>
				<th width="20%">屬性</th>
				<th width="20%">屬性值</th>
				<th></th>
			</tr>
		</thead>
		<tbody role="alert" aria-live="polite" aria-relevant="all">
		
		<c:forEach var="item" items="${queryResult}" varStatus="status">
			<tr class="${(status.index % 2 == 0) ? 'odd' : 'even'}">
				<td>${status.index + 1}</td>
				<td>${item.system}</td>
				<td><a href='<c:url value="${urlPrefix}/${item.id}/view" />'>${item.name}</a></td>
				<td>${item.value}</td>
				<td>
					<button id="btnUpdate" rel="${item.id}" href="#">修改</button>
					<button id="btnDelete" rel="${item.id}" href="#">刪除</button>
				</td>
			</tr>
		</c:forEach>
		
		</tbody>
	</table>
</c:if>

