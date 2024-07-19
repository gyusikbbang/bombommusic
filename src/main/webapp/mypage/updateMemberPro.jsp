<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="LoginDB.LoginDataBean"%>
<%@ page import="LoginDB.LoginDBBean"%>
<%
    // 인코딩 설정
    request.setCharacterEncoding("UTF-8");
    
    // form에서 전송된 데이터 받기
    String memberId = request.getParameter("memberId");
    String memberPw = request.getParameter("memberPw");
    String memberName = request.getParameter("memberName");
    String memberPhone = request.getParameter("memberPhone");
    String memberEmail = request.getParameter("memberEmail");
    String memberAddr = request.getParameter("memberAddr");

    // 받은 데이터로 객체 생성
    LoginDataBean member = new LoginDataBean();
    member.setMemberId(memberId);
    member.setMemberPw(memberPw);
    member.setMemberName(memberName);
    member.setMemberPhone(memberPhone);
    member.setMemberEmail(memberEmail);
    member.setMemberAddr(memberAddr);

    try {
        // 로그인 DB Bean 생성 및 회원 정보 업데이트 메소드 호출
        LoginDBBean loginDBBean = LoginDBBean.getInstance();
        loginDBBean.updateMember(member);

        // 업데이트 완료 후, 원하는 페이지로 리다이렉트 (회원 정보 페이지로 이동)
        response.sendRedirect("../main/main.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
