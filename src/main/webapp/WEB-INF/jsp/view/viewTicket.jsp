<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        <%-- This line added for Eclipse --%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/template" %>         <%-- This line added for Eclipse --%>
<%@ taglib prefix="fmtdates" uri="http://www.wrox.com/jsp/tld/wrox" %>  <%-- This line added for Eclipse --%>
<%-- @elvariable id="ticket" type="ru.dendevjv.customer_support.Ticket" --%>
<%-- @elvariable id="ticketId" type="java.lang.String" --%>
<template:basic htmlTitle="${ticket.subject}" bodyTitle="Ticket #${ticketId}: ${ticket.subject}">
    <i>Customer name - <c:out value="${ticket.customerName}" /><br/>
    Created <fmtdates:formatDate value="${ticket.dateCreated}" type="both" timeStyle="long" dateStyle="full" /></i><br/><br/>
    
    <c:out value="${ticket.body}" /><br/><br/>
    
    <c:if test="${ticket.numberOfAttachments > 0}">
        Attachments:
        <c:forEach items="${ticket.attachments}" var="attachment" varStatus="status">
            <c:if test="${!status.first}">, </c:if>
            <a href="<c:url value="/tickets">
                    <c:param name="action" value="download" />
                    <c:param name="ticketId" value="${ticketId}" />
                    <c:param name="attachment" value="${attachment.name}" />
                </c:url>"><c:out value="${attachment.name}" /></a>
        </c:forEach><br /><br />
    </c:if>
    
</template:basic>
