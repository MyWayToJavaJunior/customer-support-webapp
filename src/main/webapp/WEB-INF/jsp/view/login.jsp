<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Support</title>
</head>
<body>

    <h2>Login</h2>
    You must log in to access the customer support site.<br /><br />
    
    <%
        if (((Boolean) request.getAttribute("loginFailed"))) {
            %><b>The username or password you entered are not correct. Please try again.</b><br /><br /><%
        }
    %>
    
    <form method="post" action="<c:url value="/login" />">
        Username<br />
        <input type="text" name="username" /><br /><br />
        Password<br />
        <input type="password" name="password" /><br /><br />
        <input type="submit" value="Log in" />
    </form>

</body>
</html>