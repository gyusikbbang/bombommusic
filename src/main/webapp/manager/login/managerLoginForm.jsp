<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link href="/book/ch14bban/etc/style.css" rel="stylesheet">
<style>
html,
body {
  height: 100%;
}

body {
  display: flex;
  align-items: center;
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #f5f5f5;
}

.form-signin {
  max-width: 330px;
  padding: 15px;
}

.form-signin .form-floating:focus-within {
  z-index: 2;
}

.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}    
</style>
</head>
<body class="text-center">

<main class="form-signin w-100 m-auto">
    <form method="post" action="managerLoginPro.jsp">
        <h1 class="h3 mb-3 fw-normal"><i class="bi bi-file-person"></i> 관리자 로그인</h1>
    
        <div class="form-floating">
            <input type="text" class="form-control" name="id" id="id" placeholder="아이디">
            <label for="id">아이디</label>
        </div>
        <div class="form-floating">
            <input type="password" class="form-control" name="passwd" id="passwd" placeholder="비밀번호" style="color:transparent;">
            <label for="passwd">비밀번호</label>
        </div>
    
        <button class="w-100 btn btn-lg btn-primary" type="submit"><i class="bi bi-pencil-square"></i> 로그인</button>
        <p class="mt-5 mb-3 text-muted">&copy; 2017–2022</p>
    </form>
</main>
</body>
</html>