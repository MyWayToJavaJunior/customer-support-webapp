<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        <!-- This line added for Eclipse -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  <!-- This line added for Eclipse -->
<%-- @elvariable id="ticketDatabase" type="java.util.Map<java.lang.Integer, ru.dendevjv.customer_support.Ticket>" --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Support</title>
</head>
<body>

    <a href="<c:url value="/login?logout" />">Logout</a><br />
    
    <h2>Tickets</h2>
    
    <a href="<c:url value="/tickets">
        <c:param name="action" value="create" />
    </c:url>">Create Ticket</a><br/>
    <br/>

    <c:choose>
        <c:when test="${fn:length(ticketDatabase) == 0}">
            <i>There are no tickets in the system.</i>
        </c:when>
        <c:otherwise>
            <c:forEach items="${ticketDatabase}" var="entry">
                Ticket ${entry.key}: <a href="<c:url value="/tickets">
                    <c:param name="action" value="view" />
                    <c:param name="ticketId" value="${entry.key}" />
                </c:url>"><c:out value="${entry.value.subject}" /></a>
                (customer: <c:out value="${entry.value.customerName}" />)<br />
            </c:forEach>
        </c:otherwise>
    </c:choose>

</body>
</html>