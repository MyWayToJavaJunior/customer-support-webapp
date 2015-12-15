<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        <%-- This line added for Eclipse --%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/template" %>         <%-- This line added for Eclipse --%>
<%@ taglib prefix="fmtdates" uri="http://www.wrox.com/jsp/tld/wrox" %>  <%-- This line added for Eclipse --%>
<%-- @elvariable id="timestamp" type="long" --%>
<%-- @elvariable id="numberOfSessions" type="int" --%>
<%-- @elvariable id="sessionList" type="java.util.List<javax.servlet.http.HttpSession>" --%>

<template:basic htmlTitle="Active Sessions" bodyTitle="Active Sessions">
    There are a total of ${numberOfSessions} active sessions in this application.<br /><br />
    
    <c:forEach items="${sessionList}" var="s">
        <c:out value="${s.id} - ${s.getAttribute('username')}" />
        <c:if test="${s.id ==  pageContext.session.id}">&nbsp;(you)</c:if>
        &nbsp;- last active
        ${fmtdates:timeIntervalToString(timestamp - s.lastAccessedTime)} ago<br />
    </c:forEach>
</template:basic>
