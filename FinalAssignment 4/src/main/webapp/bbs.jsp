<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
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
            max-height: 1000px;
            margin: 100px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .row {
            height: 600px;
        }

        table {
            width: 100%;
            overflow-y: scroll; 
        }

        table th,
        table td {
            padding: 10px;
        }

        table th:nth-child(1) {
            width: 10%;
        }

        table th:nth-child(2) {
            width: 40%;
        }

        table th:nth-child(3) {
            width: 20%;
        }

        table th:nth-child(4) {
            width: 30%;
        }

        .btn.btn-primary.pull-right {
            float: right;
            margin-top: 10px;
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

        /* Modified style */
        .notice-row td {
            background-color: #ffffcc;
            font-weight: bold;
        }
        
        .navbar .site-title {
    	line-height: 55px; /
}
    </style>
</head>
<body>
    <% 
        String userID = null;
        if (session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        int pageNumber = 1;
        if (request.getParameter("pageNumber") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        }

        BbsDAO bbsDAO = new BbsDAO();
        ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
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

        <%-- 로그인 여부에 따라 표시되는 내용 --%>
        <c:choose>
            <%-- 로그인되지 않은 경우 --%>
            <c:when test="${empty sessionScope.userID}">
                <a href="login.jsp" style="margin-right:auto; margin-top:16px;">로그인</a>
                <a href="join.jsp" style="margin-right:1450px; margin-top:15px">회원가입</a>
            </c:when>
            <%-- 로그인된 경우 --%>
            <c:otherwise>
                <%-- userID 가져오기 --%>
                <c:set var="userID" value="${sessionScope.userID}" />
                <%-- userID가 null이 아니면 회원관리 메뉴와 로그아웃 표시 --%>
                <c:if test="${not empty userID}">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="logoutAction.jsp" style="margin-top: 5px;">로그아웃</a>
                        </li>
                    </ul>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                    <tr>
                        <th style="background-color: #eeeeee; text-align: center;">번호</th>
                        <th style="background-color: #eeeeee; text-align: center;">제목</th>
                        <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                        <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Bbs bbs : list) { %>
                    <tr class="<c:if test='${bbs.getUserID() eq "manager"}'>notice-row</c:if>">
                        <td><%= bbs.getBbsID() %></td>
                        <td><a href="view.jsp?bbsID=<%= bbs.getBbsID() %>"><%= bbs.getBbsTitle() %></a></td>
                        <td><%= bbs.getUserID() %></td>
                        <td><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분 " %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% 
				if (pageNumber != 1) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>" class="btn" style="background-color: #5cb85c; color: #fff; margin-right: 10px;">이전</a>
			<%
				} if (bbsDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>" class="btn" style="background-color: #5cb85c; color: #fff;">다음</a>
			<%
				}
			%>
            <a href="write.jsp" class="btn btn-primary pull-right" >글쓰기</a>
        </div>
                    <div class="form-group" style="display: flex; align-items: center;">
                <select name="searchOption" style="flex: 1;">
                    <option value="title">제목</option>
                    <option value="content">내용</option>
                    <option value="writer">작성자</option>
                </select>
                <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요">
                <input type="submit" value="검색" style="flex: 1; margin-left: 10px;">
            </div>
    </div>
</body>
</html>