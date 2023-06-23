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
        	
		margin-right:10px;
            
        }

        .container {
            max-width: 1000px;
            max-height: 1000px;
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
            box-sizing: border-box;
        }

        .form-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: none; /* 사용자가 크기 조정할 수 없도록 설정 */
            box-sizing: border-box; /* 내용의 패딩과 테두리를 포함한 크기로 설정 */
            height: 250px; /* 초기 높이 값 */
        }

		.form-group1 {
			text-align: right;
		}
		
		.form-group1 input[type="submit"] {
        font-size: 16px; 
        padding: 12px 24px;
    	}
        .navbar .site-title {
    	line-height: 55px; /
		}



    </style>
</head>
<body>
<div class="navbar">
    <a href="main.jsp" class="site-title">JSP 게시판 웹 사이트</a>
    <ul>
        <li>
            <a href="main.jsp">메인</a>
        </li>
        <li class="<c:if test='${pageContext.request.servletPath == "/bbs.jsp"}'>active</c:if>">
            <a href="bbs.jsp">게시판</a>
        </li>
    </ul>

    <%-- 로그인 여부에 따라 표시되는 내용 --%>
    <c:choose>
        <%-- 로그인되지 않은 경우 --%>
        <c:when test="${empty sessionScope.userID}">
            <a href="login.jsp" style="margin-left: auto;">로그인</a>
            <a href="join.jsp">회원가입</a>
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
    <h3>글쓰기</h3>
    <form method="post" action="writeAction.jsp">
        <div class="form-group">
            <input type="text"  placeholder="글 제목" name="bbsTitle" maxlength="50" required />
        </div>
        <div class="form-group">
            <textarea  placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px" required></textarea>
        </div>
        <div class="form-group1">
            <input type="submit" value="글쓰기" />
        </div>
    </form>
</div>
</body>
</html>