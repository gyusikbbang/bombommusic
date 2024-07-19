<%@ page import = "Manager.ShopProductDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

   String proCode = request.getParameter("proCode");

%>

<%
  




  ShopProductDBBean ProductProcess = ShopProductDBBean.getInstance();
 
  int insert =  ProductProcess.mdPickInsert(Integer.parseInt(proCode)); 
  ProductProcess.mdPickInsert(Integer.parseInt(proCode));
  
  
  if (insert == 0) {
	out.print("이미있습니다");  
  } else {
	  out.print("생성완료");
  }
  
%>