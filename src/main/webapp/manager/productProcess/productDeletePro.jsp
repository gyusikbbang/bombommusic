<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "Manager.ShopProductDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<%
   int proCode = Integer.parseInt(request.getParameter("proCode"));
   String proCate = request.getParameter("proCate");
 
  ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
  productProcess.deleteProduct(proCode); 

  response.sendRedirect("productList.jsp?proCate=all");
%>