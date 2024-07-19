<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="LoginDB.LoginDBBean" %>
<%@ page import="LoginDB.LoginDataBean" %>
<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="member" class="LoginDB.LoginDataBean">
    <jsp:setProperty name="member" property="*"/>
</jsp:useBean>
 
<%
String memberId = request.getParameter("memberId");

  member.setBombompoint(0);

  member.setMember_reg(new Timestamp(System.currentTimeMillis()) );
  member.setLoginNum(1);
  LoginDBBean logon = LoginDBBean.getInstance();
  logon.insertMember(member, memberId);

  
%>

<script>
  	alert("환연합니다. 회원가입 완료되었습니다.");
	location.href="../main/main.jsp";
</script>