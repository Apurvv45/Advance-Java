<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
<%
String per=request.getParameter("per");
String gr=request.getParameter("gr");

String fname=(String)session.getAttribute("fn");
String lname=(String)session.getAttribute("ln");

session.invalidate();

%>

<h1>MARKSHEET</h1>

First name :<%= fname %> <br>
Last name : <%= lname %>  <br>
Percentage : <%= per %><br>
Grade : <%= gr %> <br>

</body>
</html>
