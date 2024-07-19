<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Cart.CartDataBean"%>
<%@ page import="Cart.CartDBBean"%>
<% 
	int cartNum = Integer.parseInt(request.getParameter("cartDelete"));
	
	CartDBBean cartProcess = CartDBBean.getInstance();
    cartProcess.deleteList(cartNum);
    
    response.sendRedirect("mypage_.jsp");

	
	
%>
