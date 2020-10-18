<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="urlPrefix" value="/Module_Project" />

<div>
Menu
<a href="${urlPrefix}/systemProperty">SystemProperty</a>
<a href="${urlPrefix}/member">Member</a>
<a href="${urlPrefix}/logout" id="logout">登出</a>
</div>
