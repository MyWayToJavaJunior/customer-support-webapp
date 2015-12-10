<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        <!-- This line added for Eclipse -->
<%-- @elvariable id="ticket" type="ru.dendevjv.customer_support.Ticket" --%>
<%-- @elvariable id="ticketId" type="java.lang.String" --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Support</title>
</head>
<body>

    <a href="<c:url value="/login?logout" />">Logout</a><br />
    
    <h2>Ticket #${ticketId}: <c:out value="${ticket.subject}" /></h2>
    <i>Customer name - <c:out value="${ticket.customerName}" /></i><br/><br/>
    <c:out value="${ticket.body}" /><br/>
    <br/>
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
    
    <a href="<c:url value="/tickets" />">Return to list tickets</a>
</body>
</html>