<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "LoginDB.LoginDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
   String memberId =request.getParameter("memberId");
    int loginNum =  Integer.parseInt(request.getParameter("loginNum"));
 
    LoginDBBean LoginProcess = LoginDBBean.getInstance();
    LoginProcess.deleteMember(memberId); 

  response.sendRedirect("memberList.jsp?loginNum="+loginNum);
%>