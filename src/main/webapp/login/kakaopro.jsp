<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="LoginDB.LoginDBBean" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
    String memberId = request.getParameter("memberId");
    String memberPw = request.getParameter("memberPw");

	
    String memberName = request.getParameter("memberName");
    String memberEmail = request.getParameter("memberEmail");


    
    // 예시: 데이터베이스 처리
    LoginDBBean logon = LoginDBBean.getInstance();
    int check = logon.kakaocheck(memberId, memberPw);

    if (check == 1) {
        session.setAttribute("memberId", memberId);
		response.sendRedirect("/BomBom/main/main.jsp");
        // 인증 성공한 경우 추가 작업 수행
    } else {
        // 인증 실패한 경우 추가 작업 수행
        out.println("카카오톡 아이디가 없습니다. 회원가입을 먼저 해주세요.");
    }

%>