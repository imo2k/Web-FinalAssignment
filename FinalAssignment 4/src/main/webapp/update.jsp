<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
    line-height: 55px; /* Adjust the value as needed */
}

    </style>
</head>
<body>
	<% 
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않는 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("history.back()");
			script.println("</script>");
		}
	%>

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
        <%-- userID가 null이 아니면 회원관리 메뉴와 로그아웃 표시 --%>
        <c:if test="${not empty userID}">
            <ul style="margin-left: auto;">
                        <%-- 로그아웃 액션 --%>
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
            </ul>
        </c:if>
    </c:otherwise>
</c:choose>

</div>
<div class="container">
    <h3>게시판 글 수정</h3>
    <form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
        <div class="form-group">
            <input type="text"  placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"/>
        </div>
        <div class="form-group">
            <textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px"><%= bbs.getBbsContent() %></textarea>
        </div>
        <div class="form-group1">
            <input type="submit" value="게시글 수정" />
        </div>
    </form>
</div>
</body>
</html>