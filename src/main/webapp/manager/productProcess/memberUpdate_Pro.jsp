<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="LoginDB.LoginDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<% request.setCharacterEncoding("utf-8");%>



<jsp:useBean id="member" scope="page" 
     class="LoginDB.LoginDataBean">
</jsp:useBean>

<%
 String memberId=  request.getParameter("memberId");
int loginNum=  Integer.parseInt((request.getParameter("loginNum")));
String memberName=  request.getParameter("memberName");
String memberPw=  request.getParameter("memberPw");
String memberEmail=  request.getParameter("memberEmail");
String memberAddr=  request.getParameter("memberAddr");


String memberPhone=  request.getParameter("memberPhone");
 
member.setMemberPw(memberPw);  
member.setMemberName(memberName);
member.setMemberPhone(memberPhone);
member.setMemberEmail(memberEmail);
member.setMemberAddr(memberAddr);




LoginDBBean LoginProcess = LoginDBBean.getInstance();
LoginProcess.updateMember(member, memberId); 

response.sendRedirect("/BomBom/manager/productProcess/memberList.jsp?loginNum="+loginNum);



%>