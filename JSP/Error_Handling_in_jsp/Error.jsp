<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page isErrorPage = "true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
  String msg = "";


if(exception instanceof NumberFormatException ne){
	msg="Given Input is not valid..";
}
if(exception instanceof ArrayIndexOutOfBoundsException ae){
	msg="ARRAY's index not in range...";
}
%>

<font colour ="red">
problem : <%=msg %>
</font>

</body>
</html>
