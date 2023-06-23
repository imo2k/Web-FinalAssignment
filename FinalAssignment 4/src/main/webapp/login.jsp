<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            margin-right: 10px;
        }

        .container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
        <a href="main.jsp">메인</a>
        <a href="bbs.jsp">게시판</a>
        <a href="login.jsp" >로그인</a>
        <a href="join.jsp" >회원가입</a>
    </div>
    <div class="container">
        <h3>로그인 화면</h3>
        <form method="post" action="loginAction.jsp">
            <div class="form-group">
                <input type="text" placeholder="아이디" name="userID" maxlength="20">
            </div>
            <div class="form-group">
                <input type="password" placeholder="비밀번호" name="userPassword" maxlength="20">
            </div>
            <input type="submit" value="로그인">
        </form>
    </div>
</body>
</html>
