<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>로그인</title>
</head>
<body>
  <h1>Custom Login Page</h1>
  <h2><c:out value="${error}"/></h2>
  <h2><c:out value="${logout}"/></h2>

  <!--
  <form method='post' action="/loginProc">
  -->
  <form method='post' action="/member/login">
      <div>
        <input type='text' name='username' value=''>
      </div>
      <div>
        <input type='password' name='password' value=''>
      </div>
      <div>
      <!--
      <div>
        <input type='checkbox' name='remember-me'> Remember Me
      </div>
      -->
      <div>
        <input type='submit' value="로그인">
      </div>
  </form>
</body>
</html>
