<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="users.UsersDAO" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그아웃</title>
</head>
<body>
<%
    // 로그아웃 시 세션의 userID 정보 제거
    session.removeAttribute("userID");

%>
<script>
    location.href = 'main.jsp';
</script>
</body>
</html>