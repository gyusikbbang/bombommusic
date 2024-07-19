<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="LoginDB.LoginDBBean" %>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<head>
<title>로그인</title>
</head>
<body>
  <div class="container">
    <nav class="navbar navbar-dark bg-primary">
        <div class="container-fluid">  
          <span class="navbar-brand mb-0 h1"><i class="bi bi-microsoft"></i><a href="main.jsp" class="btn btn-primary btn-xs">JEON홈페이지</a></span>
            <div class="d-grid gap-1 d-md-flex justify-content-md-end my-2" style="float:right;" role="group" aria-label="Basic radio toggle button group">
              <a href="sessionLoginForm.jsp" class="btn btn-dark btn-xs"> 로그인</a>  
              <a href="list-bban.jsp" class="btn btn-dark btn-xs"> 자유게시판</a>
            </div>
        </div>
    </nav> 
  <form method="post" action="insertMemberPro.jsp">
    <h2 style="text-align: center;">회원가입</h2>
    <div class="form-group" style="padding:10px;">
      <input type="email" name="memberEmail" class="form-control" placeholder="이메일" maxlength="20">
    </div>
    <div class="form-group" style="padding:10px;">
      <input type="text" name="memberId" class="form-control" placeholder="아이디" maxlength="20">
    </div>
    <div class="form-group" style="padding:10px;">
      <input type="password" name="memberPw" class="form-control" placeholder="비밀번호" maxlength="20">
    </div>
    <div class="form-group" style="padding:10px;">
      <input type="text" name="memberName" class="form-control" placeholder="이름" maxlength="20">
    </div>
    <div class="form-group" style="padding:10px;">
      <input type="text" name="memberPhone" class="form-control" placeholder="전화번호" maxlength="20">
    </div>
    <div class="form-group" style="padding:10px;">
      <input type="text" name="memberAddr" class="form-control" placeholder="주소" maxlength="20">
    </div>
    <div class="form-group" style="padding:3px;">
      <input type="submit" class="btn btn-primary form-control" style="width:500px;height:40px" value="회원가입">
    </div>
    <div class="form-group" style="padding:3px;">
      <input type="reset" class="btn btn-primary form-control" style="width:500px;height:40px" value="다시입력">
    </div>
  </form>
</body>
</html>