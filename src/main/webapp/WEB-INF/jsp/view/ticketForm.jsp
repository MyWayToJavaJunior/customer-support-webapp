<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/template" %>         <%-- This line added for Eclipse --%>
<template:basic htmlTitle="Create a Ticket" bodyTitle="Create a Ticket">

    <form method="post" action="tickets" enctype="multipart/form-data">
        <input type="hidden" name="action" value="create" />
        Your name: ${sessionScope['username']}<br/>
        
        Subject<br/>
        <input type="text" name="subject" /><br/><br/>
        
        Body<br/>
        <textarea name="body" rows="5" cols="30"></textarea><br/><br/>
        
        <b>Attachments</b><br/>
        <input type="file" name="file1"/><br/><br/>
        
        <input type="submit" value="Submit" />
    </form>

</template:basic>
