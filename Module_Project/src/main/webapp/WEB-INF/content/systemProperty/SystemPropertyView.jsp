<%-- $Id: SystemPropertyView.jsp 94 2018-04-17 01:59:14Z rex_wu $ --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	$('#btnBack').click(function() {
		window.location.href = '<c:url value="/systemProperty/query" />';
	});
});
</script>

<table class="systemTable">
	<tbody>
		<tr>
			<td>系統：</td>
			<td>${fn:escapeXml(modelAttribute.system)}</td>
		</tr>
		<tr>
			<td>屬性名稱：</td>
			<td>${fn:escapeXml(modelAttribute.name)}</td>
		</tr>
		<tr>
			<td>屬性值：</td>
			<td>${fn:escapeXml(modelAttribute.value)}</td>
		</tr>
	</tbody>
</table>
<p>
	<button type="button" id="btnBack">回查詢頁</button>
</p>

