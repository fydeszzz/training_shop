<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="isNew" value="${empty modelAttribute.id}" />
<c:set var="functionText" value="${isNew ? '新增' : '修改'}" />

<c:set var="urlPrefix" value="/systemProperty" />
<c:choose>
	<c:when test="${isNew}"><c:url var="formUrl" value="${urlPrefix}/add" /></c:when>
	<c:otherwise><c:url var="formUrl" value="${urlPrefix}/${modelAttribute.id}/update" /></c:otherwise>
</c:choose>
<c:url var="queryPageUrl" value="${urlPrefix}/query" />

<c:set var="resultMainCode" value="${isNew ? 'creation' : 'modification'}" />

<style>
*{
	text-align:center;
}
.systemTable{
	left:0;
	right:0;
	margin:auto;
}
</style>

<script type="text/javascript">
$(function() {
	// 送出表單
	$('form#modelAttribute').submit(function(event) {
		//移除表單欄位兩側空白
		$(this).find(':text').each(function(){
		    $(this).val($.trim($(this).val()));
		});
		
		event.preventDefault();
		
		var buttons = $('button:not(:disabled)');
		$.ajax({
			url: '${formUrl}',
			type: 'POST',
			timeout: 30000,
			data: $('form#modelAttribute').serialize(),
			beforeSend: function(xhr) {
				buttons.prop('disabled', true);
			},
			success: function(data, textStatus, xhr) {
				if (data == '') {
					alert('<spring:message code='text.${resultMainCode}.success' />');
					window.location.replace('${queryPageUrl}');
				} else {
					alert(data);
					buttons.prop('disabled', false);
				}
			},
			error: function(xhr, textStatus, exception){
				alert('<spring:message code='text.${resultMainCode}.failure' />');
				buttons.prop('disabled', false);
			}
		});
	});

	// 回查詢頁
	$('#btnBack').click(function() {
		window.location.href = '${queryPageUrl}';
	});
});
</script>

<form:form modelAttribute="modelAttribute" method="POST">
	<form:hidden path="id" />

	<table class="systemTable">
		<tbody>
			<tr>
				<td>系統：</td>
				<td>
					<form:input path="system" size="50" maxlength="32" required="required" autofocus="autofocus" />
				</td>
			</tr>
			<tr>
				<td>屬性名稱：</td>
				<td>
					<form:input path="name" size="50" maxlength="128" required="required" />
				</td>
			</tr>
			<tr>
				<td>屬性值：</td>
				<td>
					<form:input path="value" size="50" maxlength="512" required="required" />
				</td>
			</tr>
		</tbody>
	</table>
	<p>
		<button type="submit">送出</button>
		<button type="reset">取消</button>
		<button type="button" id="btnBack">回查詢頁</button>
	</p>
</form:form>

