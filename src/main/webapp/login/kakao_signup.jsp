<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="LoginDB.LoginDBBean" %>
<%@ page import="LoginDB.LoginDataBean" %>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="member" class="LoginDB.LoginDataBean">
  <jsp:setProperty name="member" property="*"/>
</jsp:useBean>
 
<%
  int Check = 0;
  String memberId = request.getParameter("memberId");
  String memberName = request.getParameter("memberName");
  
  member.setBombompoint(0);

  member.setMember_reg(new Timestamp(System.currentTimeMillis()));
  member.setLoginNum(2);
  member.setMemberName(memberName);
  member.setMemberPhone("kakao"); 
  member.setMemberAddr("kakao");
  LoginDBBean logon = LoginDBBean.getInstance();
  Check = logon.insertMember(member, memberId);



  if (Check == -1) {
   
%>
    <script>

      alert("생성 완료 로그인 해주세요.");
      location.href = "../login/login.jsp";
    </script>
<%
  } else {
%>
    <script>
    alert("이미있는 아이디 입니다 로그인해주세요");
    location.href = "../login/login.jsp";
    </script>
<%
  }
%>

