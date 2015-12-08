<%@ page import="ru.dendevjv.customer_support.Ticket, ru.dendevjv.customer_support.Attachment" %>
<%-- @elvariable id="ticket" type="ru.dendevjv.customer_support.Ticket" --%>
<%
    //String ticketId = request.getParameter("ticketId");
    Ticket ticket = (Ticket) request.getAttribute("ticket");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Support</title>
</head>
<body>

    <a href="<c:url value="/login?logout" />">Logout</a><br />
    
    <h2>Ticket #${param['ticketId'] }: ${ticket.subject}</h2>
    
    <i>Customer name - ${ticket.customerName}</i><br/><br/>
    
    ${ticket.body}<br/><br/>
    
    <% 
        if (ticket.getNumberOfAttachments() > 0) {
            %>Attachments: <%
            int i = 0;
            for (Attachment a : ticket.getAttachments()) {
                if (i++ > 0) {
                    out.print(", ");
                }
                %><a href="<c:url value="/tickets">
                    <c:param name="action" value="download" />
                    <c:param name="ticketId" value="${param['ticketId']}" />
                    <c:param name="attachment" value="<%= a.getName() %>" />
                </c:url>"><%= a.getName() %></a><br/><%
            }
        }
    %>
    
    <a href="<c:url value="/tickets" />">Return to list tickets</a>
</body>
</html>