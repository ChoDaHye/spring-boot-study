<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>회원가입</title>
</head>
<body>
  <h1>Custom 회원가입 Page</h1>
  <h2><c:out value="${error}"/></h2>

  <form method='post' action="/member/joinProc">
      <!-- csrf 코드 -->
      <div>
        아이디: <input type='text' name='username'>
      </div>
      <div>
        암호: <input type='password' name='password'>
      </div>
      <div>
        이메일: <input type='text' name='email'>
      </div>
      <div>
        <input type='submit' value="회원가입">
      </div>
  </form>
</body>
</html>
