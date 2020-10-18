<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<c:set var="resourcesUrl" value="${pageContext.request.contextPath}/resources" scope="request" />
<c:set var="jsUrl" value="${resourcesUrl}/js" scope="request" />

<tiles:importAttribute name="title" />

<!DOCTYPE html>
<html>
<head>
    <title>${title}</title>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    
<script src="${jsUrl}/jquery-3.1.1.min.js" type="text/javascript"></script>
</head>
<body>
   <tiles:insertAttribute name="contentLayout" />
</body>
</html>
