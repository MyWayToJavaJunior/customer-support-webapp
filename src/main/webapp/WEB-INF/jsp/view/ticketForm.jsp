<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Support</title>
</head>
<body>

<a href="<c:url value="/login?logout" />">Logout</a><br />

<h2>Create a Ticket</h2>

<form method="post" action="tickets" enctype="multipart/form-data">
    <input type="hidden" name="action" value="create" />
    Your name: <%= session.getAttribute("username") %><br/>
    
    Subject<br/>
    <input type="text" name="subject" /><br/><br/>
    
    Body<br/>
    <textarea name="body" rows="5" cols="30"></textarea><br/><br/>
    
    <b>Attachments</b><br/>
    <input type="file" name="file1"/><br/><br/>
    
    <input type="submit" value="Submit" />
</form>

</body>
</html>