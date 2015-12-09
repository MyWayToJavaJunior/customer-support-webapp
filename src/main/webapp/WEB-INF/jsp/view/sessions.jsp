<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, javax.servlet.http.HttpSession" %>
<%-- @elvariable id="numberOfSessions" type="int" --%>
<%!
    private static String toString(long timeInterval) {
        if (timeInterval < 1_000) {
            return "less than one second";
        } else if (timeInterval < 60_000) {
            return (timeInterval / 1_000) + " seconds";
        } else {
            return "about " + (timeInterval / 60_000) + " minutes";
        }
    }
%>
<%
    @SuppressWarnings("unchecked")
    List<HttpSession> sessionList = (List<HttpSession>) request.getAttribute("sessionList");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Support</title>
</head>
<body>

    <a href="<c:url value="/login?logout" />">Logout</a><br />

    <h2>Sessions</h2>
    
    There are a total of ${numberOfSessions} active sessions in this application.<br /><br />
    
    <%
        long timeStamp = System.currentTimeMillis();
        for (HttpSession aSession : sessionList) {
            out.print(aSession.getId() + " - " + aSession.getAttribute("username"));
            if (aSession.getId().equals(session.getId())) {
                out.print(" (you)");
            }
            out.print(" - last active " + toString(timeStamp - aSession.getLastAccessedTime()));
            out.println(" ago<br />");
        }
    %>

</body>
</html>