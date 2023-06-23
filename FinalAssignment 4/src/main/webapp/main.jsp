<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JSP 게시판 웹 사이트</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .navbar {
            background-color: #333;
            color: #fff;
            padding: 15px;
            display: flex;
            justify-content: space-between;
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            margin-right: 10px;
        }

        .navbar ul {
            display: flex;
            list-style: none;
            padding: 0;

        }

        .navbar ul li {
            margin-right: 10px;

        }

        .container {
            max-width: 1000px;
            margin: 100px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .row {
            height: 800px; /* 원하는 높이 값으로 설정 */
        }

        .container h3 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group input[type="submit"] {
            background-color: #337ab7;
            color: #fff;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="main.jsp">JSP 게시판 웹 사이트</a>
    <ul>
        <li class="<c:if test='${pageContext.request.servletPath == "/main.jsp"}'>active</c:if>">
            <a href="main.jsp">메인</a>
        </li>
        <li>
            <a href="bbs.jsp">게시판</a>
        </li>
    </ul>
    <%-- 로그인 여부에 따라 표시되는 내용 --%>
    <c:choose>
        <%-- 로그인되지 않은 경우 --%>
        <c:when test="${empty sessionScope.userID}">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="login.jsp" >로그인</a></li>
                <li><a href="join.jsp" >회원가입</a></li>
            </ul>
        </c:when>
        <%-- 로그인된 경우 --%>
		<c:otherwise>
    <%-- userID 가져오기 --%>
    <c:set var="userID" value="${sessionScope.userID}" />
    <%-- userID가 null이 아니면 로그아웃 표시 --%>
    <c:if test="${not empty userID}">
        <ul style="margin-left: auto; list-style: none;">
            <li style="display: inline-block; margin-left: 10px;">
                <a href="logoutAction.jsp">로그아웃</a>
            </li>
        </ul>
    </c:if>
</c:otherwise>
    </c:choose>
</div>
    <div class="container">
        <h3>JSP 게시판 웹 사이트에 오신 것을 환영합니다</h3>
        <p>글쓰기 게시판은 사용자들이 자유롭게 글을 작성하고 공유할 수 있는 공간입니다.</p>
        <p>여러분의 소중한 의견과 생각을 자유롭게 표현해보세요.</p>
        <a href="write.jsp" class="cta-button">글쓰기 시작하기</a>
    </div>
</body>
</html>