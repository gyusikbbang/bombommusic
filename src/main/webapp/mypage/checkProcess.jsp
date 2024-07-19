<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="LoginDB.LoginDataBean"%>
<%@ page import="LoginDB.LoginDBBean"%>
<% 
	String memberId = request.getParameter("memberId");
	String passwd = request.getParameter("memberPw");
	LoginDBBean login = LoginDBBean.getInstance();
	
	int check = login.userCheck(memberId, passwd);
    
	if(check == 1){
		response.sendRedirect("./mypage3.jsp");
	}else{%>
		<script> 
		  alert("비밀번호가 맞지 않습니다.");
	      history.go(-1);
		</script>
		<% 
	}	
	
	
	
%>
