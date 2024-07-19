<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="LoginDB.LoginDBBean" %>
<% request.setCharacterEncoding("utf-8");%>

<%
	
	String id = request.getParameter("memberId");
	String passwd  = request.getParameter("memberPw"); 
	
	LoginDBBean login = LoginDBBean.getInstance();
    int check = login.userCheck(id, passwd);

	if(check==1){
		session.setAttribute("memberId", id);%>
		<script> 
		  	location.href="../main/main.jsp";
		</script>
	<%}else if(check==0){%>
	<script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	  history.back();
	</script>
<%}else{ %>
	<script>
	  alert("아이디가 맞지 않습니다..");
	  history.go(-1);
	  history.back();
	</script>
<%}%>