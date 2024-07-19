<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Manager.ShopProductDBBean"%>

<% request.setCharacterEncoding("utf-8");%>

<%
    String managerId = request.getParameter("id");
	String passwd  = request.getParameter("passwd");
	
	ShopProductDBBean manager = ShopProductDBBean.getInstance();
    int check = manager.managerCheck(managerId,passwd); 

   
    ShopProductDBBean productprocess = ShopProductDBBean.getInstance();
    String name  = productprocess.ManagerName(managerId);

    
    
    
	if(check == 1){
		session.setAttribute("managerId",managerId);
		session.setAttribute("name", name);
		response.sendRedirect("../managerMain.jsp");
	}else if(check == 0){%>
    <script> 
	  alert("비밀번호가 맞지 않습니다.");
      history.go(-1);
	</script>
<% }else{ %>
	<script>
	  alert("아이디가 맞지 않습니다..");
	  history.go(-1);
	</script>
<% }%>