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
            margin-right: 10px;
        }

        .container {
            max-width: 1000px;
            max-height: 3000px;
            margin: 100px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .row {
            height: 2000px; /* 원하는 높이 값으로 설정 */
			text-align:center;
        }
        .left-aligned {
  		  display: flex;
   			 align-items: center;
		}

		.right-aligned {
   			 margin-left: auto;
		}
    </style>
</head>
<body>
<% 
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
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
%>
<div class="navbar">
    <div class="left-aligned">
        <a href="main.jsp">JSP 게시판 웹 사이트</a>
        <ul>
            <li>
                <a href="main.jsp">메인</a>
            </li>
            <li class="<c:if test='${pageContext.request.servletPath == "/bbs.jsp"}'>active</c:if>">
                <a href="bbs.jsp">게시판</a>
            </li>
        </ul>
    </div>
    <%-- 로그인 여부에 따라 표시되는 내용 --%>
    <c:choose>
        <%-- 로그인되지 않은 경우 --%>
        <c:when test="${empty userID}">
            <div class="right-aligned">
                <a href="login.jsp">로그인</a>
                <a href="join.jsp">회원가입</a>
            </div>
        </c:when>
        <%-- 로그인된 경우 --%>
        <c:otherwise>
            <div class="right-aligned">
                <a href="logoutAction.jsp">로그아웃</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
<div class="container" >
    <div class="row">
        <table  style="text-align: center; border: 1px solid #dddddd">
            <thead>
                <tr>
                    <th colspan="3" style="background-color: #eeeeee; text-align: center; width:990px;">게시판 글보기</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="width: 20%; height:50px; ">글제목</td>
                    <td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                </tr>
                <tr>
                    <td>작성자</td>
                    <td colspan="2"><%= bbs.getUserID() %></td>
                </tr>
                <tr>
                    <td>작성일자</td>
                    <td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분 " %></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                </tr>
            </tbody>
        </table>
        <a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if (userID != null && userID.equals(bbs.getUserID())) {
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
    </div>
</div>
</body>
</html>