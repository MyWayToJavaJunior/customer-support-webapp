<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        <%-- This line added for Eclipse --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  <%-- This line added for Eclipse --%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/template" %>         <%-- This line added for Eclipse --%>
<%@ taglib prefix="fmtdates" uri="http://www.wrox.com/jsp/tld/wrox" %>  <%-- This line added for Eclipse --%>
<%-- @elvariable id="ticketDatabase" type="java.util.Map<java.lang.Integer, ru.dendevjv.customer_support.Ticket>" --%>

<template:basic htmlTitle="Tickets" bodyTitle="Tickets">
    <c:choose>
        <c:when test="${fn:length(ticketDatabase) == 0}">
            <i>There are no tickets in the system.</i>
        </c:when>
        <c:otherwise>
            <c:forEach items="${ticketDatabase}" var="entry">
                Ticket ${entry.key}: <a href="<c:url value="/tickets">
                    <c:param name="action" value="view" />
                    <c:param name="ticketId" value="${entry.key}" />
                </c:url>"><c:out value="${fmtdates:abbreviateString(entry.value.subject, 60)}" /></a>
                <c:out value="${entry.value.customerName}" /> created ticket
                <fmtdates:formatDate value="${entry.value.dateCreated}" type="both" timeStyle="short" dateStyle="medium" /><br /><br />
            </c:forEach>
        </c:otherwise>
    </c:choose>
</template:basic>
