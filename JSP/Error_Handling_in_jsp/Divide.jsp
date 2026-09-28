<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="Error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String n="ind";
String m="30";

int a = Integer.parseInt(n);
int b = Integer.parseInt(m);

int ans=a/b;

out.println("Division : "+ans);
%>

</body>
</html>
